(use srfi-13 defstruct srfi-69 matchable vector-lib medea matchable data-structures)

(define (contains? x l)
  (vector-fold (lambda (i x0 y) (or x0 y)) #f (vector-map (lambda (i x0) (equal? x x0)) l)))

; this function is a bit like the the "string-map" except, instead of using a
; function mapping each char to another char, it uses a function on each
; single length string that maps from string -> string (regardless of length)
(define (string-fleximap f s)
  (string-fold-right (lambda (c d) (string-append (f (string c)) d)) "" s))

(defstruct lsystem variables constants axiom rules)

; takes an l-system and returns a function that returns a function that acts on
; a string, returning the next iteration
(define (lsystem->function ls)
  (lambda (s) (string-fleximap (lambda (x) (cond
                                             ((contains? x (lsystem-constants ls)) x)
                                             ((contains? x (lsystem-variables ls)) (alist-ref x (lsystem-rules ls) equal?))
                                             (else (error "String contains invalid l-system character, please make sure string is of a valid type."))))
                               s)))

; iteration function for l-systems that recursively applies l-system function
; onto the initial string, this is tail recursive
(define (lsystem-iter ls n)
  (define ls-func (lsystem->function ls))
  (define (lsi s n0)
    (if (= n0 0) s (lsi (ls-func s) (- n0 1))))
  (lsi (lsystem-axiom ls) n))

(define (alist-map f alist)
    (map (match-lambda ((key . values) (f key values))) alist))

(define (alist->jsonsafe-alist al)
  (alist-map (lambda (k v) `(,(string->symbol k) . ,v)) al))

(define (jsonsafe-alist->list al)
  (alist-map (lambda (k v) `(,(symbol->string k) . ,v)) al))
