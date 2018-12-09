;; Copyright 2018 Alain Brenzikofer, encointer.org

(define-macro (assert pred . message)
  `(if (not ,pred) (throw ,@message)))

(define-class nctr-hello-world
  (instance-vars
   (creator (get ':message 'originator))))

(define-const-method nctr-hello-world (get-key key)
  (assert (string? key) "key must be a string" key)
  (key-value-get key))

(define-method nctr-hello-world (put-key key value)
  (assert (string? key) "key must be a string" key)
  (assert (string? value) "value must be a string" value)
  (key-value-put key value)
  #t)

(define-method nctr-hello-world (del-key key)
  (assert (string? key) "key must be a string" key)
  (key-value-delete key)
  #t)


