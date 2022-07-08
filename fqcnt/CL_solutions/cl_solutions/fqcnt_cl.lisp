;;;;  A common lisp solution for counting symbols in a fastq file can be gzipped



(ql:quickload :cl-ppcre)

(defun cmd-line-args ()
    "Read in the command line arguments and open with correct file handler"
    (setf file-arg (car *args*))
    (if (not file-arg) 
    (progn (format t "~&~S~&" "No file input") (exit))
    (cl-ppcre:split "." file-arg)
    )
    (eval file-arg)
)

(format t "~&~S" (reverse (setf out (cmd-line-args))))