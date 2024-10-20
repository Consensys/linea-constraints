(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                               ;;;;
;;;;    X.5 Instruction handling   ;;;;
;;;;                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    X.5.27 Invalid   ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; NOTE: bytes from the invalid instruction family
;; (either not an opcode or the INVALID opcode)
;; can't raise stack exceptions

(defun (invalid-instruction---standard-hypothesis)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;
  (* PEEK_AT_STACK
     stack/INVALID_FLAG))

(defconstraint    invalid-instruction---setting-the-stack-pattern (:guard (invalid-instruction---standard-hypothesis))
                  (stack-pattern-0-0))

;; already enforced in automatic-exception-flag-vanishing constraint
;; TODO: this is debug
(defconstraint    invalid-instruction---setting-OPCX              (:guard (invalid-instruction---standard-hypothesis))
                  (eq!    stack/OPCX    stack/INVALID_FLAG))


;; TODO: this is debug
(defconstraint    invalid-instruction---setting-the-peeking-flags (:guard (invalid-instruction---standard-hypothesis))
                  (eq!    NSR
                          (*   CMC   (next PEEK_AT_CONTEXT))))

(defconstraint    invalid-instruction---setting-the-gas-cost      (:guard (invalid-instruction---standard-hypothesis))
                  (eq!    GAS_COST    stack/STATIC_GAS))

(defconstraint    invalid-instruction---debugging-constraints     (:guard (invalid-instruction---standard-hypothesis))
                  (begin
                    (eq!    CMC          1)
                    (eq!    XAHOY        1)
                    (eq!    stack/OPCX   1)))
