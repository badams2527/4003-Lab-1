(define int-builder$
  (lambda (n)
    (cons n (lambda () 
              (int-builder$ (+ n 1))))))

(define filter-out-mults$
  (lambda (num lst)
    (if (= (modulo (car lst) num) 0)
        (filter-out-mults$ num ((cdr lst)))
        (cons (car lst) (lambda () (filter-out-mults$ num ((cdr lst))))))))

(define take$
    (lambda (m s)
      (if (or (= m 0) (null? s))
          '()
          (cons (car s) (take$ (- m 1) ((cdr s)))))))

(define sieve$
    (lambda (lst)
      (cons (car lst) (lambda () (sieve$ (filter-out-mults$ (car lst) ((cdr lst))))))))

(define stol$
    (lambda (n) 
      (take$ n (sieve$ (int-builder$ 2)))))

(take$ 10 (int-builder$ 2))
;Value: (2 3 4 5 6 7 8 9 10 11)

(take$ 10 (filter-out-mults$ 2 (int-builder$ 2)))
;Value: (3 5 7 9 11 13 15 17 19 21)
(take$ 10 (filter-out-mults$ 3 (filter-out-mults$ 2 (int-builder$ 2))))
;Value: (5 7 11 13 17 19 23 25 29 31)

(take$ 10 (sieve$ (int-builder$ 2)))
;Value: (2 3 5 7 11 13 17 19 23 29)

(stol$ 100)
