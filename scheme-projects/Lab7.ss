(define call/cc call-with-current-continuation)

(define multiplycc
  (lambda (l)
    (let ((halt (call/cc (lambda (k) k))))
      (if (procedure? halt)
        (letrec 
          ((multiply (lambda (n)
            (if (null? n)
              1
              (if (zero? (car n))
                (halt 0)
                (* (car n) (multiply (cdr n))))))))
          (multiply l))
        halt))))
