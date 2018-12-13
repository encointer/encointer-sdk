;; unit tests for simple-token
;; (C) Alain Brenzikofer, encointer.org

(put ':message 'originator "tom")
(put ':contract 'id "contract1")
(put ':contract 'state "contract-state")

(define tc (make-instance simple-token))

;; -----------------------------------------------------------------
(define (result-print msg . args)
  (display msg)
  (for-each (lambda (a) (write a)) args)
  (newline))

(define agent-keys (make-instance signing-keys))

(display "TEST simple-token contract\n")
(catch error-print
       (display "TEST: eve creates tokens without beeing contract originator\n")
       (catch error-print (send tc 'fiat-tokens 99999 '(:message originator "eve")))

       (display "TEST: tom creates 2000 tokens\n")
       (send tc 'fiat-tokens 2000 '(:message originator "tom"))

       (display "TEST: tom wants to send too much\n")
       (put ':message 'originator "tom")
       (catch error-print (send tc 'send-tokens "alice" 10000))

       (display "TEST: query total supply\n")
       (result-print "total token supply = " (send tc 'get-token-supply))

       (display "TEST: tom sends 100 to alice\n")
       (send tc 'send-tokens "alice" 100)
       (result-print "tom has: " (send tc 'get-balance "tom")) ;; '(:message originator "tom")))
       (result-print "alice has: " (send tc 'get-balance "alice" '(:message originator "alice")))

       (display "TEST: tom tries to query alice's balance\n")
       (catch error-print (send tc 'get-balance "alice" '(:message originator "tom")))

       (display "TEST: alice sends 5 to bob\n")
       (send tc 'send-tokens "bob" 5 '(:message originator "alice"))
       (result-print "alice has: " (send tc 'get-balance "alice" '(:message originator "alice")))
       (result-print "bob has: " (send tc 'get-balance "bob" '(:message originator "bob")))
)
(display "TEST simple-token contract DONE\n")
