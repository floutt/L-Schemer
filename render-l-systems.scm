(include "l-systems-operations.scm")
(use simple-graphics data-structures)

(define (list-iter f l)
  (cond
    ((null? l))
    (else (begin (f (car l)) (list-iter f (cdr l))))))

; takes an l-system string and, given a specific rule table, will render out the
; desired result through turtle graphics (to a certain scale)
(define (render-ruleset scale s ruleset)
  (list-iter (lambda (c) (eval (scalize scale (alist-ref (string c) ruleset equal?)))) (string->list s)))

(define (render-easy scale ls iter ruleset)
  (render-ruleset scale (lsystem-iter ls iter) ruleset))

(define (direction? s)
  (or (equal? 'left s) (equal? 'right s)))

(define (scalize scale l)
  (define (sclz l state)
    (if (not (null? l)) (define f (car l)))
    (cond
      ((null? l) '())
      ((list? f) (cons (sclz f 0) (sclz (cdr l) 0)))
      ((symbol? f) (if (direction? f) (cons f (sclz (cdr l) 0))  (cons f (sclz (cdr l) 1))))
      ((number? f) (if (= state 1) (cons (* scale f) (sclz (cdr l) 0)) (cons f (sclz (cdr l) 0))))))
  (sclz l 0))
