(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                ;;;;
;;;;    X.Y CALL    ;;;;
;;;;                ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                      ;;
;;    X.Y.Z.5 ECADD, ECMUL and ECPAIRING constraints    ;;
;;                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;
;; Shorthands ;;
;;;;;;;;;;;;;;;;

(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---success-case)    (*    PEEK_AT_SCENARIO
                                                                                      (+    scenario/PRC_ECADD
                                                                                            scenario/PRC_ECMUL
                                                                                            scenario/PRC_ECPAIRING
                                                                                            (scenario-shorthand---PRC---common-BLS-address-bit-sum)
                                                                                            )
                                                                                      (scenario-shorthand---PRC---success)
                                                                                      ))

(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECADD)        (*    (precompile-processing---common---OOB-extract-call-data)    scenario/PRC_ECADD))
(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECMUL)        (*    (precompile-processing---common---OOB-extract-call-data)    scenario/PRC_ECMUL))
(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECPAIRING)    (*    (precompile-processing---common---OOB-extract-call-data)    scenario/PRC_ECPAIRING))
(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---trivial-ECPAIRING)       (*    (precompile-processing---common---OOB-empty-call-data)      scenario/PRC_ECPAIRING))

(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-cases)        (+    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECADD)
                                                                                              (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECMUL)
                                                                                              (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECPAIRING)
                                                                                              (scenario-shorthand---PRC---common-BLS-address-bit-sum)
                                                                                              ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Miscellaneous-row i + 2 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint    precompile-processing---ECADD_MUL_PAIRING_and_BLS---second-misc-row-peeking-flags
                  (:guard    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---success-case))
                  (eq!    (weighted-MISC-flag-sum    precompile-processing---ECADD_MUL_PAIRING_and_BLS---misc-row-offset---full-return-data-transfer)
                          (*    MISC_WEIGHT_MMU    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---trigger_MMU))))

(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---trigger_MMU)    (+    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECADD)
                                                                                     (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECMUL)
                                                                                     (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECPAIRING)
                                                                                     (precompile-processing---ECADD_MUL_PAIRING_and_BLS---trivial-ECPAIRING)
                                                                                     (scenario-shorthand---PRC---common-BLS-address-bit-sum)
                                                                                     ))

(defconstraint    precompile-processing---ECADD_MUL_PAIRING_and_BLS---setting-MMU-instruction---full-return-data-transfer---trivial-case
                  (:guard    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---success-case))
                  (if-not-zero    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---trivial-ECPAIRING)
                                  (set-MMU-instruction---mstore                    precompile-processing---ECADD_MUL_PAIRING_and_BLS---misc-row-offset---full-return-data-transfer   ;; offset
                                                                                   ;; src_id                                                                                   ;; source ID
                                                                                   (+    1    HUB_STAMP)                                                                    ;; target ID
                                                                                   ;; aux_id                                                                                   ;; auxiliary ID
                                                                                   ;; src_offset_hi                                                                            ;; source offset high
                                                                                   ;; src_offset_lo                                                                            ;; source offset low
                                                                                   0                                                                                        ;; target offset low
                                                                                   ;; size                                                                                     ;; size
                                                                                   ;; ref_offset                                                                               ;; reference offset
                                                                                   ;; ref_size                                                                                 ;; reference size
                                                                                   ;; success_bit                                                                              ;; success bit
                                                                                   0                                                                                        ;; limb 1
                                                                                   1                                                                                        ;; limb 2
                                                                                   ;; exo_sum                                                                                  ;; weighted exogenous module flag sum
                                                                                   ;; phase                                                                                    ;; phase
                                                                                   )))

(defconstraint    precompile-processing---ECADD_MUL_PAIRING_and_BLS---setting-MMU-instruction---full-return-data-transfer---nontrivial-cases
                  (:guard    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---success-case))
                  (if-not-zero    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-cases)
                                  (set-MMU-instruction---exo-to-ram-transplants    precompile-processing---ECADD_MUL_PAIRING_and_BLS---misc-row-offset---full-return-data-transfer    ;; offset
                                                                                   (+    1    HUB_STAMP)                                                                     ;; source ID
                                                                                   (+    1    HUB_STAMP)                                                                     ;; target ID
                                                                                   ;; aux_id                                                                                    ;; auxiliary ID
                                                                                   ;; src_offset_hi                                                                             ;; source offset high
                                                                                   ;; src_offset_lo                                                                             ;; source offset low
                                                                                   ;; tgt_offset_lo                                                                             ;; target offset low
                                                                                   (precompile-processing---ECADD_MUL_PAIRING_and_BLS---return-data-size)                            ;; size
                                                                                   ;; ref_offset                                                                                ;; reference offset
                                                                                   ;; ref_size                                                                                  ;; reference size
                                                                                   ;; success_bit                                                                               ;; success bit
                                                                                   ;; limb_1                                                                                    ;; limb 1
                                                                                   ;; limb_2                                                                                    ;; limb 2
                                                                                   (precompile-processing---ECADD_MUL_PAIRING_and_BLS---exo-sum)                             ;; weighted exogenous module flag sum
                                                                                   (precompile-processing---ECADD_MUL_PAIRING_and_BLS---return-data-phase)                           ;; phase
                                                                                   )))

(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---return-data-size)     (+    (*    ECADD_RETURN_DATA_SIZE                (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECADD)     )
                                                                                           (*    ECMUL_RETURN_DATA_SIZE                (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECMUL)     )
                                                                                           (*    ECPAIRING_RETURN_DATA_SIZE            (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECPAIRING) )
                                                                                           (*    POINT_EVALUATION_RETURN_DATA_SIZE      scenario/PRC_POINT_EVALUATION                                             )
                                                                                           (*    BLS_G1_ADD_RETURN_DATA_SIZE            scenario/PRC_BLS_G1_ADD                                                   )
                                                                                           (*    BLS_G1_MSM_RETURN_DATA_SIZE            scenario/PRC_BLS_G1_MSM                                                   )
                                                                                           (*    BLS_G2_ADD_RETURN_DATA_SIZE            scenario/PRC_BLS_G2_ADD                                                   )
                                                                                           (*    BLS_G2_MSM_RETURN_DATA_SIZE            scenario/PRC_BLS_G2_MSM                                                   )
                                                                                           (*    BLS_PAIRING_CHECK_RETURN_DATA_SIZE     scenario/PRC_BLS_PAIRING_CHECK                                            )
                                                                                           (*    BLS_MAP_FP_TO_G1_RETURN_DATA_SIZE      scenario/PRC_BLS_MAP_FP_TO_G1                                             )
                                                                                           (*    BLS_MAP_FP2_TO_G2_RETURN_DATA_SIZE     scenario/PRC_BLS_MAP_FP2_TO_G2                                            )
                                                                                           ))

(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---return-data-phase)              (+    (*    PHASE_ECADD_RESULT                (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECADD)     )
                                                                                                     (*    PHASE_ECMUL_RESULT                (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECMUL)     )
                                                                                                     (*    PHASE_ECPAIRING_RESULT            (precompile-processing---ECADD_MUL_PAIRING_and_BLS---nontrivial-ECPAIRING) )
                                                                                                     (*    PHASE_POINT_EVALUATION_RESULT      scenario/PRC_POINT_EVALUATION                                             )
                                                                                                     (*    PHASE_BLS_G1_ADD_RESULT            scenario/PRC_BLS_G1_ADD                                                   )
                                                                                                     (*    PHASE_BLS_G1_MSM_RESULT            scenario/PRC_BLS_G1_MSM                                                   )
                                                                                                     (*    PHASE_BLS_G2_ADD_RESULT            scenario/PRC_BLS_G2_ADD                                                   )
                                                                                                     (*    PHASE_BLS_G2_MSM_RESULT            scenario/PRC_BLS_G2_MSM                                                   )
                                                                                                     (*    PHASE_BLS_PAIRING_CHECK_RESULT     scenario/PRC_BLS_PAIRING_CHECK                                            )
                                                                                                     (*    PHASE_BLS_MAP_FP_TO_G1_RESULT      scenario/PRC_BLS_MAP_FP_TO_G1                                             )
                                                                                                     (*    PHASE_BLS_MAP_FP2_TO_G2_RESULT     scenario/PRC_BLS_MAP_FP2_TO_G2                                            )
                                                                                                     ))


(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---exo-sum)    (+    (*    EXO_SUM_WEIGHT_ECDATA      scenario/PRC_ECADD                                     )
                                                                                 (*    EXO_SUM_WEIGHT_ECDATA      scenario/PRC_ECMUL                                     )
                                                                                 (*    EXO_SUM_WEIGHT_ECDATA      scenario/PRC_ECPAIRING                                 )
                                                                                 (*    EXO_SUM_WEIGHT_BLSDATA    (scenario-shorthand---PRC---common-BLS-address-bit-sum) )
                                                                                 ))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Miscellaneous-row i + 3 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint    precompile-processing---ECADD_MUL_PAIRING_and_BLS---third-misc-row-peeking-flags
                  (:guard    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---success-case))
                  (eq!    (weighted-MISC-flag-sum    precompile-processing---ECADD_MUL_PAIRING_and_BLS---misc-row-offset---partial-return-data-copy)
                          (*    MISC_WEIGHT_MMU
                                (precompile-processing---common---OOB-r@c-nonzero))))


(defconstraint    precompile-processing---ECADD_MUL_PAIRING_and_BLS---setting-the-MMU-instruction---partial-return-data-copy
                  (:guard    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---success-case))
                  (if-not-zero    (shift    misc/MMU_FLAG                           precompile-processing---ECADD_MUL_PAIRING_and_BLS---misc-row-offset---partial-return-data-copy)
                                  (set-MMU-instruction---ram-to-ram-sans-padding    precompile-processing---ECADD_MUL_PAIRING_and_BLS---misc-row-offset---partial-return-data-copy  ;; offset
                                                                                    (+    1    HUB_STAMP)                                                                   ;; source ID
                                                                                    CONTEXT_NUMBER                                                                          ;; target ID
                                                                                    ;; aux_id                                                                               ;; auxiliary ID
                                                                                    ;; src_offset_hi                                                                        ;; source offset high
                                                                                    0                                                                                       ;; source offset low
                                                                                    ;; tgt_offset_lo                                                                        ;; target offset low
                                                                                    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---return-data-reference-size)                ;; size
                                                                                    (precompile-processing---dup-r@o)                                                       ;; reference offset
                                                                                    (precompile-processing---dup-r@c)                                                       ;; reference size
                                                                                    ;; success_bit                                                                          ;; success bit
                                                                                    ;; limb_1                                                                               ;; limb 1
                                                                                    ;; limb_2                                                                               ;; limb 2
                                                                                    ;; exo_sum                                                                              ;; weighted exogenous module flag sum
                                                                                    ;; phase                                                                                ;; phase
                                                                                    )))

(defun    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---return-data-reference-size)     (+    (*    ECADD_RETURN_DATA_SIZE                 scenario/PRC_ECADD              )
                                                                                                     (*    ECMUL_RETURN_DATA_SIZE                 scenario/PRC_ECMUL              )
                                                                                                     (*    ECPAIRING_RETURN_DATA_SIZE             scenario/PRC_ECPAIRING          )
                                                                                                     (*    POINT_EVALUATION_RETURN_DATA_SIZE      scenario/PRC_POINT_EVALUATION   )
                                                                                                     (*    BLS_G1_ADD_RETURN_DATA_SIZE            scenario/PRC_BLS_G1_ADD         )
                                                                                                     (*    BLS_G1_MSM_RETURN_DATA_SIZE            scenario/PRC_BLS_G1_MSM         )
                                                                                                     (*    BLS_G2_ADD_RETURN_DATA_SIZE            scenario/PRC_BLS_G2_ADD         )
                                                                                                     (*    BLS_G2_MSM_RETURN_DATA_SIZE            scenario/PRC_BLS_G2_MSM         )
                                                                                                     (*    BLS_PAIRING_CHECK_RETURN_DATA_SIZE     scenario/PRC_BLS_PAIRING_CHECK  )
                                                                                                     (*    BLS_MAP_FP_TO_G1_RETURN_DATA_SIZE      scenario/PRC_BLS_MAP_FP_TO_G1   )
                                                                                                     (*    BLS_MAP_FP2_TO_G2_RETURN_DATA_SIZE     scenario/PRC_BLS_MAP_FP2_TO_G2  )
                                                                                                     ))


;;;;;;;;;;;;;;;;;;;;;;;
;; Context-row i + 4 ;;
;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint    precompile-processing---ECADD_MUL_PAIRING_and_BLS---updating-caller-context-with-precompile-return-data
                  (:guard    (precompile-processing---ECADD_MUL_PAIRING_and_BLS---success-case))
                  (provide-return-data     precompile-processing---ECADD_MUL_PAIRING_and_BLS---context-row-offset---updating-caller-context    ;; row offset
                                           CONTEXT_NUMBER                                                                             ;; receiver context
                                           (+    1    HUB_STAMP)                                                                      ;; provider context
                                           0                                                                                          ;; rdo
                                           (precompile-processing---ECADD_MUL_PAIRING_and_BLS---return-data-reference-size)                   ;; rds
                                           ))
