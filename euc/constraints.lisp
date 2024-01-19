(module euc)

(defconst 
  MAX_INPUT_LENGTH 8)

(defconstraint first-row (:domain {0})
  (vanishes! IOMF))

(defconstraint heartbeat ()
  (if-zero IOMF
           (begin (vanishes! DONE)
                  (vanishes! (next CT)))
           (begin (eq! (next IOMF) 1)
                  (if-zero (- CT_MAX CT)
                           (begin (eq! DONE 1)
                                  (vanishes! (next CT)))
                           (begin (vanishes! DONE)
                                  (will-inc! CT 1))))))

(defconstraint ctmax ()
  (eq! (~ (- CT MAX_INPUT_LENGTH))
       1))

(defconstraint last-row (:domain {-1})
  (if-not-zero IOMF
               (eq! DONE 1)))

(defconstraint counter-constancies ()
  (counter-constancy CT CT_MAX))

(defconstraint byte-decomposition ()
  (begin (byte-decomposition CT DIVIDEND DIVIDEND_BYTE)
         (byte-decomposition CT DIVISOR DIVISOR_BYTE)
         (byte-decomposition CT QUOTIENT QUOTIENT_BYTE)
         (byte-decomposition CT REMAINDER REMAINDER_BYTE)))

(defconstraint result (:guard DONE)
  (begin (eq! DIVIDEND
              (+ (* DIVISOR QUOTIENT) REMAINDER))
         (if-zero REMAINDER
                  (eq! CEIL QUOTIENT)
                  (eq! CEIL (+ QUOTIENT 1)))))


