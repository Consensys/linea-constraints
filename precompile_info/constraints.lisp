(module precompile_info)

(defconst 
  MODEXP_CYCLE     15
  NON_MODEXP_CYCLE 3
  MAX_STAMP_JUMP   4294967296)

(defpurefun (if-not-eq X Y Z)
  (if-not-zero (- X Y)
               Z))

(defunalias 
  if-zero-else if-zero)

(defunalias 
  doesnt-vanish is-zero)

(defpurefun (differ X Y)
  (doesnt-vanish (- X Y)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                ;;
;;    3.2 Constancy conditions    ;;
;;                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (flag-sum)
  (+ EC_RECOVER SHA2 RIPEMD IDENTITY MODEXP EC_ADD EC_MUL EC_PAIRING BLAKE))

(defun (stamp-consitency X)
  (if-eq (next STAMP) STAMP (will-remain-constant! X)))

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
         (stamp-consitency BLAKE_ROUNDS)
         (stamp-consitency REQUIRES_ECDATA)))

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
;;    3.4 Hearbeat    ;;
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
  (if-zero STAMP
           (will-eq! COUNTER 0)))

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
               (if-zero-else (next COUNTER) (will-change! STAMP) (will-remain-constant! STAMP))))

(defconstraint small-jumps-for-stamp ()
  (if-zero (next COUNTER)
           (begin (eq! WCP_ARG1_LO
                       (- (next STAMP) STAMP))
                  (eq! WCP_ARG2_LO MAX_STAMP_JUMP)
                  (eq! WCP_RES 1))))

(defconstraint finalization-constraints (:domain {-1})
  (begin  ;; in case of modexp
         (if-not-zero MODEXP
                      (eq! COUNTER MODEXP_CYCLE))
         ;; in case of non modexp
         (if-not-zero (- (flag-sum) MODEXP)
                      (eq! COUNTER NON_MODEXP_CYCLE))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ;;
;;    3.5 Call Data Words    ;;
;;                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint call-data-words (:guard STAMP)
  (if-zero COUNTER
           (begin (eq! MOD_ARG1_LO (+ CALL_DATA_SIZE 31))
                  (eq! MOD_ARG2_LO 32)
                  (eq! MOD_RES CALL_DATA_WORDS))))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    3.6 Execution    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint enough-gas (:guard STAMP)
  (if-zero COUNTER
           (begin (will-eq! WCP_ARG1_LO CONSUMED_GAS)
                  (will-eq! WCP_ARG2_LO (+ GAS_STPD 1))
                  (will-eq! WCP_RES ENOUGH_GAS))))

(defconstraint execution-ecrecover ()
  (if-not-zero EC_RECOVER
               (begin (eq! CONSUMED_GAS 3000)
                      (eq! TOUCHES_RAM
                           (* ENOUGH_GAS (is-not-zero CALL_DATA_SIZE)))
                      (vanishes! MALFORMED_DATA))))

(defconstraint execution-sha2 ()
  (if-not-zero SHA2
               (begin (eq! CONSUMED_GAS
                           (+ 60 (* 12 CALL_DATA_WORDS)))
                      (eq! TOUCHES_RAM ENOUGH_GAS)
                      (vanishes! MALFORMED_DATA))))

(defconstraint execution-ripemd ()
  (if-not-zero RIPEMD
               (begin (eq! CONSUMED_GAS
                           (+ 600 (* 120 CALL_DATA_WORDS)))
                      (eq! TOUCHES_RAM ENOUGH_GAS)
                      (vanishes! MALFORMED_DATA))))

(defconstraint execution-identity ()
  (if-not-zero IDENTITY
               (begin (eq! CONSUMED_GAS
                           (+ 15 (* 3 CALL_DATA_WORDS)))
                      (eq! TOUCHES_RAM PROVIDES_RETURN_DATA)
                      (vanishes! MALFORMED_DATA))))

(defconstraint execution-modexp-0 ()
  (if-not-zero MODEXP
               (vanishes! MALFORMED_DATA)))

(defconstraint execution-modexp-empty-calldata ()
  (if-not-zero MODEXP
               (if-zero CALL_DATA_SIZE
                        (begin (eq! CONSUMED_GAS 200)
                               (vanishes! TOUCHES_RAM)
                               (if-zero COUNTER
                                        (vanishes! (shift MODEXP_PARAMS 5)))))))

(defun (modexp-running)
  (* MODEXP CALL_DATA_SIZE))

(defconstraint execution-modexp-1 (:guard (modexp-running))
  (eq! TOUCHES_RAM 1))

(defconstraint execution-modexp-2 (:guard (modexp-running))
  (if-not-zero COUNTER
               (begin (eq! (shift WCP_ARG1_LO 2) (shift MODEXP_PARAMS 1))
                      (eq! (shift WCP_ARG2_LO 2) (shift MODEXP_PARAMS 5)))))

(defconstraint execution-modexp-3 (:guard (modexp-running))
  (if-zero COUNTER
           (begin (will-eq! MOD_ARG1_LO
                            (+ 7
                               (* (shift WCP_RES 2) (shift MODEXP_PARAMS 5))
                               (* (- 1 (shift WCP_RES 2))
                                  (next MODEXP_PARAMS))))
                  (will-eq! MOD_ARG2_LO 8))))

(defconstraint execution-modexp-4 (:guard (modexp-running))
  (if-zero-else COUNTER
                (eq! MODEXP_BYTE_ACC MODEXP_BYTES)
                (eq! MODEXP_BYTE_ACC
                     (+ (* 256 (prev MODEXP_BYTE_ACC))
                        MODEXP_BYTES))))

(defconstraint execution-modexp-5 (:guard (modexp-running))
  (if-zero COUNTER
           (if-zero-else (shift MODEXP_PARAMS 6)
                         (eq! (shift MODEXP_BYTE_ACC 15) (shift MODEXP_PARAMS 7))
                         (eq! (shift MODEXP_BYTE_ACC 15) (shift MODEXP_PARAMS 6)))))

(defconstraint execution-modexp-6 (:guard (modexp-running))
  (if-zero-else MODEXP_BYTE_ACC (vanishes! MODEXP_BYTE_SWITCH) (eq! MODEXP_BYTE_SWITCH 1)))

(defconstraint execution-modexp-7 (:guard (modexp-running))
  (begin (if-zero COUNTER
                  (eq! MODEXP_BYTE_SWITCH_INDEX MODEXP_BYTE_SWITCH))
         (if-not-eq COUNTER
                    15
                    (will-eq! MODEXP_BYTE_SWITCH_INDEX
                              (+ MODEXP_BYTE_SWITCH_INDEX (next MODEXP_BYTE_SWITCH))))))

(defconstraint execution-modexp-8 (:guard (modexp-running))
  (begin (if-zero COUNTER
                  (if-eq MODEXP_BYTE_SWITCH 1 (eq! MODEXP_E_LEADING_WORD_FIRST_BYTE MODEXP_BYTES)))
         (if-zero MODEXP_BYTE_SWITCH
                  (if-eq-else COUNTER 15
                              (eq! MODEXP_E_LEADING_WORD_FIRST_BYTE MODEXP_BYTES)
                              (if-eq (next MODEXP_BYTE_SWITCH) 1
                                     (eq! MODEXP_E_LEADING_WORD_FIRST_BYTE (next MODEXP_BYTES)))))))

(defconstraint execution-modexp-9 (:guard (modexp-running))
  (begin (if-zero-else COUNTER
                       (vanishes! MODEXP_BIT_ACC)
                       (eq! MODEXP_BIT_ACC
                            (+ (* 2 (prev MODEXP_BIT_ACC))
                               MODEXP_BITS)))
         (if-eq COUNTER 15 (eq! MODEXP_BIT_ACC MODEXP_E_LEADING_WORD_FIRST_BYTE))))

(defconstraint execution-modexp-10 (:guard (modexp-running))
  (if-zero-else MODEXP_BIT_ACC (vanishes! MODEXP_BIT_SWITCH) (eq! MODEXP_BIT_SWITCH 1)))

(defconstraint execution-modexp-11 (:guard (modexp-running))
  (begin (if-zero COUNTER
                  (eq! MODEXP_BIT_SWITCH_INDEX MODEXP_BIT_SWITCH))
         (if-not-eq COUNTER
                    15
                    (will-eq! MODEXP_BIT_SWITCH_INDEX
                              (+ MODEXP_BIT_SWITCH_INDEX (next MODEXP_BIT_SWITCH))))))

(defconstraint execution-modexp-12 (:guard (modexp-running))
  (if-zero COUNTER
           (if-zero-else (shift MODEXP_PARAMS 6)
                         (eq! MODEXP_E_LEADING_WORD_BIT_LENGTH
                              (+ 128
                                 (* 8
                                    (shift MODEXP_BYTE_SWITCH_INDEX (- 15 1)))
                                 (shift MODEXP_BIT_SWITCH_INDEX 15)))
                         (eq! MODEXP_E_LEADING_WORD_BIT_LENGTH
                              (+ (* 8
                                    (shift MODEXP_BYTE_SWITCH_INDEX (- 15 1)))
                                 (shift MODEXP_BIT_SWITCH_INDEX 15))))))

(defconstraint execution-modexp-13 (:guard (modexp-running))
  (if-zero-else MODEXP_E_LEADING_WORD_BIT_LENGTH
                (vanishes! MODEXP_E_LEADING_WORD_LOG)
                (eq! MODEXP_E_LEADING_WORD_LOG (- MODEXP_E_LEADING_WORD_BIT_LENGTH 1))))

(defconstraint execution-modexp-14 (:guard (modexp-running))
  (if-zero COUNTER
           (begin (eq! (shift WCP_ARG1_LO 3) 32)
                  (eq! (shift WCP_ARG2_LO 3) (shift MODEXP_PARAMS 3)))))

(defconstraint execution-modexp-15 (:guard (modexp-running))
  (if-zero COUNTER
           (eq! MODEXP_LE_PRIME
                (+ (* 8
                      (shift WCP_RES 3)
                      (- (shift MODEXP_PARAMS 3) 32))
                   MODEXP_E_LEADING_WORD_LOG))))

(defconstraint execution-modexp-16 (:guard (modexp-running))
  (if-zero-else MODEXP_LE_PRIME
                (eq! MODEXP_MAX_LE_PRIME_AND_1 1)
                (eq! MODEXP_MAX_LE_PRIME_AND_1 MODEXP_LE_PRIME)))

(defconstraint execution-modexp-17 (:guard (modexp-running))
  (if-zero COUNTER
           (begin (eq! (shift MOD_ARG1_LO 2) (* MOD_RES MOD_RES MODEXP_MAX_LE_PRIME_AND_1))
                  (eq! (shift MOD_ARG2_LO 2) 3)
                  (eq! (shift MOD_RES 2) MODEXP_BIG_FRACTION))))

(defconstraint execution-modexp-18 (:guard (modexp-running))
  (if-zero COUNTER
           (begin (eq! (shift WCP_ARG1_LO 4) 200)
                  (eq! (shift WCP_ARG2_LO 4) MODEXP_BIG_FRACTION))))

(defconstraint execution-modexp-19 (:guard (modexp-running))
  (if-zero COUNTER
           (eq! CONSUMED_GAS
                (+ (* (shift WCP_RES 4) MODEXP_BIG_FRACTION)
                   (* (- 1 (shift WCP_RES 4))
                      200)))))

(defconstraint execution-ecadd ()
  (if-not-zero EC_ADD
               (begin (eq! CONSUMED_GAS 150)
                      (eq! TOUCHES_RAM ENOUGH_GAS)
                      (eq! MALFORMED_DATA (- 1 EC_DATA_CHECKS_PASSED)))))

(defconstraint execution-ecmul ()
  (if-not-zero EC_MUL
               (begin (eq! CONSUMED_GAS 6000)
                      (eq! TOUCHES_RAM ENOUGH_GAS)
                      (eq! MALFORMED_DATA (- 1 EC_DATA_CHECKS_PASSED)))))

(defconstraint execution-ecpairing ()
  (if-not-zero EC_PAIRING
               (begin (if-zero COUNTER
                               (begin (eq! (shift MOD_ARG1_LO 3) CALL_DATA_SIZE)
                                      (eq! (shift MOD_ARG2_LO 3) 192)
                                      (eq! (shift MOD_RES 3) PAIRING_COUNT)))
                      (if-eq-else CALL_DATA_SIZE (* 192 PAIRING_COUNT)
                                  (begin (eq! CONSUMED_GAS
                                              (+ (* 34000 PAIRING_COUNT) 45000))
                                         (eq! TOUCHES_RAM ENOUGH_GAS)
                                         (if-eq ENOUGH_GAS 1
                                                (eq! MALFORMED_DATA (- 1 EC_DATA_CHECKS_PASSED))))
                                  (begin (eq! MALFORMED_DATA 1)
                                         (vanishes! TOUCHES_RAM))))))

(defconstraint execution-blake ()
  (if-not-zero BLAKE
               (if-eq-else CALL_DATA_SIZE 213
                           (begin (eq! TOUCHES_RAM 1)
                                  (if-zero-else (* BLAKE_F (- BLAKE_F 1))
                                                (begin (vanishes! MALFORMED_DATA)
                                                       (eq! CONSUMED_GAS BLAKE_ROUNDS))
                                                (eq! MALFORMED_DATA 1)))
                           (begin (eq! MALFORMED_DATA 1)
                                  (vanishes! TOUCHES_RAM)))))

;;;;;;;;;;;;;;;;;;;;;;;
;;                   ;;
;;    3.7 Success    ;;
;;                   ;;
;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint success ()
  (eq! SUCCESS
       (* ENOUGH_GAS (- 1 MALFORMED_DATA))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;    3.8 Gas returned    ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint gas-returned ()
  (if-zero-else SUCCESS
                (vanishes! GAS_RETURNED)
                (eq! GAS_RETURNED (- GAS_STPD CONSUMED_GAS))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.9 Return Data    ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint no-return-data-if-failure ()
  (if-zero SUCCESS
           (vanishes! RETURN_DATA_SIZE)))

(defconstraint return-data-size-if-success ()
  (if-not-zero SUCCESS
               (begin (if-not-zero EC_RECOVER
                                   (if-zero-else EC_DATA_CHECKS_PASSED
                                                 (vanishes! RETURN_DATA_SIZE)
                                                 (eq! RETURN_DATA_SIZE 32)))
                      (if-not-zero (+ SHA2 RIPEMD EC_PAIRING)
                                   (eq! RETURN_DATA_SIZE 32))
                      (if-not-zero IDENTITY
                                   (eq! RETURN_DATA_SIZE CALL_DATA_SIZE))
                      (if-not-zero MODEXP
                                   (if-zero COUNTER
                                            (eq! RETURN_DATA_SIZE (shift MODEXP_PARAMS 5))))
                      (if-not-zero (+ EC_ADD EC_MUL BLAKE)
                                   (eq! RETURN_DATA_SIZE 64)))))

(defconstraint provides-return-data ()
  (if-zero-else RETURN_DATA_SIZE (vanishes! PROVIDES_RETURN_DATA) (eq! PROVIDES_RETURN_DATA 1)))

;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;    3.10 Lookups    ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint requires-ec-data ()
  (begin (if-eq (+ EC_RECOVER EC_ADD EC_MUL) 1 (eq! REQUIRES_ECDATA ENOUGH_GAS))
         (if-eq EC_PAIRING 1
                (if-eq-else CALL_DATA_SIZE (* 192 PAIRING_COUNT)
                            (eq! REQUIRES_ECDATA ENOUGH_GAS)
                            (vanishes! REQUIRES_ECDATA)))
         (if-zero (+ EC_RECOVER EC_ADD EC_MUL EC_PAIRING)
                  (vanishes! REQUIRES_ECDATA))))

