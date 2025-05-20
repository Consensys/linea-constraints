(module hubshan)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                               ;;;;
;;;;    X.5 Instruction handling   ;;;;
;;;;                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;    X.5.10 Keccak   ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;;  Shorthands  ;;
;;;;;;;;;;;;;;;;;;

(defconst    ROFF___KEC___MISCELLANEOUS_ROW   1)

(defun   (keccak-instruction---offset-hi)             [ stack/STACK_ITEM_VALUE_HI 1 ])
(defun   (keccak-instruction---offset-lo)             [ stack/STACK_ITEM_VALUE_LO 1 ])
(defun   (keccak-instruction---size-hi)               [ stack/STACK_ITEM_VALUE_HI 2 ])
(defun   (keccak-instruction---size-lo)               [ stack/STACK_ITEM_VALUE_LO 2 ])
(defun   (keccak-instruction---result-hi)             [ stack/STACK_ITEM_VALUE_HI 4 ])
(defun   (keccak-instruction---result-lo)             [ stack/STACK_ITEM_VALUE_LO 4 ]) ;; ""
(defun   (keccak-instruction---mxpx)                  (shift    misc/MXP_MXPX      ROFF___KEC___MISCELLANEOUS_ROW))
(defun   (keccak-instruction---mxp-gas)               (shift    misc/MXP_GAS_MXP   ROFF___KEC___MISCELLANEOUS_ROW))
(defun   (keccak-instruction---mxp-MTNTOP)            (shift    misc/MXP_MTNTOP    ROFF___KEC___MISCELLANEOUS_ROW))
(defun   (keccak-instruction---trigger_MMU)           (* (- 1 XAHOY) (keccak-instruction---mxp-MTNTOP)))
(defun   (keccak-instruction---no-stack-exceptions)   (* PEEK_AT_STACK stack/KEC_FLAG (- 1 stack/SUX stack/SOX)))

(defconstraint    keccak-instruction---setting-stack-pattern (:guard (keccak-instruction---no-stack-exceptions))
                  (stack-pattern-2-1))

(defconstraint    keccak-instruction---allowable-exceptions (:guard (keccak-instruction---no-stack-exceptions))
                  (eq!    XAHOY
                          (+    stack/MXPX
                                stack/OOGX)))

(defconstraint    keccak-instruction---setting-NSR-and-peeking-flags (:guard (keccak-instruction---no-stack-exceptions))
                  (begin (eq! NON_STACK_ROWS (+ 1 CONTEXT_MAY_CHANGE))
                         (eq! NON_STACK_ROWS
                              (+ (shift PEEK_AT_MISCELLANEOUS 1)
                                 (* (shift PEEK_AT_CONTEXT 2) CONTEXT_MAY_CHANGE)))))

(defconstraint    keccak-instruction---setting-MISC-flags (:guard (keccak-instruction---no-stack-exceptions))
                  (eq! (weighted-MISC-flag-sum 1)
                       (+ MISC_WEIGHT_MXP
                          (* MISC_WEIGHT_MMU (keccak-instruction---trigger_MMU)))))

(defconstraint    keccak-instruction---setting-MXP-parameters (:guard (keccak-instruction---no-stack-exceptions))
                  (set-MXP-instruction-type-4 1                                  ;; row offset kappa
                                              EVM_INST_SHA3                      ;; instruction
                                              0                                  ;; deploys (bit modifying the behaviour of RETURN pricing)
                                              (keccak-instruction---offset-hi)   ;; source offset high
                                              (keccak-instruction---offset-lo)   ;; source offset low
                                              (keccak-instruction---size-hi)     ;; source size high
                                              (keccak-instruction---size-lo)     ;; source size low
                                              ))

(defconstraint    keccak-instruction---setting-MMU-parameters (:guard (keccak-instruction---no-stack-exceptions))
                  (if-not-zero misc/MMU_FLAG
                               (set-MMU-instruction---ram-to-exo-with-padding    1                        ;; offset
                                                                                 CN                       ;; source ID
                                                                                 0                        ;; target ID
                                                                                 (+ 1 HUB_STAMP)          ;; auxiliary ID
                                                                                 ;; src_offset_hi             ;; source offset high
                                                                                 (keccak-instruction---offset-lo)       ;; source offset low
                                                                                 ;; tgt_offset_lo             ;; target offset low
                                                                                 (keccak-instruction---size-lo)         ;; size
                                                                                 ;; ref_offset                ;; reference offset
                                                                                 (keccak-instruction---size-lo)         ;; reference size
                                                                                 0                        ;; success bit
                                                                                 ;; limb_1                    ;; limb 1
                                                                                 ;; limb_2                    ;; limb 2
                                                                                 EXO_SUM_WEIGHT_KEC       ;; weighted exogenous module flag sum
                                                                                 0                        ;; phase
                                                                                 )))

(defconstraint    keccak-instruction---transferring-MXPX-to-stack
                  (:guard (keccak-instruction---no-stack-exceptions))
                  (eq! stack/MXPX (keccak-instruction---mxpx)))

(defconstraint    keccak-instruction---setting-gas-cost
                  (:guard (keccak-instruction---no-stack-exceptions))
                  ;; (if-zero (force-bin (keccak-instruction---mxpx))
                  (if-zero (keccak-instruction---mxpx)
                           (eq! GAS_COST (+ stack/STATIC_GAS (keccak-instruction---mxp-gas)))
                           (vanishes! GAS_COST)))

(defconstraint    keccak-instruction---setting-setting-HASH_INFO_FLAG
                  (:guard (keccak-instruction---no-stack-exceptions))
                  (eq! stack/HASH_INFO_FLAG (keccak-instruction---trigger_MMU)))

(defconstraint    keccak-instruction---setting-value-constraints (:guard (keccak-instruction---no-stack-exceptions))
                  (if-zero XAHOY
                           ;; (if-zero (force-bin (keccak-instruction---trigger_MMU))
                           (if-zero (keccak-instruction---trigger_MMU)
                                    (begin (eq! (keccak-instruction---result-hi) EMPTY_KECCAK_HI)
                                           (eq! (keccak-instruction---result-lo) EMPTY_KECCAK_LO))
                                    (begin (eq! (keccak-instruction---result-hi) stack/HASH_INFO_KECCAK_HI)
                                           (eq! (keccak-instruction---result-lo) stack/HASH_INFO_KECCAK_LO)))))

