(load "render-l-systems.scm")
(load "lang-parse.scm")
(use utils)

(define (loop)
  (begin 
    (display "lshll> ")
    (lang-eval (read-line))
    (loop)))

(if (not (null? (command-line-arguments))) 
  (begin (list-iter lang-eval (read-lines (car (command-line-arguments))))
         (display (read-all "content/intro-message.txt")) (newline) (loop))
  (begin (display (read-all "content/intro-message.txt")) (newline) (loop)))
