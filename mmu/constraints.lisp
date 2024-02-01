(module mmu)

(defun (flag-sum)
  (+ MACRO PRPRC MICRO))

(defconstraint perspective-flag ()
  (begin (debug (is-binary (flag-sum)))
         (if-zero STAMP
                  (vanishes! (flag-sum))
                  (eq! (flag-sum) 1))))

;;
;; Heartbeat
;;
(defconstraint first-row (:domain {0})
  (vanishes! STAMP))

(defconstraint no-macrostamp-no-microstamp ()
  (if-zero STAMP
           (vanishes! MMIO_STAMP)))

(defconstraint mmu-stamp-evolution ()
  (did-inc! STAMP MACRO))

(defconstraint mmio-stamp-evolution ()
  (did-inc! MMIO_STAMP MICRO))

(defconstraint prprc-after-macro (:guard MACRO)
  (eq! (next PRPRC) 1))

(defconstraint after-prprc (:guard PRPRC)
  (begin (debug (eq! (+ (next PRPRC) (next MICRO))
                     1))
         (if-zero prprc/CT
                  (will-eq! MICRO 1)
                  (begin (will-dec! prprc/CT 1)
                         (will-eq! PRPRC 1)))))

(defconstraint tot-nb-of-micro-inst ()
  (eq! TOT (+ TOTLZ TOTNT TOTRZ)))

(defconstraint after-micro (:guard MICRO)
  (begin (debug (eq! (+ (next MICRO) (next MACRO))
                     1))
         (did-dec! TOT 1)
         (if-zero TOT
                  (begin (will-eq! MACRO 1)
                         (debug (vanishes! TOTLZ))
                         (debug (vanishes! TOTNT))
                         (debug (vanishes! TOTRZ)))
                  (will-eq! MICRO 1))
         (if-zero (prev TOTLZ)
                  (vanishes! TOTLZ)
                  (did-dec! TOTLZ 1))
         (if-zero (prev TOTNT)
                  (vanishes! TOTNT)
                  (did-dec! (+ TOTLZ TOTNT) 1))))

(defconstraint last-row (:domain {-1})
  (if-not-zero STAMP
               (begin (eq! MICRO 1)
                      (vanishes! TOT))))

;;
;; Constancies
;;
(defun (prprc-constant X)
  (if-eq PRPRC 1 (remained-constant! X)))

(defconstraint prprc-constancies ()
  (begin (prprc-constant TOT)
         (debug (prprc-constant TOTLZ))
         (debug (prprc-constant TOTNT))
         (debug (prprc-constant TOTRZ))))

(defun (stamp-decrementing X)
  (if-not-zero (- STAMP
                  (+ (prev STAMP) 1))
               (any! (remained-constant! X) (did-inc! X 1))))

(defconstraint stamp-decrementings ()
  (begin (stamp-decrementing TOT)
         (stamp-decrementing TOTLZ)
         (stamp-decrementing TOTNT)
         (stamp-decrementing TOTRZ)))

(defun (stamp-constant X)
  (if-not-zero (- STAMP
                  (+ (prev STAMP) 1))
               (remained-constant! X)))

(defconstraint stamp-constancies ()
  (begin (for i [5] (stamp-constant [OUT 1]))
         (for i [5] (stamp-constant [BIN 1]))
         (stamp-constant (weight-flag-sum))
         (stamp-constant IS_ANY_TO_RAM_WITH_PADDING_SOME_DATA)))

;;
;; Instruction Decoding
;;
(defun (is-any-to-ram-with-padding)
  (+ IS_ANY_TO_RAM_WITH_PADDING_SOME_DATA IS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING))

(defun (inst-flag-sum)
  (+ IS_MLOAD
     IS_MSTORE
     IS_MSTORE8
     IS_INVALID_CODE_PREFIX
     IS_RIGHT_PADDED_WORD_EXTRACTION
     IS_RAM_TO_EXO_WITH_PADDING
     IS_EXO_TO_RAM_TRANSPLANTS
     IS_RAM_TO_RAM_SANS_PADDING
     (is-any-to-ram-with-padding)
     IS_MODEXP_ZERO
     IS_MODEXP_DATA
     IS_BLAKE_PARAM))

(defun (weight-flag-sum)
  (+ (* MMU_INST_MLOAD IS_MLOAD)
     (* MMU_INST_MSTORE IS_MSTORE)
     (* MMU_INST_MSTORE8 IS_MSTORE8)
     (* MMU_INST_INVALID_CODE_PREFIX IS_INVALID_CODE_PREFIX)
     (* MMU_INST_RIGHT_PADDED_WORD_EXTRACTION IS_RIGHT_PADDED_WORD_EXTRACTION)
     (* MMU_INST_RAM_TO_EXO_WITH_PADDING IS_RAM_TO_EXO_WITH_PADDING)
     (* MMU_INST_EXO_TO_RAM_TRANSPLANTS IS_EXO_TO_RAM_TRANSPLANTS)
     (* MMU_INST_RAM_TO_RAM_SANS_PADDING IS_RAM_TO_RAM_SANS_PADDING)
     (* MMU_INST_ANY_TO_RAM_WITH_PADDING (is-any-to-ram-with-padding))
     (* MMU_INST_MODEXP_ZERO IS_MODEXP_ZERO)
     (* MMU_INST_MODEXP_DATA IS_MODEXP_DATA)
     (* MMU_INST_BLAKE_PARAM IS_BLAKE_PARAM)))

(defconstraint inst-flag-is-one ()
  (if-zero STAMP
           (vanishes! (inst-flag-sum))
           (eq! (inst-flag-sum) 1)))

(defconstraint set-inst-flag (:guard MACRO)
  (eq! (weight-flag-sum) macro/INST))


