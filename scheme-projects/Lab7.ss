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

(define pl
      (lambda (l)
         (if (null? l)
             '()
             (begin (display (car l)) (pl (cdr l))))))

(define plcc
  (lambda (l)
    (if (null? l)
      (remove-from-round-robin)
      (begin (step-and-swap (car l)) (pl (cdr l))))))

(define main
  (lambda lst
    (map (lambda (x) (create pl x)) lst)
    (demand-tokens)))

(define demand-tokens
  (lambda ()
    (let ((temp (demand)))
      (if (null? temp) '() (cons temp (demand-tokens))))))
