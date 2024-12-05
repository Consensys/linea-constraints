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
         (eq! (shift EXO_INST w) EVM_INST_LEQ)
         (eq! (shift ARG_1_HI w) a_hi)
         (eq! (shift ARG_1_LO w) a_lo)
         (eq! (shift ARG_2_HI w) b_hi)
         (eq! (shift ARG_2_LO w) b_lo)
         (eq! (shift RES w) 1)))

(defun (wcp-call-to-GEQ w a_hi a_lo b_hi b_lo)
  (begin (eq! (shift WCP_FLAG w) 1)
         (eq! (shift EXO_INST w) EVM_INST_GEQ)
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
;;  2.2.1 Shorthands        ;;
;;                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun    (flag_sum)    (+ IS_CB
                           IS_TS
                           IS_NB
                           IS_DF
                           IS_GL
                           IS_ID
                           IS_BF))

(defun    (wght_sum)    (+ ( * 1 IS_CB)
                           ( * 2 IS_TS)
                           ( * 3 IS_NB)
                           ( * 4 IS_DF)
                           ( * 5 IS_GL)
                           ( * 6 IS_ID)
                           ( * 7 IS_BF)))

(defun    (inst_sum)    (+ (* EVM_INST_COINBASE   IS_CB)
                           (* EVM_INST_TIMESTAMP  IS_TS)
                           (* EVM_INST_NUMBER     IS_NB)
                           (* EVM_INST_DIFFICULTY IS_DF)
                           (* EVM_INST_GASLIMIT   IS_GL)
                           (* EVM_INST_CHAINID    IS_ID)
                           (* EVM_INST_BASEFEE    IS_BF)))

(defun    (ct_max_sum)    (+ (* (- 1 BLOCKDATA_CT_MAX_CB) IS_CB)
                             (* (- 1 BLOCKDATA_CT_MAX_TS) IS_TS)
                             (* (- 1 BLOCKDATA_CT_MAX_NB) IS_NB)
                             (* (- 1 BLOCKDATA_CT_MAX_DF) IS_DF)
                             (* (- 1 BLOCKDATA_CT_MAX_GL) IS_GL)
                             (* (- 1 BLOCKDATA_CT_MAX_ID) IS_ID)
                             (* (- 1 BLOCKDATA_CT_MAX_BF) IS_BF)))

(defun    (phase_entry)    (+ (* (- IS_CB 1) (shift IS_CB 1))
                              (* (- IS_TS 1) (shift IS_TS 1))
                              (* (- IS_NB 1) (shift IS_NB 1))
                              (* (- IS_DF 1) (shift IS_DF 1))
                              (* (- IS_GL 1) (shift IS_GL 1))
                              (* (- IS_ID 1) (shift IS_ID 1))
                              (* (- IS_BF 1) (shift IS_BF 1))))

(defun    (same_phase)     (+ (* IS_CB (shift IS_CB 1))
                              (* IS_TS (shift IS_TS 1))
                              (* IS_NB (shift IS_NB 1))
                              (* IS_DF (shift IS_DF 1))
                              (* IS_GL (shift IS_GL 1))
                              (* IS_ID (shift IS_ID 1))
                              (* IS_BF (shift IS_BF 1))))

(defun    (allowable_transition)     (+ (* IS_CB (shift IS_TS 1))
                                        (* IS_TS (shift IS_NB 1))
                                        (* IS_NB (shift IS_DF 1))
                                        (* IS_DF (shift IS_GL 1))
                                        (* IS_GL (shift IS_ID 1))
                                        (* IS_ID (shift IS_BF 1))
                                        (* IS_BF (shift IS_CB 1))))

(defun    (curr_prev_wght_sum)  (+ IS_CURR (* IS_PREV 2)))

;; TODO: define the others

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