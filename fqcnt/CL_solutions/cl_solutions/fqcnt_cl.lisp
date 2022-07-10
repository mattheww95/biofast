#! /usr/bin/sbcl --script
(load "/home/mattheww/.sbclrc") 


;;(load "~/quicklisp/setup.lisp")
;;(ql:quickload "asdf")

;;(ql:quickload "cl-ppcre")

(require "cl-ppcre")

;; function to open plain text file and read it line by line
(defun plain-text-fq (fp)
    "Open a plain text file and read it line by line"
    (let ((in (open fp)))
        (when in
            (loop for line = (read-line in)
                while line do (format t "~a~%" line))
        (close in)))
)

(defun plain-text-fq-2 (fp)
    "An alternative way of reading a file in lisp"
    (with-open-file (stream fp)
        (loop for line = (read-line stream nil)
            while line
            collect line)))



(defun cmd-line-args (args)
    "Read in the command line arguments and open with correct file handler"
    (let ((file-arg (cdr args)))
    (if (not file-arg) 
    (progn (format t "~&~S~&" "No file input") (exit))
    (cl-ppcre:split "." file-arg)
    )
    (eval file-arg))
)

;;(format t "~&~S~&" (reverse (setf out (cmd-line-args sb-ext:*posix-argv*))))
(plain-text-fq "../../../biofast-data-v1/M_abscessus_HiSeq.fq")