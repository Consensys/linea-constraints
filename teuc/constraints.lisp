(module teuc)

(defconst 
  MAX_INPUT_LENGTH 8)

(defconstraint first-row (:domain {0})
  (vanishes! IOMF))

(defconstraint heartbeat ()
  (if-zero IOMF
           (begin (vanishes! DONE)
                  (vanishes! (next CT)))
           (begin (eq! (next IOMF) 1)
                  (if-zero (- CT CT_MAX)
                           (begin (vanishes! DONE)
                                  (will-inc! CT 1))
                           (begin (eq! DONE 1)
                                  (vanishes! (next CT)))))))

(defconstraint ctmax ()
  (eq! (~ (- CT MAX_INPUT_LENGTH))
       1))

(defconstraint last-row (:domain {-1})
  (eq! DONE 1))

(defconstraint byte-decomposition ()
  (begin (byte-decomposition CT DIVIDEND DIVIDEND_BYTE)
         (byte-decomposition CT DIVISOR DIVISOR_BYTE)
         (byte-decomposition CT QUOTIENT QUOTIENT_BYTE)
         (byte-decomposition CT REST REST_BYTE)))

(defconstraint result (:guard DONE)
  (begin (eq! DIVIDEND
              (+ (* DIVISOR QUOTIENT) REST))
         (if-zero REST
                  (eq! CEIL QUOTIENT)
                  (eq! CEIL (+ QUOTIENT 1)))))


