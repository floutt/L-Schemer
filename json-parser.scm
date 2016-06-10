(include "l-systems-operations.scm")
(use medea data-structures ports)

(define (lsystem->json ls)
    (define (lsf n)
      (cond
        ((= n 1) (string-append "\"variables\":" (json->string (lsystem-variables ls)) ",\n" (lsf (+ n 1))))
        ((= n 2) (string-append "\"constants\":" (json->string (lsystem-constants ls)) ",\n" (lsf (+ n 1))))
        ((= n 3) (string-append "\"axiom\":" (json->string (lsystem-axiom ls)) ",\n" (lsf (+ n 1))))
        ((= n 4) (string-append "\"rules\":" (json->string (alist->jsonsafe-alist (lsystem-rules ls))) "\n"))))
  (string-append "{\n"
                 (lsf 1) "}\n"))

(define (json->lsystem js)
  (define al (with-input-from-string js read-json) )
  (make-lsystem variables: (alist-ref 'variables al equal?)
                constants: (alist-ref 'constants al equal?)
                axiom: (alist-ref 'axiom al equal?)
                rules: (jsonsafe-alist->list (alist-ref 'rules al equal?))))
