(module blockdata)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          ;;
;;  1.3 Module call macros  ;;
;;                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (wcp-call-to-LT w a_hi a_lo b_hi b_lo)
  (begin (eq! (shift WCP_FLAG w) 1)
         (eq! (shift EXO_INST w) EVM_INST_LT)
         (eq! (shift ARG_1_HI w) a_hi)
         (eq! (shift ARG_1_LO w) a_lo)
         (eq! (shift ARG_2_HI w) b_hi)
         (eq! (shift ARG_2_LO w) b_lo)
         (eq! (shift RES w) 1)))

(defun (wcp-call-to-GT w a_hi a_lo b_hi b_lo)
  (begin (eq! (shift WCP_FLAG w) 1)
         (eq! (shift EXO_INST w) EVM_INST_GT)
         (eq! (shift ARG_1_HI w) a_hi)
         (eq! (shift ARG_1_LO w) a_lo)
         (eq! (shift ARG_2_HI w) b_hi)
         (eq! (shift ARG_2_LO w) b_lo)
         (eq! (shift RES w) 1)))

(defun (wcp-call-to-LEQ w a_hi a_lo b_hi b_lo)
  (begin (eq! (shift WCP_FLAG w) 1)
         (eq! (shift EXO_INST w) WCP_INST_LEQ)
         (eq! (shift ARG_1_HI w) a_hi)
         (eq! (shift ARG_1_LO w) a_lo)
         (eq! (shift ARG_2_HI w) b_hi)
         (eq! (shift ARG_2_LO w) b_lo)
         (eq! (shift RES w) 1)))

(defun (wcp-call-to-GEQ w a_hi a_lo b_hi b_lo)
  (begin (eq! (shift WCP_FLAG w) 1)
         (eq! (shift EXO_INST w) WCP_INST_GEQ)
         (eq! (shift ARG_1_HI w) a_hi)
         (eq! (shift ARG_1_LO w) a_lo)
         (eq! (shift ARG_2_HI w) b_hi)
         (eq! (shift ARG_2_LO w) b_lo)
         (eq! (shift RES w) 1)))

(defun (wcp-call-to-ISZERO w a_hi a_lo)
  (begin (eq! (shift WCP_FLAG w) 1)
         (eq! (shift EXO_INST w) EVM_INST_ISZERO)
         (eq! (shift ARG_1_HI w) a_hi)
         (eq! (shift ARG_1_LO w) a_lo)
         (eq! (shift ARG_2_HI w) 0)
         (eq! (shift ARG_2_LO w) 0)))

(defun (euc-call w a b)
  (begin (eq! (shift EUC_FLAG w) 1)
         (eq! (shift ARG_1_HI w) a)
         (eq! (shift ARG_1_LO w) a)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          ;;
;;  2.1 Shorthands          ;;
;;                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun    (flag-sum)    (+ IS_CB
                           IS_TS
                           IS_NB
                           IS_DF
                           IS_GL
                           IS_ID
                           IS_BF))

(defun    (wght-sum)    (+ ( * 1 IS_CB)
                           ( * 2 IS_TS)
                           ( * 3 IS_NB)
                           ( * 4 IS_DF)
                           ( * 5 IS_GL)
                           ( * 6 IS_ID)
                           ( * 7 IS_BF)))

(defun    (inst-sum)    (+ (* EVM_INST_COINBASE   IS_CB)
                           (* EVM_INST_TIMESTAMP  IS_TS)
                           (* EVM_INST_NUMBER     IS_NB)
                           (* EVM_INST_DIFFICULTY IS_DF)
                           (* EVM_INST_GASLIMIT   IS_GL)
                           (* EVM_INST_CHAINID    IS_ID)
                           (* EVM_INST_BASEFEE    IS_BF)))

(defun    (ct-max-sum)    (+ (* (- CT_MAX_CB 1) IS_CB)
                             (* (- CT_MAX_TS 1) IS_TS)
                             (* (- CT_MAX_NB 1) IS_NB)
                             (* (- CT_MAX_DF 1) IS_DF)
                             (* (- CT_MAX_GL 1) IS_GL)
                             (* (- CT_MAX_ID 1) IS_ID)
                             (* (- CT_MAX_BF 1) IS_BF)))

(defun    (phase-entry)    (+ (* (- 1 IS_CB) (shift IS_CB 1))
                              (* (- 1 IS_TS) (shift IS_TS 1))
                              (* (- 1 IS_NB) (shift IS_NB 1))
                              (* (- 1 IS_DF) (shift IS_DF 1))
                              (* (- 1 IS_GL) (shift IS_GL 1))
                              (* (- 1 IS_ID) (shift IS_ID 1))
                              (* (- 1 IS_BF) (shift IS_BF 1))))

(defun    (same-phase)     (+ (* IS_CB (shift IS_CB 1))
                              (* IS_TS (shift IS_TS 1))
                              (* IS_NB (shift IS_NB 1))
                              (* IS_DF (shift IS_DF 1))
                              (* IS_GL (shift IS_GL 1))
                              (* IS_ID (shift IS_ID 1))
                              (* IS_BF (shift IS_BF 1))))

(defun    (allowable-transitions)     (+ (* IS_CB (shift IS_TS 1))
                                         (* IS_TS (shift IS_NB 1))
                                         (* IS_NB (shift IS_DF 1))
                                         (* IS_DF (shift IS_GL 1))
                                         (* IS_GL (shift IS_ID 1))
                                         (* IS_ID (shift IS_BF 1))
                                         (* IS_BF (shift IS_CB 1))))

(defun    (curr-prev-wght-sum)  (+ IS_CURR (* 2 IS_PREV)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                ;;
;;    2.2 Binary constraints      ;;
;;                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; done with binary@prove in columns.lisp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 ;;
;;  2.3 Unconditional constraints  ;;
;;                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint unconditional-constraints ()
   (begin (eq! IOMF (flag-sum))
          (eq! IOMF (+ IS_PREV IS_CURR))
          (eq! CT_MAX (ct-max-sum))
          (eq! INST (inst-sum))))

;;;;;;;;;;;;;;;;;;;;;;
;;                  ;;
;;  2.4 Contancies  ;;
;;                  ;;
;;;;;;;;;;;;;;;;;;;;;;

(defconstraint counter-constancies ()
  (begin (counter-constancy CT DATA_HI)
         (counter-constancy CT DATA_LO)
         (counter-constancy CT COINBASE_HI)
         (counter-constancy CT COINBASE_LO)
         (counter-constancy CT REL_TX_NUM_MAX)
         (counter-constancy CT BLOCK_GAS_LIMIT)
         (counter-constancy CT (wght-sum))))

(defconstraint first-block-number-is-conflation-constant ()
  (if-not-zero IOMF
      (if-not-zero (shift IOMF 1)
           (eq! (shift FIRST_BLOCK_NUMBER 1) FIRST_BLOCK_NUMBER))))

;;;;;;;;;;;;;;;;;;;;;
;;                 ;;
;;  2.5 Heartbeat  ;;
;;                 ;;
;;;;;;;;;;;;;;;;;;;;;

(defconstraint first-row-iomf (:domain {0})
  (vanishes! IOMF))

(defconstraint padding-vanishing ()
  (if-zero IOMF
      (vanishes! CT)
      (vanishes! (shift CT 1))))

(defconstraint first-instruction-is-coinbase ()
  (if-zero IOMF
      (if-not-zero (shift IOMF 1)
          (eq! (shift IS_CB 1) 1))))

(defconstraint counter-reset-for-phase-entry ()
  (if-not-zero (phase-entry)
      (vanishes! (shift CT 1))))

(defconstraint counter-increase-or-instruction-transition ()
  (if-not-zero IOMF
      (if-not-zero (- CT CT_MAX)
          (eq! (shift CT 1) (+ 1 CT)))
          (eq! (allowable-transitions) 1)))

(defconstraint first-row-rel-block (:domain {0})
  (vanishes! REL_BLOCK))

(defconstraint rel-block-constant-or-increment ()
  (any! (remained-constant! REL_BLOCK) (did-inc! REL_BLOCK 1)))

(defconstraint rel-block-increment-from-basefee-to-coinbase ()
  (eq! (shift REL_BLOCK 1) (+ REL_BLOCK ( * IS_BF (shift IS_CB 1)))))

(defconstraint next-is-curr ()
  (if-not-zero IS_CURR
      (eq! (shift IS_CURR 1) 1)))

(defconstraint is-prev-after-padding ()
  (if-zero IOMF
      (if-not-zero (shift IOMF 1)
          (eq! (shift IS_PREV 1) 1))))

(defconstraint curr-prev-wght-sum-constancy ()
  (if-not-zero IOMF
      (if-eq (shift REL_BLOCK 1) REL_BLOCK
          (eq! (shift (curr-prev-wght-sum) 1) (curr-prev-wght-sum)))))

(defconstraint switch-to-is-curr ()
  (if-eq (shift REL_BLOCK 1) (+ 1 REL_BLOCK)
      (eq! (shift IS_CURR 1) 1)))

(defconstraint last-row-is-curr (:domain {-1})
  (eq! IS_CURR 1))

(defconstraint last-row-is-basefee (:domain {-1})
  (eq! IS_BF 1))

(defconstraint last-row-counter (:domain {-1})
  (eq! CT CT_MAX))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;  3 Computations and checks  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;  3.1 For COINBASE  ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun (coinbase-precondition)
 (* (- 1 (prev IS_CB)) IS_CB))

(defconstraint setting-coinbase (:guard (coinbase-precondition))
  (begin (eq! DATA_HI COINBASE_HI)
         (eq! DATA_LO COINBASE_LO)))

;; TODO: correct spec name
(defconstraint coinbase-lower-bound (:guard (coinbase-precondition))
  (if-not-zero IS_CURR
    (wcp-call-to-LT 0 DATA_HI DATA_LO (^ 256 4) 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;  3.2 For TIMESTAMP  ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (timestamp-precondition)
 (* (- 1 (prev IS_TS)) IS_TS))


(defconstraint timestamp-upperbound (:guard (timestamp-precondition))
    (wcp-call-to-LT 0 DATA_HI DATA_LO 0 (^ 256 6)))

(defconstraint timestamp-is-incrementing (:guard (timestamp-precondition))
  (if-not-zero IS_CURR
    (wcp-call-to-LT 1 DATA_HI DATA_LO (shift DATA_HI (- CT_MAX_DEPTH)) (shift DATA_LO (- CT_MAX_DEPTH)))))

;;;;;;;;;;;;;;;;;;;;;;
;;                  ;;
;;  3.3 For NUMBER  ;;
;;                  ;;
;;;;;;;;;;;;;;;;;;;;;;
(defun (number-precondition)
 (* (- 1 (prev IS_NB)) IS_NB))

(defconstraint number-comparing (:guard (number-precondition))
    (wcp-call-to-ISZERO 0 0 FIRST_BLOCK_NUMBER))

(defalias
    first-block-is-genesis-block RES)

(defconstraint number-upperbound (:guard (number-precondition))
    (wcp-call-to-LT 1 DATA_HI DATA_LO 0 (^ 256 6)))

(defconstraint setting-number-is-prev (:guard (number-precondition))
  (if-not-zero IS_PREV
      (if-not-zero first-block-is-genesis-block
            (begin (vanishes! DATA_HI)
                   (vanishes! DATA_LO)))
      (begin (vanishes! DATA_HI)
             (eq! DATA_LO (- FIRST_BLOCK_NUMBER 1)))))

(defconstraint setting-number-is-curr (:guard (number-precondition))
  (if-not-zero IS_CURR
      (if-not-zero first-block-is-genesis-block
            (if-not-zero (shift IS_PREV (- CT_MAX_DEPTH))
                (begin (vanishes! DATA_HI)
                       (vanishes! DATA_LO)))
            (if-not-zero (shift IS_CURR (- CT_MAX_DEPTH))
                (begin (eq! DATA_HI (shift DATA_HI (- CT_MAX_DEPTH)))
                       (eq! DATA_LO (+ (shift DATA_LO (- CT_MAX_DEPTH)) 1)))))
      (begin (eq! DATA_HI (shift DATA_HI (- CT_MAX_DEPTH)))
              (eq! DATA_LO (+ (shift DATA_LO (- CT_MAX_DEPTH)) 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      ;;
;;  3.4 For DIFFICULTY  ;;
;;                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (difficulty-precondition)
 (* (- 1 (prev IS_DF)) IS_DF))

(defconstraint difficulty-bound (:guard (number-precondition))
    (wcp-call-to-GEQ 0 DATA_HI DATA_LO 0 0))

;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;  3.5 For GASLIMIT  ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun (gaslimit-precondition)
 (* (- 1 (prev IS_GL)) IS_GL))

(defconstraint setting-gaslimit (:guard (gaslimit-precondition))
  (begin (eq! DATA_HI 0)
         (eq! DATA_LO BLOCK_GAS_LIMIT)))

(defconstraint gaslimit-lowerbound (:guard (gaslimit-precondition))
    (wcp-call-to-GEQ 0 DATA_HI DATA_LO 0 61000000))

(defconstraint gaslimit-upperbound (:guard (gaslimit-precondition))
    (wcp-call-to-LEQ 1 DATA_HI DATA_LO 0 2000000000))

(defun (prev-gas-limit)
 (shift BLOCK_GAS_LIMIT (- CT_MAX_DEPTH)))

(defun (max-deviation)
 (shift RES 2))

(defconstraint gaslimit-maximum-deviation (:guard (gaslimit-precondition))
  (if-not-zero IS_CURR
      (euc-call 2 (prev-gas-limit) 1024)))

(defconstraint gaslimit-deviation-upper-bound (:guard (gaslimit-precondition))
  (if-not-zero IS_CURR
      (wcp-call-to-LT 3 DATA_HI DATA_LO 0 (+ (prev-gas-limit) (max-deviation)))))

(defconstraint gaslimit-deviation-lower-bound (:guard (gaslimit-precondition))
  (if-not-zero IS_CURR
      (wcp-call-to-GT 4 DATA_HI DATA_LO 0 (- (prev-gas-limit) (max-deviation)))))

;;;;;;;;;;;;;;;;;;;;;;;
;;                   ;;
;;  3.6 For CHAINID  ;;
;;                   ;;
;;;;;;;;;;;;;;;;;;;;;;;
(defun (chainid-precondition)
 (* (- 1 (prev IS_ID)) IS_ID))

(defconstraint chainid-permanence (:guard (chainid-precondition))
  (if-not-zero IS_CURR
      (eq! DATA_HI (shift DATA_HI (- CT_MAX_DEPTH)))
      (eq! DATA_LO (shift DATA_LO (- CT_MAX_DEPTH)))))

(defconstraint chainid-bound (:guard (chainid-precondition))
    (wcp-call-to-GEQ 0 DATA_HI DATA_LO 0 0))

;;;;;;;;;;;;;;;;;;;;;;;
;;                   ;;
;;  3.7 For BASEFEE  ;;
;;                   ;;
;;;;;;;;;;;;;;;;;;;;;;;
(defun (basefee-precondition)
 (* (- 1 (prev IS_BF)) IS_BF))

(defconstraint setting-basefee (:guard (basefee-precondition))
  (begin (eq! DATA_HI 0)
         (eq! DATA_LO BASEFEE)))

(defconstraint basefee-bound (:guard (basefee-precondition))
    (wcp-call-to-GEQ 0 DATA_HI DATA_LO 0 0))


;; TODO: define the others, remember to use constants when available, e.g., LINEA_BASE_FEE, delete old implementation below

;; (defconstraint first-row (:domain {0})
;;   (vanishes! REL_BLOCK))

;; (defconstraint padding-is-padding ()
;;   (if-zero REL_BLOCK
;;            (begin (vanishes! FIRST_BLOCK_NUMBER)
;;                   (vanishes! INST))))

;; (defconstraint rel-block-increment ()
;;   (or! (will-remain-constant! REL_BLOCK) (will-inc! REL_BLOCK 1)))

;; (defconstraint new-block-reset-ct ()
;;   (if-not-zero (remained-constant! REL_BLOCK)
;;                (vanishes! CT)))

;; (defconstraint heartbeat (:guard REL_BLOCK)
;;   (begin (will-remain-constant! FIRST_BLOCK_NUMBER)
;;          (if-eq-else   CT   CT_MAX_FOR_BLOCKDATA
;;                        (will-inc! REL_BLOCK 1)
;;                        (will-inc! CT 1))))

;; (defconstraint finalization (:domain {-1})
;;   (eq!   CT   CT_MAX_FOR_BLOCKDATA))

;; (defconstraint counter-constancies ()
;;   (begin (counter-constancy CT REL_TX_NUM_MAX)
;;          (counter-constancy CT COINBASE_HI)
;;          (counter-constancy CT COINBASE_LO)
;;          (counter-constancy CT BLOCK_GAS_LIMIT)
;;          (counter-constancy CT BASEFEE)))

;; (defconstraint horizontal-byte-decompositions ()
;;                (begin
;;                  (eq!    DATA_HI    (+ (* (^ 256 (- LLARGEMO    0))   [BYTE_HI    0])
;;                                        (* (^ 256 (- LLARGEMO    1))   [BYTE_HI    1])
;;                                        (* (^ 256 (- LLARGEMO    2))   [BYTE_HI    2])
;;                                        (* (^ 256 (- LLARGEMO    3))   [BYTE_HI    3])
;;                                        (* (^ 256 (- LLARGEMO    4))   [BYTE_HI    4])
;;                                        (* (^ 256 (- LLARGEMO    5))   [BYTE_HI    5])
;;                                        (* (^ 256 (- LLARGEMO    6))   [BYTE_HI    6])
;;                                        (* (^ 256 (- LLARGEMO    7))   [BYTE_HI    7])
;;                                        (* (^ 256 (- LLARGEMO    8))   [BYTE_HI    8])
;;                                        (* (^ 256 (- LLARGEMO    9))   [BYTE_HI    9])
;;                                        (* (^ 256 (- LLARGEMO   10))   [BYTE_HI   10])
;;                                        (* (^ 256 (- LLARGEMO   11))   [BYTE_HI   11])
;;                                        (* (^ 256 (- LLARGEMO   12))   [BYTE_HI   12])
;;                                        (* (^ 256 (- LLARGEMO   13))   [BYTE_HI   13])
;;                                        (* (^ 256 (- LLARGEMO   14))   [BYTE_HI   14])
;;                                        (* (^ 256 (- LLARGEMO   15))   [BYTE_HI   15])))
;;                  (eq!    DATA_LO    (+ (* (^ 256 (- LLARGEMO    0))   [BYTE_LO    0])
;;                                        (* (^ 256 (- LLARGEMO    1))   [BYTE_LO    1])
;;                                        (* (^ 256 (- LLARGEMO    2))   [BYTE_LO    2])
;;                                        (* (^ 256 (- LLARGEMO    3))   [BYTE_LO    3])
;;                                        (* (^ 256 (- LLARGEMO    4))   [BYTE_LO    4])
;;                                        (* (^ 256 (- LLARGEMO    5))   [BYTE_LO    5])
;;                                        (* (^ 256 (- LLARGEMO    6))   [BYTE_LO    6])
;;                                        (* (^ 256 (- LLARGEMO    7))   [BYTE_LO    7])
;;                                        (* (^ 256 (- LLARGEMO    8))   [BYTE_LO    8])
;;                                        (* (^ 256 (- LLARGEMO    9))   [BYTE_LO    9])
;;                                        (* (^ 256 (- LLARGEMO   10))   [BYTE_LO   10])
;;                                        (* (^ 256 (- LLARGEMO   11))   [BYTE_LO   11])
;;                                        (* (^ 256 (- LLARGEMO   12))   [BYTE_LO   12])
;;                                        (* (^ 256 (- LLARGEMO   13))   [BYTE_LO   13])
;;                                        (* (^ 256 (- LLARGEMO   14))   [BYTE_LO   14])
;;                                        (* (^ 256 (- LLARGEMO   15))   [BYTE_LO   15])))))

;; (defun    (blockdata---first-row-of-new-block)   (-   REL_BLOCK   (prev REL_BLOCK)))

;; (defconstraint value-constraints---COINBASE (:guard (blockdata---first-row-of-new-block))
;;                (begin  
;;                  (eq! (shift INST     ROW_SHIFT_COINBASE) EVM_INST_COINBASE)
;;                  (eq! (shift DATA_HI  ROW_SHIFT_COINBASE) COINBASE_HI)
;;                  (eq! (shift DATA_LO  ROW_SHIFT_COINBASE) COINBASE_LO)
;;                  (vanishes! (+ (* (^ 256 (- LLARGEMO    0)) (shift [BYTE_HI    0]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO    1)) (shift [BYTE_HI    1]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO    2)) (shift [BYTE_HI    2]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO    3)) (shift [BYTE_HI    3]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO    4)) (shift [BYTE_HI    4]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO    5)) (shift [BYTE_HI    5]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO    6)) (shift [BYTE_HI    6]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO    7)) (shift [BYTE_HI    7]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO    8)) (shift [BYTE_HI    8]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO    9)) (shift [BYTE_HI    9]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO   10)) (shift [BYTE_HI   10]   ROW_SHIFT_COINBASE))
;;                                (* (^ 256 (- LLARGEMO   11)) (shift [BYTE_HI   11]   ROW_SHIFT_COINBASE))))))

;; (defconstraint value-constraints---TIMESTAMP (:guard (blockdata---first-row-of-new-block))
;;                (begin  
;;                  (eq!       (shift INST     ROW_SHIFT_TIMESTAMP) EVM_INST_TIMESTAMP)
;;                  (vanishes! (shift DATA_HI  ROW_SHIFT_TIMESTAMP))
;;                  (vanishes! (+ (* (^ 256 (- LLARGEMO   0)) (shift [BYTE_LO   0]   ROW_SHIFT_TIMESTAMP))
;;                                (* (^ 256 (- LLARGEMO   1)) (shift [BYTE_LO   1]   ROW_SHIFT_TIMESTAMP))
;;                                (* (^ 256 (- LLARGEMO   2)) (shift [BYTE_LO   2]   ROW_SHIFT_TIMESTAMP))
;;                                (* (^ 256 (- LLARGEMO   3)) (shift [BYTE_LO   3]   ROW_SHIFT_TIMESTAMP))
;;                                (* (^ 256 (- LLARGEMO   4)) (shift [BYTE_LO   4]   ROW_SHIFT_TIMESTAMP))
;;                                (* (^ 256 (- LLARGEMO   5)) (shift [BYTE_LO   5]   ROW_SHIFT_TIMESTAMP))
;;                                (* (^ 256 (- LLARGEMO   6)) (shift [BYTE_LO   6]   ROW_SHIFT_TIMESTAMP))
;;                                (* (^ 256 (- LLARGEMO   7)) (shift [BYTE_LO   7]   ROW_SHIFT_TIMESTAMP))
;;                                (* (^ 256 (- LLARGEMO   8)) (shift [BYTE_LO   8]   ROW_SHIFT_TIMESTAMP))
;;                                (* (^ 256 (- LLARGEMO   9)) (shift [BYTE_LO   9]   ROW_SHIFT_TIMESTAMP))))
;;                  (if-not-zero (- REL_BLOCK 1)
;;                               (eq! (shift WCP_FLAG ROW_SHIFT_TIMESTAMP) 1))))

;; (defconstraint value-constraints---NUMBER (:guard (blockdata---first-row-of-new-block))
;;                (begin  
;;                  (eq!       (shift INST      ROW_SHIFT_NUMBER) EVM_INST_NUMBER)
;;                  (vanishes! (shift DATA_HI   ROW_SHIFT_NUMBER))
;;                  (eq!       (shift DATA_LO   ROW_SHIFT_NUMBER) (+ FIRST_BLOCK_NUMBER (- REL_BLOCK 1)))
;;                  (vanishes! (+ (* (^ 256 (- LLARGEMO   0)) (shift [BYTE_LO   0]   ROW_SHIFT_NUMBER))
;;                                (* (^ 256 (- LLARGEMO   1)) (shift [BYTE_LO   1]   ROW_SHIFT_NUMBER))
;;                                (* (^ 256 (- LLARGEMO   2)) (shift [BYTE_LO   2]   ROW_SHIFT_NUMBER))
;;                                (* (^ 256 (- LLARGEMO   3)) (shift [BYTE_LO   3]   ROW_SHIFT_NUMBER))
;;                                (* (^ 256 (- LLARGEMO   4)) (shift [BYTE_LO   4]   ROW_SHIFT_NUMBER))
;;                                (* (^ 256 (- LLARGEMO   5)) (shift [BYTE_LO   5]   ROW_SHIFT_NUMBER))
;;                                (* (^ 256 (- LLARGEMO   6)) (shift [BYTE_LO   6]   ROW_SHIFT_NUMBER))
;;                                (* (^ 256 (- LLARGEMO   7)) (shift [BYTE_LO   7]   ROW_SHIFT_NUMBER))
;;                                (* (^ 256 (- LLARGEMO   8)) (shift [BYTE_LO   8]   ROW_SHIFT_NUMBER))
;;                                (* (^ 256 (- LLARGEMO   9)) (shift [BYTE_LO   9]   ROW_SHIFT_NUMBER))))))

;; (defconstraint value-constraints---DIFFICULTY (:guard (blockdata---first-row-of-new-block))
;;                (begin  
;;                  (eq!       (shift INST      ROW_SHIFT_DIFFICULTY) EVM_INST_DIFFICULTY)
;;                  (vanishes! (shift DATA_HI   ROW_SHIFT_DIFFICULTY))
;;                  (eq!       (shift DATA_LO   ROW_SHIFT_DIFFICULTY) LINEA_DIFFICULTY)))

;; (defconstraint value-constraints---GASLIMIT (:guard (blockdata---first-row-of-new-block))
;;                (begin  
;;                  (eq!       (shift INST      ROW_SHIFT_GASLIMIT) EVM_INST_GASLIMIT)
;;                  (vanishes! (shift DATA_HI   ROW_SHIFT_GASLIMIT))
;;                  (eq!       (shift DATA_LO   ROW_SHIFT_GASLIMIT) LINEA_BLOCK_GAS_LIMIT)
;;                  (eq!       (shift DATA_LO   ROW_SHIFT_GASLIMIT) BLOCK_GAS_LIMIT)))

;; (defconstraint value-constraints---CHAINID (:guard (blockdata---first-row-of-new-block))
;;                (begin  
;;                  (eq!       (shift INST      ROW_SHIFT_CHAINID) EVM_INST_CHAINID)
;;                  (vanishes! (shift DATA_HI   ROW_SHIFT_CHAINID))
;;                  ;(eq!      (shift DATA_LO   ROW_SHIFT_CHAINID) LINEA_CHAIN_ID) ;; TODO: this needs some fixing
;;                  ))

;; (defconstraint value-constraints---BASEFEE (:guard (blockdata---first-row-of-new-block))
;;                (begin  
;;                  (eq!       (shift INST      ROW_SHIFT_BASEFEE) EVM_INST_BASEFEE)
;;                  (vanishes! (shift DATA_HI   ROW_SHIFT_BASEFEE))
;;                  (eq!       (shift DATA_LO   ROW_SHIFT_BASEFEE) LINEA_BASE_FEE)
;;                  (eq!       (shift DATA_LO   ROW_SHIFT_BASEFEE) BASEFEE)))