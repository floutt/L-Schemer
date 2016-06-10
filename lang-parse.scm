(include "render-l-systems.scm")
(include "json-parser.scm")

(use irregex simple-graphics utils srfi-13 srfi-69 data-structures extras)

(define (whitespace-split s)
  (irregex-split (irregex "\\s") s))

(define (help)
  (display (read-all "content/help.txt")))

(define fun-tokens '("LEFT" "RIGHT" "FORWARD" "BACKWARD" "IMPORT" "RENDER" "CLEAR" "PEN-UP" "PEN-DOWN" "SAVE" "HELP"))
(define fun-hash (alist->hash-table
                   `(("LEFT" . ,(lambda (x) (cond ((null? x) (left))
                                                  ((< 1 (length x)) (arity-error))
                                                  (else (left (string->number (car x)))))))
                     ("RIGHT" . ,(lambda (x) (cond ((null? x) (right))
                                                  ((< 1 (length x)) (arity-error))
                                                  (else (right (string->number (car x)))))))
                     ("FORWARD" . ,(lambda (x) (if (or (null? x) (< 1 (length x))) 
                                                 (arity-error) 
                                                 (forward (string->number (car x))))))
                     ("BACKWARD" . ,(lambda (x) (if (or (null? x) (< 1 (length x))) 
                                                  (arity-error) 
                                                  (backward (string->number (car x))))))
                     ("IMPORT" . ,(lambda (x) (if (or (null? x) (< 3 (length x))) 
                                                (arity-error)
                                                (cond ((string=? "JSON" (car x)) (if (= 3 (length x)) 
                                                                                   (hash-table-set! json-hash (list-ref x 2) (json->lsystem (read-all (list-ref x 1))))
                                                                                   (hash-table-set! json-hash (extract-filename (list-ref x 1)) (json->lsystem (read-all (list-ref x 1))))))
                                                      ((string=? "RULESET" (car x)) (if (= 3 (length x)) 
                                                                                      (hash-table-set! ruleset-hash (list-ref x 2) (read-file (list-ref x 1)))
                                                                                      (hash-table-set! ruleset-hash (extract-filename (list-ref x 1)) (read-file (list-ref x 1)))))))))
                     ("RENDER" . ,(lambda (x) (if (= (length x) 3) (render-easy (string->number (list-ref x 1)) 
                                                                                (hash-table-ref json-hash (car x)) (string->number (list-ref x 2)) (hash-table-ref ruleset-hash (car x))) 
                                                (arity-error))))
                     ("CLEAR" . ,(lambda (x) (if (null? x) (clear) (arity-error))))
                     ("PEN-UP" . ,(lambda (x) (if (null? x) (pen-up) (arity-error))))
                     ("PEN-DOWN" . ,(lambda (x) (if (null? x) (pen-down) (arity-error))))
                     ("SAVE" . ,(lambda (x) (if (null? x) (save) (arity-error))))
                     ("HELP" . ,(lambda (x) (if (null? x) (help) (arity-error)))))))

(define json-hash (make-hash-table))
(define ruleset-hash (make-hash-table))

(define (member? x l)
  (not (equal? #f (member x l))))

(define (list-eval l)
  (if (not (null? l)) (define f (car l)))
  (if (member? f fun-tokens) ((hash-table-ref fun-hash f) (cdr l)) (display (string-append 
                                                                              "ERROR: Invalid token \"" f "\". Please type in the \"HELP\" command for more assistance.\n"))))

(define (arity-error)
  (display "ERROR: Arity mismatch.\n"))

(define (lang-eval l)
  (list-eval (whitespace-split l)))

(define (extract-filename s)
  (car (string-split s ".")))
