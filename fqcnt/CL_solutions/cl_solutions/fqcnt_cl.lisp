#! /usr/bin/sbcl --script
(load "/home/mattheww/.sbclrc") 


;;(load "~/quicklisp/setup.lisp")
;;(ql:quickload "asdf")

(ql:quickload "cl-ppcre")
;;(require "cl-ppcre")
(defun cmd-line-args (args)
    "Read in the command line arguments and open with correct file handler"
    (let ((file-arg (car args)))
    (if (not file-arg) 
    (progn (format t "~&~S~&" "No file input") (exit))
    (cl-ppcre:split "." file-arg)
    )
    (eval file-arg))
)

(format t "~&~S~&" (reverse (setf out (cmd-line-args sb-ext:*posix-argv*))))