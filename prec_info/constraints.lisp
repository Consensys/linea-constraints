(module prec_info)

(defconst
  MODEXP_CYCLE 15
  NON_MODEXP_CYCLE 4
  MAX_STAMP_JUMP 4294967296)

(defpurefun (if-not-eq X Y Z)
  (if-not-zero (- X Y) Z))

(defunalias if-zero-else if-zero)

(defunalias doesnt-vanish is-zero)

(defpurefun (differ X Y)
  (doesnt-vanish (- X Y)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                ;;
;;    3.2 Constancy conditions    ;;
;;                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (flag-sum)(+ EC_RECOVER SHA2 RIPEMD IDENTITY MODEXP EC_ADD EC_MUL EC_PAIRING BLAKE))

(defun (stamp-consitency X)
  (if-eq (next STAMP) STAMP
         (will-remain-constant! X)))

;; 3.2.1
(defconstraint stamp-constancies ()
  (begin (stamp-consitency ADDR_LO)
         (stamp-consitency GAS_STPD)
         (stamp-consitency CALL_DATA_SIZE)
         (stamp-consitency CONSUMED_GAS)
         (stamp-consitency SUCCESS)
         (stamp-consitency PROVIDES_RETURN_DATA)
         (stamp-consitency TOUCHES_RAM)
         (stamp-consitency RETURN_DATA_SIZE)
         (stamp-consitency CALL_DATA_WORDS)
         (stamp-consitency MALFORMED_DATA)
         (stamp-consitency ENOUGH_GAS)
         (stamp-consitency BLAKE_F)
         (stamp-consitency BLAKE_ROUNDS)))
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ;;
;;    3.3 Type conditions    ;;
;;                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3.3.1
(defconstraint exactly-one-type ()
  (if-not-zero STAMP
               (eq! (flag-sum) 1)))
  

;; 3.3.2
(defconstraint type-consistency ()
  (eq! ADDR_LO
       (+ EC_RECOVER
          (* 2 SHA2)
          (* 3 RIPEMD)
          (* 4 IDENTITY)
          (* 5 MODEXP)
          (* 6 EC_ADD)
          (* 7 EC_MUL)
          (* 8 EC_PAIRING)
          (* 9 BLAKE))))
  

;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;    3.5 Hearbeat    ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint first-row (:domain {0})
  (vanishes! STAMP))
  

(defconstraint null-stamp ()
  (if-zero STAMP
           (begin (vanishes! COUNTER)
                  (vanishes! ADDR_LO)
                  (vanishes! SUCCESS))))
  

(defconstraint first-counter-is-zero ()
  (if-zero STAMP (will-eq! COUNTER 0)))
  

(defconstraint counter-behaviour ()
  (begin  ;; in case of modexp
    (if-not-zero MODEXP
                 (begin (if-eq-else COUNTER MODEXP_CYCLE
                                    (will-eq! COUNTER 0)
                                    (will-inc! COUNTER 1))))
    ;; in case of non-modexp
    (if-not-zero (- (flag-sum) MODEXP)
                 (begin (if-eq-else COUNTER NON_MODEXP_CYCLE
                                    (will-eq! COUNTER 0)
                                    (will-inc! COUNTER 1))))))
          

(defconstraint stamp-behaviour ()
  (if-not-zero (next STAMP)
               (if-zero-else (next COUNTER)
                             (will-change! STAMP)
                             (will-remain-constant! STAMP))))
  

(defconstraint small-jumps-for-stamp ()
  (if-zero (next COUNTER)
           (begin (eq! WCP_ARG1_LO
                       (- (next STAMP) STAMP))
                  (eq! WCP_ARG2_LO MAX_STAMP_JUMP)
                  (eq! WCP_RES 1))))
  

(defconstraint finalization-constarints (:domain {-1})
  (begin ;; in case of modexp
         (if-not-zero MODEXP (eq! COUNTER MODEXP_CYCLE))
         ;; in case of non modexp
         (if-not-zero (- (flag-sum) MODEXP)
                      (eq! COUNTER NON_MODEXP_CYCLE))))
  
