(define call/cc call-with-current-continuation)

(define amb-fail (lambda () (error 'no-solution)))
 
(define-syntax amb
  (syntax-rules ()
    ((amb alt ...)
     (let ((prev-amb-fail amb-fail))
          (call/cc 
            (lambda (sk)
              (call/cc 
                (lambda (fk)
                  (set! amb-fail (lambda ()
                                   (set! amb-fail prev-amb-fail)
                                   (fk 'fail)))
                  (sk alt)))
              ...
              (prev-amb-fail)))))))

(define assert (lambda (pred) (if (not pred) (amb))))

(define distinct?
  (lambda (n l)
    (if (null? l)
        #t
        (if (= n (car l))
            #f
            (distinct? n (cdr l))))))

(define s11 0)
(define s12 0)
(define s13 0)
(define s14 0)

(define s21 0)
(define s22 0)
(define s23 0)
(define s24 0)

(define s31 0)
(define s32 0)
(define s33 0)
(define s34 0)

(define s41 0)
(define s42 0)
(define s43 0)
(define s44 0)

(define lab8
  (lambda ()
    (let* ((s11 (amb 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
          (s13 (amb 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
          (s14 (amb 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
          (s12 (- 34 (+ s14 s13 s11))) ;; row 1
          (s23 (amb 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
          (s32 (amb 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
          (s41 (- 34 (+ s14 s23 s32))) ;; diagonal
          (s44 (- 34 (+ s11 s14 s41))) ;; outer box
          (s22 (amb 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
          (s33 (- 34 (+ s32 s22 s23))) ;; inner box
          (s42 (- 34 (+ s32 s22 s12))) ;; column 2
          (s43 (- 34 (+ s13 s23 s33))) ;; column 3
          (s34 (amb 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
          (s24 (- 34 (+ s14 s34 s44))) ;; column 4
          (s31 (- 34 (+ s32 s33 s34))) ;; row 3
          (s21 (- 34 (+ s22 s23 s24))) ;; row 2
          )
    (assert (distinct? s14 (list s11 s12 s13 s21 s22 s23 s24 s31 s32 s33 s34 s41 s42 s43 s44)))
    (assert (distinct? s11 (list s14 s12 s13 s21 s22 s23 s24 s31 s32 s33 s34 s41 s42 s43 s44)))
    (assert (distinct? s12 (list s11 s14 s13 s21 s22 s23 s24 s31 s32 s33 s34 s41 s42 s43 s44)))
    (assert (distinct? s21 (list s11 s12 s13 s14 s22 s23 s24 s31 s32 s33 s34 s41 s42 s43 s44)))
    (assert (distinct? s22 (list s11 s12 s13 s21 s14 s23 s24 s31 s32 s33 s34 s41 s42 s43 s44)))
    (assert (distinct? s23 (list s11 s12 s13 s21 s22 s14 s24 s31 s32 s33 s34 s41 s42 s43 s44)))
    (assert (distinct? s31 (list s11 s12 s13 s21 s22 s23 s24 s14 s32 s33 s34 s41 s42 s43 s44)))
    (assert (distinct? s32 (list s11 s12 s13 s21 s22 s23 s24 s31 s14 s33 s34 s41 s42 s43 s44)))
    (assert (distinct? s33 (list s11 s12 s13 s21 s22 s23 s24 s31 s32 s14 s34 s41 s42 s43 s44)))
    (assert (distinct? s41 (list s11 s12 s13 s21 s22 s23 s24 s31 s32 s33 s34 s14 s42 s43 s44)))
    (assert (distinct? s42 (list s11 s12 s13 s21 s22 s23 s24 s31 s32 s33 s34 s41 s14 s43 s44)))
    (assert (distinct? s43 (list s11 s12 s13 s21 s22 s23 s24 s31 s32 s33 s34 s41 s42 s14 s44)))
    (assert (and (<= s12 16) (<= 1 s12)))
    (assert (and (<= s41 16) (<= 1 s41)))
    (assert (and (<= s44 16) (<= 1 s44)))
    (assert (and (<= s33 16) (<= 1 s33)))
    (assert (and (<= s42 16) (<= 1 s42)))
    (assert (and (<= s43 16) (<= 1 s43)))
    (assert (and (<= s24 16) (<= 1 s24)))
    (assert (and (<= s31 16) (<= 1 s31)))
    (assert (and (<= s21 16) (<= 1 s21)))
    (list (list s11 s12 s13 s14)
          (list s21 s22 s23 s24)
          (list s31 s32 s33 s34)
          (list s41 s42 s43 s44)))))
