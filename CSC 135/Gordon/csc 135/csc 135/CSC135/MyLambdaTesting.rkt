;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname MyLambdaTesting) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Assignment Q6 ----------------------------------------------------------------------------
;    Takes as input an integer N. It then builds and returns a "select" function based on N.

(define singleSelect          ; return a funtion which remove the first element of a list
  (lambda (L) (cdr L)))

(define (multiCompose n F)    ; return the power n of a function
  (if (= n 1) F
      (compose (multiCompose (- n 1) F) F)))  

(define (selectN n)           ; return a function with power n of the singleSelect function.  
  (lambda (L) ((multiCompose n singleSelect)L)))

;Testing:

(define Last (selectN 3))

(Last '(4 8 2 9 -1 13)) ; expects (9 -1 13)

(Last '(-2 3 -4 8 9 1 7)) ;expects (8 9 1 7)

;; Class Notes Build Series ----------------------------------------------------------------------------

(define (build a)
  (lambda(x)  ( cond ( (> a 0) (+ x a) )
                     ( (< a 0 )(* x (- 0 a) ) )
                     (else (* x x)))))

(define (multiCompose2 L)
   (if (null? (cdr L)) (car L)
      (compose (multiCompose2 (cdr L)) (car L))))

(define (buildSeries L)
  (lambda (x) ((multiCompose2 (map build L))x)))

;Testing
(define S ( buildSeries '(5 0 -4 -2 8) ) )

(S '4) ; expects 656

(S '-3) ; expects 40

(define (removeAtom a L)
  (cond ((null? L)
         '())
        ((list? (car L))
         (append(list(removeAtom a (car L))) (removeAtom a (cdr L))))
        ((= a (car L))
         (removeAtom a (cdr L)))
        (else
         (append(list(car L))(removeAtom a (cdr L))))))

(removeAtom '1 '(1 (1(2)2)))

(define (countDown n)
  (if (= 0 n ) '()
      (cons n (countDown (- n 1)))))

(countDown 9)

(define (countDownT n L)
  (if (= n 0) L
      (countDownT (- n 1) (append L (list n)))))

(countDownT 9 '())

(define (RcountDown n)
  (if (= n 0) '()
      (append (RcountDown (- n 1)) (list n))))

(define (squareList L)
  (if (null? L) '()
      (cons (*(car L)(car L)) (squareList (cdr L)))))

(RcountDown 9)

(squareList '(1 2 3 4 5))

(define (square