(module rlpTxRcpt)

(defconst
  int_short               128  ;;RLP prefix of a short integer (<56 bytes), defined in the EYP.
  int_long                183  ;;RLP prefix of a long integer (>55 bytes), defined in the EYP.
  list_short              192  ;;RLP prefix of a short list (<56 bytes), defined in the EYP.
  list_long               247  ;;RLP prefix of a long list (>55 bytes), defined in the EYP.
  LLARGE                  16
  LLARGEMO                15)

(defpurefun (if-not-eq x y then) (if-not-zero (- x y) then))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    4.1 Global Constraints    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;    4.1.1 Constancy columns  ;;

;; Def block-constant
(defun (block-constant C)
  (if-not-zero ABS_TX_NUM (will-remain-constant! C)))

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
  (begin
    (block-constant ABS_TX_NUM_MAX)
    (block-constant ABS_LOG_NUM)))

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
  (begin 
    (vanishes! ABS_TX_NUM)
    (vanishes! ABS_LOG_NUM)))

(defconstraint phase-exclusion ()
  (if-zero ABS_TX_NUM
           (vanishes! (reduce + (for i [0 : 4] [PHASE i])))
           (eq! 1 (reduce + (for i [0 : 4] [PHASE i])))))

(defconstraint ABS_TX_NUM-evolution()
  (eq! ABS_TX_NUM
       (+ (prev ABS_TX_NUM)
          (* [PHASE 0] (remained-constant! [PHASE 0])))))

(defconstraint ABS_LOG_NUM-evolution ()
  (if-zero (+ [PHASE 4] (- 1 DEPTH_1) IS_PREFIX IS_TOPIC IS_DATA CT)
    (did-inc! ABS_LOG_NUM 1)
    (remained-constant! ABS_LOG_NUM)))

(defconstraint no-done-no-end ()
  (if-zero DONE
           (vanishes! PHASE_END)))

(defconstraint no-end-no-changephase ()
  (if-zero PHASE_END
           (vanishes! (reduce + (for i [0 : 4]
                                     (* i
                                        (- (next [PHASE i]) [PHASE i])))))))

(defconstraint phase-transition ()
  (if-eq PHASE_END 1
         (begin
          (eq! 1 (+ (* [PHASE 0] (next [PHASE 1]))
                    (* [PHASE 1] (next [PHASE 2]))
                    (* [PHASE 2] (next [PHASE 3]))
                    (* [PHASE 3] (next [PHASE 4]))
                    (* [PHASE 4] (next [PHASE 0]))))
          (if-eq [PHASE 4] 1
            (vanishes! TXRCPT_SIZE)))))

;;    4.1.3 Byte decomposition's loop heartbeat  ;;

(defconstraint ct-imply-done (:guard ABS_TX_NUM)
  (if-eq-else CT (- nSTEP 1)
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
              (* [PHASE 4] DEPTH_1))
    (eq! PHASE_SIZE (- (prev PHASE_SIZE) (* LC nBYTES)))))

;;    LC correction nullity    ;;
(defconstraint lccorrection-nullity ()
  (if-zero (+ [PHASE 0] (* [PHASE 4] IS_DATA))
    (vanishes! LC_CORRECTION)))

;;    4.1.8 Finalisation Constraints    ;;

(defconstraint finalisation (:domain {-1})
  (if-not-zero ABS_TX_NUM
    (begin
      (eq! PHASE_END 1)
      (eq! [PHASE 4] 1)
      (eq! ABS_TX_NUM ABS_TX_NUM_MAX)
      (eq! ABS_LOG_NUM ABS_LOG_NUM_MAX))))

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
        (eq! LIMB (* int_short (^ 256 LLARGEMO)))
        (eq! LIMB (* [INPUT 1] (^ 256 LLARGEMO))))
      (eq! nBYTES 1)
      (eq! PHASE_END 1))))

;; 4.2.3 Phase 2 : cumulative gas Ru  ;;
(defconstraint phase2 ()
  (if-eq [PHASE 2] 1
    (begin
      (eq! nSTEP 8)
      (rlpPrefixInt [INPUT 1] CT nSTEP DONE
                    [BYTE 1] [ACC 1] ACC_SIZE POWER BIT BIT_ACC
                    LIMB LC nBYTES)
      (if-eq DONE 1
        (begin
          (limbShifting [INPUT 1] POWER ACC_SIZE
                        LIMB nBYTES)
          (eq! PHASE_END 1))))))

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
              (eq! (shift nBYTES (- k 4)) LLARGE)))
          (eq! (+ (shift LC -4) (shift LC -3)) 1)
          (if-zero PHASE_SIZE
            (eq! PHASE_END 1))))
      (eq! INDEX_LOCAL (+ (prev INDEX_LOCAL) (* (prev LC) (- 1 (prev IS_PREFIX))))))))

;;  Phase 4: log series Rl    ;;

(defconstraint phase4-init (:guard [PHASE 4])
  (if-zero (prev [PHASE 4])
    (vanishes! (+ DEPTH_1 (- 1 IS_PREFIX) IS_TOPIC IS_DATA))))

(defconstraint phase4-phaseRlpPrefix (:guard [PHASE 4])
  (if-zero DEPTH_1
    (begin
      (eq! [INPUT 1] PHASE_SIZE)
      (if-zero [INPUT 1]
        (begin
          (eq! nSTEP 1)
          (eq! LIMB (* list_short (^ 256 LLARGEMO)))
          (eq! nBYTES 1)
          (eq! PHASE_END 1))
        (begin
          (eq! nSTEP 8)
          (rlpPrefixOfByteString [INPUT 1] CT nSTEP DONE [PHASE 4]
                                 ACC_SIZE POWER BIT [ACC 1] [ACC 2]
                                 LC LIMB nBYTES)
          (if-eq DONE 1
            (vanishes! (+ (- 1 (next DEPTH_1))
                          (- 1 (next IS_PREFIX))
                          (next IS_TOPIC)
                          (next IS_DATA)))))))))

(defconstraint phase4-logentryRlpPrefix (:guard [PHASE 4])
  (if-eq 1 (* DEPTH_1 IS_PREFIX (- 1 IS_TOPIC) (- 1 IS_PREFIX))
    (begin
      (eq! [INPUT 1] LOG_ENTRY_SIZE)
      (eq! nSTEP 8)
      (rlpPrefixOfByteString [INPUT 1] CT nSTEP DONE [PHASE 4]
                             ACC_SIZE POWER BIT [ACC 1] [ACC 2]
                             LC LIMB nBYTES)
      (if-eq DONE 1
        (vanishes! (+ (next IS_PREFIX) (next IS_TOPIC) (next IS_DATA)))))))

(defconstraint phase4-rlpAddress (:guard [PHASE 4])
  (if-zero (+ IS_PREFIX IS_TOPIC IS_DATA)
    (begin
      (eq! nSTEP 3)
      (eq! LC 1)
      (if-eq DONE 1
        (begin 
          (eq! (shift LIMB -2) (* (+ int_short 20) (^ 256 LLARGEMO)))
          (eq! (shift nBYTES -2) 1)
          (eq! (prev LIMB) (* [INPUT 1] (^ 256 12)))
          (eq! (prev LIMB) 4)
          (eq! LIMB [INPUT 2])
          (eq! nBYTES LLARGE)
          (vanishes! (+ (- 1 IS_PREFIX) (- 1 IS_TOPIC) IS_DATA)))))))

(defconstraint phase4-topic-prefix (:guard [PHASE 4])
  (if-eq (* IS_PREFIX IS_TOPIC) 1
    (begin
      (vanishes! INDEX_LOCAL)
      (eq! nSTEP 1)
      (if-zero LOCAL_SIZE
        (begin 
          (eq! LIMB (* list_short (^ 256 LLARGEMO)))
          (eq! nBYTES 1)
          (eq! (next [INPUT 2]) INDEX_LOCAL)
          (vanishes! (+ (- 1 (next IS_PREFIX))
                        (next IS_TOPIC)
                        (- 1 (next IS_DATA)))))
        (begin
          (if-eq-else LOCAL_SIZE 33
            (begin
              (eq! LIMB (* (+ list_short LOCAL_SIZE) (^ 256 LLARGEMO)))
              (eq! nBYTES 1))
            (begin
              (eq! LIMB (+ (* (+ list_long 1) (^ 256 LLARGEMO))
                           (* LOCAL_SIZE (^ 256 14))))
              (eq! nBYTES 2)))
          (vanishes! (+ (next IS_PREFIX)
                        (- 1 (next IS_TOPIC))
                        (next IS_DATA))))))))

(defconstraint phase4-topic (:guard [PHASE 4])
  (if-zero (+ IS_PREFIX (- 1 IS_TOPIC))
    (begin
      (eq! nSTEP 3)
      (eq! LC 1)
      (if-eq DONE 1
        (begin
          (eq! (+ INDEX_LOCAL (shift INDEX_LOCAL -2))
               (* 2 (+ (shift INDEX_LOCAL -3) 1)))
          (eq! (shift LIMB -2) (* (+ int_short 32) (^ 256 LLARGEMO)))
          (eq! (shift nBYTES -2) 1)
          (eq! (prev LIMB) [INPUT 1])
          (eq! (prev nBYTES) LLARGE)
          (eq! LIMB [INPUT 2])
          (eq! nBYTES LLARGE)
          (if-zero LOCAL_SIZE
            (begin
              (eq! (next [INPUT 2]) INDEX_LOCAL)
              (vanishes! (+ (- 1 (next IS_PREFIX)) 
                            (next IS_TOPIC) 
                            (- 1 (next IS_DATA)))))
            (vanishes! (+ (next IS_PREFIX)
                          (- 1 (next IS_TOPIC))
                          (next IS_DATA)))))))))
                      
(defconstraint phase4-dataprefix (:guard [PHASE 4])
  (if-eq (* IS_PREFIX IS_DATA) 1
    (begin
      (eq! [INPUT 1] LOCAL_SIZE)
      (if-zero LOCAL_SIZE
        (begin 
          (eq! nSTEP 1)
          (vanishes! LC_CORRECTION)
          (eq! LIMB (* int_short (^ 256 LLARGEMO)))
          (eq! nBYTES 1)
          (vanishes! LOG_ENTRY_SIZE)
          (if-zero PHASE_SIZE
            (eq! PHASE_END 1)
            (vanishes! (+ (- 1 (next IS_PREFIX))
                          (next IS_TOPIC)
                          (next IS_DATA)))))
        (begin
          (eq! nSTEP 8)
          (if-eq-else LOCAL_SIZE 1
            (begin
              (rlpPrefixInt [INPUT 3] CT nSTEP DONE
                            [BYTE 1] [ACC 1] ACC_SIZE POWER BIT BIT_ACC
                            LIMB LC nBYTES)
              (if-eq DONE 1
                (begin
                  (eq! (+ (prev LC_CORRECTION) LC_CORRECTION) 1)
                  (eq! (* [INPUT 3] (^ 256 LLARGEMO)) (next [INPUT 1])))))
            (begin
              (vanishes! LC_CORRECTION)
              (rlpPrefixOfByteString [INPUT 1] CT nSTEP DONE [PHASE 0]
                                     ACC_SIZE POWER BIT [ACC 1] [ACC 2]
                                     LC LIMB nBYTES)))
            (if-eq DONE 1
              (vanishes! (+ (next IS_PREFIX)
                            (next IS_TOPIC)
                            (- 1 (next IS_DATA))))))))))

(defconstraint phase4-data (:guard [PHASE 4])
  (if-zero (+ IS_PREFIX (- 1 IS_DATA))
    (begin
      (eq! INDEX_LOCAL CT)
      (eq! LC 1)
      (eq! LIMB [INPUT 1])
      (if-zero DONE
        (eq! nBYTES LLARGE)
        (begin
          (vanishes! LOCAL_SIZE)
          (vanishes! LOG_ENTRY_SIZE)
          (if-zero PHASE_SIZE
            (eq! PHASE_END 1)
            (vanishes! (+ (- 1 (next IS_PREFIX))
                          (next IS_TOPIC)
                          (next IS_DATA)))))))))

(defconstraint phase4-logEntrySize-update (:guard [PHASE 4])
  (if-zero (+ (- 1 DEPTH_1) (* IS_PREFIX (- 1 IS_TOPIC) (- 1 IS_DATA)))
    (eq! LOG_ENTRY_SIZE (- (prev LOG_ENTRY_SIZE) (* LC nBYTES)))))

(defconstraint phase4-localsize-update (:guard [PHASE 4])
  (if-zero (+ IS_PREFIX (- 1 (+ IS_TOPIC IS_DATA)))
    (eq! LOCAL_SIZE (- (prev LOCAL_SIZE) (* LC nBYTES)))))