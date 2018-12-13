;;
;; simple-token.scm
;;
;; (C) Alain Brenzikofer, encointer.org

(require-when (member "debug" *args*) "debug.scm")
(require "contract-base.scm")
(require "escrow-counter.scm")
;;(require "indexed-key-store.scm")
(require "key-store.scm")
;;(require "persistent-key-store.scm")

(define dbg #f)
;; =================================================================
;; CLASS: simple-token
;; =================================================================
(define-class simple-token
  (super-class base-contract)
  (instance-vars
   (state #f)
   (count 0)
   (tokensupply 0)
  )
)

(define-method simple-token (initialize-instance . args)
  (if (not state)
      ;;(instance-set! self 'state (make-instance indexed-key-store))))
      (instance-set! self 'state (make-instance key-store))))

(define-method simple-token (get-token-supply) tokensupply)

(define-const-method simple-token (get-balance key)
  (let* ((requestor (get ':message 'originator))
         (balance (send state 'get key)))
    (assert (equal? key requestor) "only the owner may get his balance\n")
    (send state 'get key))
)

;; initialize money supply
(define-method simple-token (fiat-tokens value)
  (let* ((requestor (get ':message 'originator)))
    (if dbg ((display "token:fiat-tokens ") (display requestor) (display value) (display "\n")))
    (assert (or (null? creator) (equal? creator requestor)) "only creator may create new tokens\n")
;;  (let ((value (if (pair? initial-value) (coerce-number (car initial-value)) 0)))
;;    (assert (and (integer? value) (<= 0 value)) "initialization value must not be negative\n")
;;  (let* (balance (make-instance simple-balance))
    ;(send state 'set requestor (make-instance simple-balance (balance value) value))
    (send state 'set requestor value)
    (instance-set! self 'tokensupply value)
;;    (send state 'set "testkey" "55")
;;  )
;;      #t)
#t)
)

(define-method simple-token (send-tokens to amount)
  (let* ((from (get ':message 'originator)))
    (if dbg ((display from )(display " sends ") (display amount) (display " to ") (display to) (display "\n")))
    (let* ((bal-from (send state 'get from)))
      (assert (< amount bal-from) "not enough funds")
      ; see if "to" addr already has a balance
      (let* ((bal-to (if (send state 'exists? to)
                      (send state 'get to')
                      0)))
        (if dbg ((display "bal-from=") (display bal-from) (display "/bal-to=") (display bal-to)(display "\n")))
        (send state 'set from (- bal-from amount))
        (send state 'set to (+ bal-to amount))
      )
    )
  #t)
)
;;(define bal (make-instance simple-balance (balance 1212)))
;;(display bal)
;; -----------------------------------------------------------------
;; -----------------------------------------------------------------
(require-when (member "test-simple-token" *args*) "simple-token-test.scm")
