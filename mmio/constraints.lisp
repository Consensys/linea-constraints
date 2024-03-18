(module mmio)

;;
;; Instruction decoding
;;
(defun (mmio_inst_weight)
  (+ (* MMIO_INST_LIMB_VANISHES IS_LIMB_VANISHES)
     (* MMIO_INST_LIMB_TO_RAM_TRANSPLANT IS_LIMB_TO_RAM_TRANSPLANT)
     (* MMIO_INST_LIMB_TO_RAM_ONE_TARGET IS_LIMB_TO_RAM_ONE_TARGET)
     (* MMIO_INST_LIMB_TO_RAM_TWO_TARGET IS_LIMB_TO_RAM_TWO_TARGET)
     (* MMIO_INST_RAM_TO_LIMB_TRANSPLANT IS_RAM_TO_LIMB_TRANSPLANT)
     (* MMIO_INST_RAM_TO_LIMB_ONE_SOURCE IS_RAM_TO_LIMB_ONE_SOURCE)
     (* MMIO_INST_RAM_TO_LIMB_TWO_SOURCE IS_RAM_TO_LIMB_TWO_SOURCE)
     (* MMIO_INST_RAM_TO_RAM_TRANSPLANT IS_RAM_TO_RAM_TRANSPLANT)
     (* MMIO_INST_RAM_TO_RAM_PARTIAL IS_RAM_TO_RAM_PARTIAL)
     (* MMIO_INST_RAM_TO_RAM_TWO_TARGET IS_RAM_TO_RAM_TWO_TARGET)
     (* MMIO_INST_RAM_TO_RAM_TWO_SOURCE IS_RAM_TO_RAM_TWO_SOURCE)
     (* MMIO_INST_RAM_EXCISION IS_RAM_EXCISION)
     (* MMIO_INST_RAM_VANISHES IS_RAM_VANISHES)))

(defconstraint decoding-mmio-instruction-flag ()
  (eq! MMIO_INSTRUCTION (mmio_inst_weight)))

(defun (fast-op-flag-sum)
  (force-bool (+ IS_LIMB_VANISHES
                 IS_LIMB_TO_RAM_TRANSPLANT
                 IS_RAM_TO_LIMB_TRANSPLANT
                 IS_RAM_TO_RAM_TRANSPLANT
                 IS_RAM_VANISHES)))

(defconstraint fast-op ()
  (eq! FAST (fast-op-flag-sum)))

(defun (slow-op-flag-sum)
  (force-bool (+ IS_LIMB_TO_RAM_ONE_TARGET
                 IS_LIMB_TO_RAM_TWO_TARGET
                 IS_RAM_TO_LIMB_ONE_SOURCE
                 IS_RAM_TO_LIMB_TWO_SOURCE
                 IS_RAM_TO_RAM_PARTIAL
                 IS_RAM_TO_RAM_TWO_TARGET
                 IS_RAM_TO_RAM_TWO_SOURCE
                 IS_RAM_EXCISION)))

(defconstraint slow-op ()
  (eq! SLOW (slow-op-flag-sum)))

(defun (op-flag-sum)
  (force-bool (+ (fast-op-flag-sum) (slow-op-flag-sum))))

(defconstraint no-stamp-no-op ()
  (if-zero MMIO_STAMP
           (vanishes! (op-flag-sum))
           (eq! (op-flag-sum) 1)))

(defun (weighted-exo-sum)
  (+ (* EXO_SUM_WEIGHT_ROM EXO_IS_ROM)
     (* EXO_SUM_WEIGHT_KEC EXO_IS_KEC)
     (* EXO_SUM_WEIGHT_LOG EXO_IS_LOG)
     (* EXO_SUM_WEIGHT_TXCD EXO_IS_TXCD)
     (* EXO_SUM_WEIGHT_ECDATA EXO_IS_ECDATA)
     (* EXO_SUM_WEIGHT_RIPSHA EXO_IS_RIPSHA)
     (* EXO_SUM_WEIGHT_BLAKEMODEXP EXO_IS_BLAKEMODEXP)))

(defconstraint exo-sum-decoding ()
  (eq! EXO_SUM (weighted-exo-sum)))

(defun (instruction-may-provide-exo-sum)
  (force-bool (+ IS_LIMB_VANISHES
                 IS_LIMB_TO_RAM_TRANSPLANT
                 IS_LIMB_TO_RAM_ONE_TARGET
                 IS_LIMB_TO_RAM_TWO_TARGET
                 IS_RAM_TO_LIMB_TRANSPLANT
                 IS_RAM_TO_LIMB_ONE_SOURCE
                 IS_RAM_TO_LIMB_TWO_SOURCE)))

(defconstraint no-exo-when-not-needed ()
  (if-zero (instruction-may-provide-exo-sum)
           (vanishes! EXO_SUM)))

;;
;; Heartbeat
;;
(defconstraint first-row (:domain {0})
  (vanishes! MMIO_STAMP))

(defconstraint stamp-increment ()
  (any! (will-remain-constant! STAMP) (will-inc! STAMP 1)))

(defconstraint stamp-reset-ct ()
  (if-not-zero (- STAMP (prev STAMP))
               (vanishes! CT)))

(defconstraint fast-is-one-row (:guard FAST)
  (will-inc! STAMP 1))

(defconstraint slow-is-llarge-rows (:guard SLOW)
  (if-eq-else CT LLARGEMO (will-inc! STAMP 1) (will-inc! CT 1)))

(defconstraint last-row-is-finish (:domain {-1})
  (if-not-zero STAMP
               (if-eq SLOW 1 (eq! CT LLARGEMO))))

;;
;; Byte decompsition
;;
(defconstraint byte-decompositions ()
  (begin (byte-decomposition CT VAL_A BYTE_A)
         (byte-decomposition CT VAL_B BYTE_B)
         (byte-decomposition CT VAL_C BYTE_C)
         (byte-decomposition CT LIMB BYTE_LIMB)))

;;
;; Counter constancies
;;
(defconstraint counter-constancies ()
  (begin (counter-constancy CT CN_A)
         (counter-constancy CT CN_B)
         (counter-constancy CT CN_C)
         (counter-constancy CT INDEX_A)
         (counter-constancy CT INDEX_B)
         (counter-constancy CT INDEX_C)
         (counter-constancy CT VAL_A)
         (counter-constancy CT VAL_B)
         (counter-constancy CT VAL_C)
         (counter-constancy CT VAL_A_NEW)
         (counter-constancy CT VAL_B_NEW)
         (counter-constancy CT VAL_C_NEW)
         (counter-constancy CT INDEX_X)))

;;
;; Specialized constraint
;;
;Plateau
(defun (plateau X C CT)
  (if-zero C
           (eq! X 1)
           (if-zero CT
                    (vanishes! X)
                    (if-eq-else CT C (eq! X 1) (remained-constant! X)))))

;Power
(defun (power P X CT)
  (if-zero CT
           (if-zero X
                    (eq! P 1)
                    (eq! P 256))
           (if-zero X
                    (remained-constant! P)
                    (eq! P
                         (* (prev P) 256)))))

;AntiPower
(defun (antipower P X CT)
  (if-zero CT
           (if-zero X
                    (eq! P 256)
                    (eq! P 1))
           (if-zero X
                    (eq! P
                         (* (prev P) 256))
                    (remained-constant! P))))

;IsolateSuffix
(defun (isolate-suffix ACC B X CT)
  (if-zero CT
           (if-zero X
                    (vanishes! ACC)
                    (eq! ACC B))
           (if-zero X
                    (remained-constant! ACC)
                    (eq! ACC
                         (+ (* 256 (prev ACC))
                            B)))))

;IsolatePrefix
(defun (isolate-prefix ACC B X CT)
  (if-zero CT
           (if-zero X
                    (eq! ACC B)
                    (vanishes! ACC))
           (if-zero X
                    (eq! ACC
                         (+ (* 256 (prev ACC))
                            B))
                    (remained-constant! ACC))))

;IsolateChunk
(defun (isolate-chunk ACC B X Y CT)
  (if-zero CT
           (if-zero X
                    (vanishes! ACC)
                    (eq! ACC B))
           (if-zero X
                    (vanishes! ACC)
                    (if-zero Y
                             (eq! ACC
                                  (+ (* 256 (prev ACC))
                                     B))
                             (remained-constant! ACC)))))

;;
;; Surgical Patterns
;; 
;Excision
(defun (excision T T_NEW TB ACC P TM SIZE BIT1 BIT2 CT)
  (begin (plateau BIT1 TM CT)
         (plateau BIT2 (+ TM SIZE) CT)
         (isolate-chunk ACC TB BIT1 BIT2 CT)
         (power P BIT2 CT)
         (if-eq CT LLARGEMO
                (eq! T_NEW
                     (- T (* ACC P))))))

;[1 => 1 Padded]
(defun (one-to-one-padded S T SB ACC P SM SIZE BIT1 BIT2 BIT3 CT)
  (begin (plateau BIT1 SM CT)
         (plateau BIT2 (+ SM SIZE) CT)
         (plateau BIT3 SIZE CT)
         (isolate-chunk ACC SB BIT1 BIT2 CT)
         (power P BIT3 CT)
         (if-eq CT LLARGEMO
                (eq! T (* ACC P)))))

;[2 => 1 Padded]
(defun (two-to-one-padded S1 S2 T S1B S2B ACC1 ACC2 P1 P2 S1M SIZE BIT1 BIT2 BIT3 BIT4 CT)
  (begin (plateau BIT1 S1M CT)
         (plateau BIT2
                  (+ S1M (- SIZE LLARGE))
                  CT)
         (plateau BIT3 (- LLARGE S1M) CT)
         (plateau BIT4 SIZE CT)
         (isolate-suffix ACC1 S1B BIT1 CT)
         (isolate-prefix ACC2 S2B BIT2 CT)
         (power P1 BIT3 CT)
         (power P2 BIT4 CT)
         (if-eq CT LLARGEMO
                (eq! T
                     (+ (* ACC1 P1) (* ACC2 P2))))))

;[1 Partial => 1]
(defun (one-partial-to-one S T T_NEW SB TB ACC1 ACC2 P SM TM SIZE BIT1 BIT2 BIT3 BIT4 CT)
  (begin (plateau BIT1 TM CT)
         (plateau BIT2 (+ TM SIZE) CT)
         (plateau BIT3 SM CT)
         (plateau BIT4 (+ SM SIZE) CT)
         (isolate-chunk ACC1 TB BIT1 BIT2 CT)
         (isolate-chunk ACC2 SB BIT3 BIT4 CT)
         (power P BIT2 CT)
         (if-eq CT LLARGEMO
                (eq! T_NEW
                     (+ T
                        (* (- ACC2 ACC1) P))))))

;[1 Partial => 2]
(defun (one-partial-to-two S
                           T1
                           T2
                           T1_NEW
                           T2_NEW
                           SB
                           T1B
                           T2B
                           ACC1
                           ACC2
                           ACC3
                           ACC4
                           P
                           SM
                           T1M
                           SIZE
                           BIT1
                           BIT2
                           BIT3
                           BIT4
                           BIT5
                           CT)
  (begin (plateau BIT1 T1M CT)
         (plateau BIT2
                  (- (+ T1M SIZE) LLARGE)
                  CT)
         (plateau BIT3 SM CT)
         (plateau BIT4
                  (- (+ SM LLARGE) T1M)
                  CT)
         (plateau BIT5 (+ SM SIZE) CT)
         (isolate-suffix ACC1 T1B BIT1 CT)
         (isolate-prefix ACC2 T2B BIT2 CT)
         (isolate-chunk ACC3 SB BIT3 BIT4 CT)
         (isolate-chunk ACC4 SB BIT4 BIT5 CT)
         (power P BIT2 CT)
         (if-eq CT LLARGEMO
                (begin (eq! T1_NEW
                            (+ T1 (- ACC3 ACC1)))
                       (eq! T2_NEW
                            (+ T2
                               (* (- ACC4 ACC2) P)))))))

;[2 Partial => 1]
(defun (two-partial-to-one S1 S2 T T_NEW S1B S2B TB ACC1 ACC2 ACC3 P1 P2 SM TM SIZE BIT1 BIT2 BIT3 BIT4 CT)
  (begin (plateau BIT1 SM CT)
         (plateau BIT2
                  (- (+ SM SIZE) LLARGE)
                  CT)
         (plateau BIT3 TM CT)
         (plateau BIT4 (+ TM SIZE) CT)
         (isolate-suffix ACC1 S1B BIT1 CT)
         (isolate-prefix ACC2 S2B BIT2 CT)
         (isolate-chunk ACC3 TB BIT3 BIT4 CT)
         (power P1 BIT4 CT)
         (antipower P2 BIT2 CT)))

;;
;; MMIO INSTRUCTION CONSTRAINTS
;;
(defconstraint limb-vanishes (:guard IS_LIMB_VANISHES)
  (begin (vanishes! CN_A)
         (vanishes! CN_B)
         (vanishes! CN_C)
         (eq! INDEX_X TLO)
         (vanishes! LIMB)))

(defconstraint limb-to-ram-transplant (:guard IS_LIMB_TO_RAM_TRANSPLANT)
  (begin (eq! CN_A CNT)
         (vanishes! CN_B)
         (vanishes! CN_B)
         (eq! INDEX_A TLO)
         (eq! VAL_A_NEW LIMB)
         (eq! INDEX_X SLO)))

(defconstraint limb-to-ram-one-target (:guard IS_LIMB_TO_RAM_ONE_TARGET)
  (begin (eq! CN_A CNT)
         (vanishes! CN_B)
         (vanishes! CN_C)
         (eq! INDEX_A TLO)
         (eq! INDEX_X SLO)
         (one-partial-to-one LIMB VAL_A VAL_A_NEW BYTE_LIMB BYTE_A [ACC 1] [ACC 2] [POW_256 1] SBO TBO SIZE [BIT 1] [BIT 2] [BIT 3] [BIT 4] CT)))

(defconstraint limb-to-ram-two-target (:guard IS_LIMB_TO_RAM_TWO_TARGET)
  (begin (eq! CN_A CNT)
         (eq! CN_B CNT)
         (vanishes! CN_C)
         (eq! INDEX_A TLO)
         (eq! INDEX_B (+ TLO 1))
         (eq! INDEX_X SLO)
         (one-partial-to-two LIMB
                             VAL_A
                             VAL_B
                             VAL_A_NEW
                             VAL_B_NEW
                             BYTE_LIMB
                             BYTE_A
                             BYTE_B
                             [ACC 1]
                             [ACC 2]
                             [ACC 3]
                             [ACC 4]
                             [POW_256 1]
                             SLO
                             TLO
                             SIZE
                             [BIT 1]
                             [BIT 2]
                             [BIT 3]
                             [BIT 4]
                             [BIT 5]
                             CT)))

(defconstraint ram-to-limb-transplant (:guard IS_RAM_TO_LIMB_TRANSPLANT)
  (begin (eq! CN_A CNS)
         (vanishes! CN_B)
         (vanishes! CN_B)
         (eq! INDEX_A SLO)
         (eq! VAL_A_NEW VAL_A)
         (eq! INDEX_X TLO)
         (eq! LIMB VAL_A)))

(defconstraint ram-to-limb-one-source (:guard IS_RAM_TO_LIMB_ONE_SOURCE)
  (begin (eq! CN_A CNS)
         (vanishes! CN_B)
         (vanishes! CN_B)
         (eq! INDEX_A SLO)
         (eq! VAL_A_NEW VAL_A)
         (eq! INDEX_X TLO)
         (one-to-one-padded VAL_A LIMB BYTE_A [ACC 1] [POW_256 1] SBO SIZE [BIT 1] [BIT 2] [BIT 3] CT)))

(defconstraint ram-to-limb-two-source (:guard IS_RAM_TO_LIMB_TWO_SOURCE)
  (begin (eq! CN_A CNS)
         (eq! CN_B CNS)
         (vanishes! CN_C)
         (eq! INDEX_A SLO)
         (eq! INDEX_B (+ SLO 1))
         (eq! VAL_A_NEW VAL_A)
         (eq! VAL_B_NEW VAL_B)
         (eq! INDEX_X TLO)
         (two-to-one-padded VAL_A VAL_B LIMB BYTE_A BYTE_B [ACC 1] [ACC 2] [POW_256 1] [POW_256 2] SBO SIZE [BIT 1] [BIT 2] [BIT 3] [BIT 4] CT)))

(defconstraint ram-to-ram-transplant (:guard IS_RAM_TO_RAM_TRANSPLANT)
  (begin (eq! CN_A CNS)
         (eq! CN_B CNT)
         (vanishes! CN_C)
         (eq! INDEX_A SLO)
         (eq! INDEX_B TLO)
         (eq! VAL_A_NEW VAL_A)
         (eq! VAL_B_NEW VAL_A)))

(defconstraint ram-to-ram-partial (:guard IS_RAM_TO_RAM_PARTIAL)
  (begin (eq! CN_A CNS)
         (eq! CN_B CNT)
         (vanishes! CN_C)
         (eq! INDEX_A SLO)
         (eq! INDEX_B TLO)
         (eq! VAL_A_NEW VAL_A)
         (one-partial-to-one VAL_A VAL_B VAL_B_NEW BYTE_A BYTE_B [ACC 1] [ACC 2] [POW_256 1] SBO TBO SIZE [BIT 1] [BIT 2] [BIT 3] [BIT 4] CT)))

(defconstraint ram-to-ram-two-target (:guard IS_RAM_TO_RAM_TWO_TARGET)
  (begin (eq! CN_A CNS)
         (eq! CN_B CNT)
         (eq! CN_C CNT)
         (eq! INDEX_A SLO)
         (eq! INDEX_B TLO)
         (eq! INDEX_C (+ TLO 1))
         (eq! VAL_A_NEW VAL_A)
         (one-partial-to-two VAL_A
                             VAL_B
                             VAL_C
                             VAL_B_NEW
                             VAL_C_NEW
                             BYTE_A
                             BYTE_B
                             BYTE_C
                             [ACC 1]
                             [ACC 2]
                             [ACC 3]
                             [ACC 4]
                             [POW_256 1]
                             SBO
                             TBO
                             SIZE
                             [BIT 1]
                             [BIT 2]
                             [BIT 3]
                             [BIT 4]
                             [BIT 5]
                             CT)))

(defconstraint ram-to-ram-two-source (:guard IS_RAM_TO_RAM_TWO_SOURCE)
  (begin (eq! CN_A CNS)
         (eq! CN_B CNS)
         (eq! CN_C CNT)
         (eq! INDEX_A SLO)
         (eq! INDEX_B (+ SLO 1))
         (eq! INDEX_C TLO)
         (eq! VAL_A_NEW VAL_A)
         (eq! VAL_B_NEW VAL_B)
         (two-partial-to-one VAL_A VAL_B VAL_C VAL_C_NEW BYTE_A BYTE_B BYTE_C [ACC 1] [ACC 2] [ACC 3] [POW_256 1] [POW_256 2] SBO TBO SIZE [BIT 1] [BIT 2] [BIT 3] [BIT 4] CT)))

(defconstraint ram-excision (:guard IS_RAM_EXCISION)
  (begin (eq! CN_A CNT)
         (vanishes! CN_B)
         (vanishes! CN_C)
         (eq! INDEX_A TLO)
         (excision VAL_A VAL_A_NEW BYTE_A [ACC 1] [POW_256 1] TBO SIZE [BIT 1] [BIT 2] CT)))

(defconstraint ram-vanishes (:guard IS_RAM_VANISHES)
  (begin (eq! CN_A CNT)
         (vanishes! CN_B)
         (vanishes! CN_C)
         (eq! INDEX_A TLO)
         (vanishes! VAL_A_NEW)))


