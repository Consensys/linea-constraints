(module txRlp)

(defconst
  int_short               128  ;;RLP prefix of a short integer (<56 bytes), defined in the EYP.
  int_long                183  ;;RLP prefix of a long integer (>55 bytes), defined in the EYP.
  list_short              192  ;;RLP prefix of a short list (<56 bytes), defined in the EYP.
  list_long               247  ;;RLP prefix of a long list (>55 bytes), defined in the EYP.
  LLARGE                  16
  LLARGEMO                15)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    4.1 Global Constraints    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;    4.1.1 Constancy columns  ;;

;; Def block-constant
(defun (block-constant C)
  (if-not-zero ABS_TX_NUM (will-remain-constant! C)))

;; Def transaction-constant
(defun (transaction-constant C)
  (if-not-eq (ABS_TX_NUM (+ (prev ABS_TX_NUM 1)))
    (remained-constant! C)))

;; Def counter-constant
(defun (counter-constant  C)
  (if-not-zero CT (remained-constant! C)))

;; Def counter-incrementing.
(defun (counter-incrementing C)
  (if-not-zero CT
               (or! (remained-constant! C)
                    (did-inc! C 1))))

;; Definition phase-constancy.
(defpurefun (phase-constancy PHASE C)
  (if-eq (* PHASE (prev PHASE)) 1
         (remained-constant! C)))

;; Definition phase-incrementing
(defpurefun (phase-incrementing PHASE C)
  (if-eq (* PHASE (prev PHASE)) 1
         (or! (remained-constant! C)
              (did-inc! C 1))))

;; Definition phase-decrementing
(defpurefun (phase-decrementing PHASE C)
  (if-eq (* PHASE (prev PHASE)) 1
         (or! (remained-constant! C)
              (did-dec! C 1))))

;; Constancies              
(defconstraint block-constancies ()
  (block-constant ABS_TX_NUM_MAX))

(defconstraint transaction-constancies ()
  (transaction-constant LOG_NUM_MAX))

(defconstraint counter-constancies ()
 (begin
  (for i [1 : 4] (counter-constant [INPUT i]))
  (counter-constant nSTEP)
  (counter-constant IS_PREFIX)
  (counter-constant DEPTH_1)
  (counter-constant IS_TOPIC)
  (counter-constant IS_DATA)))

(defconstraint ct-incrementings ()
  (begin
    (counter-incrementing LC)
    (counter-incrementing LC_CORRECTION)))

(defconstraint phase3-decrementing ()
  (phase-decrementing [PHASE 3] IS_PREFIX))

(defconstraint phase4-incrementing ()
  (phase-incrementing [PHASE 4] DEPTH_1))

(defconstraint istopic-incrementing ()
  (phase-incrementing IS_TOPIC INDEX_LOCAL))

(defconstraint phase0-constant ()
 (phase-constancy [PHASE 0] TXRCPT_SIZE))

;;    4.1.2 Global Phase Constraints    ;;

(defconstraint initial-stamp (:domain {0})
  (vanishes! ABS_TX_NUM))

(defconstraint phase-exclusion ()
  (if-zero ABS_TX_NUM
           (vanishes! (reduce + (for i [0 : 44] [PHASE i])))
           (eq! 1 (reduce + (for i [0 : 14] [PHASE i])))))

(defconstraint ABS_TX_NUM-evolution()
  (eq! ABS_TX_NUM
       (+ (prev ABS_TX_NUM)
          (* [PHASE 0] (remained-constant! [PHASE 0])))))

(defconstraint no-done-no-end ()
  (if-zero DONE
           (vanishes! end_phase)))

(defconstraint no-end-no-changephase ()
  (if-zero end_phase
           (vanishes! (reduce + (for i [0 : 4]
                                     (* i
                                        (- (next [PHASE i]) [PHASE i])))))))

(defconstraint phase-transition ()
  (if-eq end_phase 1
         (begin
          (eq! 1 (+ (* [PHASE 0 (next [Phase 1])])
                    (* [PHASE 1 (next [Phase 2])])
                    (* [PHASE 2 (next [Phase 3])])
                    (* [PHASE 3 (next [Phase 4])])
                    (* [PHASE 4 (next [Phase 0])])))
          (if-eq [PHASE 4] 1
            (begin
              (vanishes! TXRCPT_SIZE)
              (eq! LOG_NUM LOG_NUM_MAX))))))

;;    4.1.3 Byte decomposition's loop heartbeat  ;;

(defconstraint ct-imply-done (:guard ABS_TX_NUM)
  (if-eq-else CT (- number_step 1)
              (eq! DONE 1)
              (vanishes! DONE)))

(defconstraint done-imply-heartbeat (:guard ABS_TX_NUM)
  (if-zero DONE
           (will-inc! CT 1)
           (begin
            (eq! LC (- 1 LC_CORRECTION))
            (vanishes! (next CT)))))

;;    4.1.4 Blind Byte and Bit decomposition  ;;

(defconstraint byte-decompositions ()
  (for k [1:4]
       (byte-decomposition CT [ACC k] [BYTE k])))

(defconstraint bit-decomposition ()
  (if-zero CT
           (eq! BIT_ACC BIT)
           (eq! BIT_ACC (+ (* 2 (prev BIT_ACC)) BIT))))

;;    4.1.5 Index Update  ;;

(defconstraint index-reset ()
  (if-not-eq ABS_TX_NUM (prev ABS_TX_NUM)
    (vanishes! INDEX)))

(defconstraint index-evolution ()
  (if-not-eq ABS_TX_NUM (+ (prev ABS_TX_NUM) 1)
    (eq! INDEX (+ (prev INDEX) (prev LC)))))


;;      4.1.6 Byte size updates     ;;
(defconstraint globalsize-update ()
  (if-zero [PHASE 0]
    (eq! TXRCPT_SIZE
         (- (prev TXRCPT_SIZE)
            (* LC nBYTES)))))

(defconstraint phasesize-update ()
  (if-eq 1 (+ (* [PHASE 3] (- 1 IS_PREFIX))
              (* [PHASE 4] DEPTH_1)))
    (eq! PHASE_SIZE (- (prev PHASE_SIZE) (* LC nBYTES))))

;;    LC correction nullity    ;;
(defconstraint lccorrection-nullity ()
  (if-zero (+ ([PHASE 4] IS_DATA)
              (- 1 [PHASE 0])))
    (vanishes! LC_CORRECTION))

;;    4.1.8 Finalisation Constraints    ;;

(defconstraint finalisation (:domain {-1})
  (if-not-zero ABS_TX_NUM
    (begin
      (eq! PHASE_END 1)
      (eq! [PHASE 4] 1)
      (eq! ABS_TX_NUM ABS_TX_NUM_MAX))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.2 Phase constraints   ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;    4.2.1 Phase 0 : RLP prefix  ;;

(defconstraint phase0-init (:guard [PHASE 0])   ;; 4.1.1
  (if-zero (prev [PHASE 0])
    (begin
      (vanishes! (+ (- 1 IS_PREFIX)
                    PHASE_END
                    (next IS_PREFIX)))
      (eq! nSTEP 1)
      (if-zero [INPUT 1]
        (eq! LC_CORRECTION 1)
        (begin
          (vanishes! LC_CORRECTION)
          (eq! LIMB (* [INPUT 1] (^ 256 LLARGEMO)))
          (eq! nBYTES 1))))))

(defconstraint phase0-rlprefix (:guard [PHASE 0])
 (if-zero IS_PREFIX
  (begin 
    (eq! nSTEP 8)
    (vanishes! LC_CORRECTION)
    (eq! [INPUT 1] TXRCPT_SIZE)
    (rlpPrefixOfByteString [INPUT 1] CT nSTEP DONE [PHASE 0]
                           ACC_SIZE POWER BIT [ACC 1] [ACC 2]
                           LC LIMB nBYTES)
    (if-eq DONE 1
      (eq! PHASE_END 1)))))

;;    4.2.2 Phase 1 : status code Rz  ;;
(defconstraint phase1 ()
  (if-eq [PHASE 1] 1
    (begin
      (eq! nSTEP 1)
      (if-zero [INPUT 1]
        (eq! LIMB (* int_short (^256 LLARGEMO)))
        (eq! LIMB (* [INPUT 1] (^256 LLARGEMO))))
      (eq! nBYTES 1)
      (eq! PHASE_END 1))))

;; 4.2.3 Phase 2 : cumulative gas Ru  ;;
(defconstraint phase2 ()
  (if-eq [PHASE 2] 1
    (eq! nSTEP 8)
    (rlpPrefixInt [INPUT 1] CT nSTEP DONE
                  [BYTE 1] [ACC 1] ACC_SIZE POWER BIT BIT_ACC
                  LIMB LC nBYTES)
    (if-eq DONE 1
      (begin
        (limbShifting [INPUT 1] POWER ACC_SIZE
                      LIMB nBYTES)
        (eq! PHASE_END 1)))))

;;  Phase 3: bloom filter Rb    ;;
(defconstraint phase3-prefix (:guard [PHASE 3])
  (if-zero (prev [PHASE 3])
    (begin
      (vanishes! (+ (- 1 IS_PREFIX)
                    PHASE_END
                    (next IS_PREFIX)))
      (eq! PHASE_SIZE 256)
      (eq! nSTEP 1)
      (eq! LIMB (+ (* (+ int_long 2) (^ 256 LLARGEMO))
                   (* PHASE_SIZE (^ 256 13))))
      (eq! nBYTES 3)
      (vanishes! INDEX_LOCAL))))

(defconstraint phase3-bloom-concatenation (:guard [PHASE 3])
  (if-zero IS_PREFIX
    (begin
      (eq! nSTEP LLARGE)
      (if-eq DONE 1
        (begin
          (for k [1 : 4] 
            (begin
              (eq! [ACC k] [INPUT k])
              (eq! [INPUT k] (shift LIMB (- k 4)))
              (eq! (shift (- k 4) nBYTES) LLARGE)))
          (eq! (+ (shift LC -4) (shift LC -3)) 1)
          (if-zero PHASE_SIZE
            (eq! PHASE_END)
            (vanishes! PHASE_END))))
      (eq! INDEX_LOCAL (+ (prev INDEX_LOCAL) (* (prev LC) (- 1 (prev IS_PREFIX))))))))