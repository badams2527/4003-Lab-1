(define int-builder
    (lambda (n)
      (if (= n 1)
          '()
          (append (int-builder (- n 1)) (cons n '())))))

(define filter-out-mults
    (lambda (num lst)
      (if (null? lst)
          '()
          (if (= (modulo (car lst) num) 0)
              (filter-out-mults num (cdr lst))
              (cons (car lst) (filter-out-mults num (cdr lst)))))))

(define sieve
    (lambda (lst)
      (if (null? lst)
          '()
          (cons (car lst) (sieve (filter-out-mults (car lst) (cdr lst)))))))

(define primes (lambda (n) (sieve (int-builder n))))

(define stol
    (lambda (m)
      (let ((lst (primes (* m 20))))
         (take m lst))))

(define take 
    (lambda (m lst)
      (if (= m 0)
	      '()
	      (cons (car lst) (take (- m 1) (cdr lst))))))

(int-builder 20)
;Value: (2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
(int-builder 10)
;Value: (2 3 4 5 6 7 8 9 10)

(filter-out-mults 2 (int-builder 20))
;Value: (3 5 7 9 11 13 15 17 19)
(filter-out-mults 3 '(3 5 7 9 11 13 15 17 19))
;Value: (5 7 11 13 17 19)
(filter-out-mults 5 '(5 7 11 13 17 19))
;Value: (7 11 13 17 19)
(filter-out-mults 7 '(7 11 13 17 19))
;Value: (11 13 17 19)

(stol 100)
