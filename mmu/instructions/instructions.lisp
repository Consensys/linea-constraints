(module mmu)

;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;  MMU Instructions  ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;



;;
;; ANY TO RAM WITH PADDING
;;
(defun (any-to-ram-min-tgt-offset) macro/TGT_OFFSET_LO)
(defun (any-to-ram-max-tgt-offset) (+ macro/TGT_OFFSET_LO (- macro/SIZE 1)))
(defun (any-to-ram-pure-padd) (force-bool (- 1 (next prprc/WCP_RES))))
(defun (any-to-ram-min-tlo) (next prprc/EUC_QUOT))
(defun (any-to-ram-min-tbo) (next prprc/EUC_REM))
(defun (any-to-ram-max-src-offset-or-zero) (* (- 1 (any-to-ram-pure-padd))
                                              (+ macro/SRC_OFFSET_LO (- macro/SIZE 1))))
(defun (any-to-ram-mixed) (force-bool (* (- 1 (any-to-ram-pure-padd))
                                         (- 1 (shift prprc/WCP_RES 2)))))
(defun (any-to-ram-pure-data) (force-bool (* (- 1 (any-to-ram-pure-padd)) (shift prprc/WCP_RES 2))))
(defun (any-to-ram-max-tlo) (shift prprc/EUC_QUOT 2))
(defun (any-to-ram-max-tbo) (shift prprc/EUC_REM 2))
(defun (any-to-ram-trsf-size) (+ (* (any-to-ram-mixed) (- macro/REF_SIZE macro/SRC_OFFSET_LO))
                                 (* (any-to-ram-pure-data) macro/SIZE)))
(defun (any-to-ram-padd-size) (+ (* (any-to-ram-pure-padd) macro/SIZE)
                                 (* (any-to-ram-mixed)
                                    (- macro/SIZE (- macro/REF_SIZE macro/SRC_OFFSET_LO)))))

(defconstraint any-to-ram-prprc-common (:guard (* MACRO (is-any-to-ram-with-padding)))
  (begin  ;; preprocessing row n°1
         (callToLt 1 macro/SRC_OFFSET_HI macro/SRC_OFFSET_LO macro/REF_SIZE)
         (callToEuc 1 (any-to-ram-min-tgt-offset) LLARGE)
         ;; preprocessing row n°2
         (callToLt 2 0 (any-to-ram-max-src-offset-or-zero) macro/REF_SIZE)
         (callToEuc 2 (any-to-ram-max-tgt-offset) LLARGE)
         ;; justifyng the flag
         (eq! IS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING (any-to-ram-pure-padd))
         (eq! IS_ANY_TO_RAM_WITH_PADDING_SOME_DATA (+ (any-to-ram-mixed) (any-to-ram-pure-data)))))

;;
;; PURE PADDING sub case
;;
(defun (any-to-ram-pure-padding-last-padding-is-full) [BIN 1])
(defun (any-to-ram-pure-padding-last-padding-size) [OUT 1])
(defun (any-to-ram-pure-padding-totrz-is-one) (shift prprc/WCP_RES 3))
(defun (any-to-ram-pure-padding-first-padding-is-full) (shift prprc/WCP_RES 4))
(defun (any-to-ram-pure-padding-only-padding-is-full) (* (any-to-ram-pure-padding-first-padding-is-full) (any-to-ram-pure-padding-last-padding-is-full)))
(defun (any-to-ram-pure-padding-first-padding-size) (- LLARGE (any-to-ram-min-tbo)))
(defun (any-to-ram-pure-padding-only-padding-size) (any-to-ram-padd-size))

(defconstraint any-to-ram-pure-padding-prprc (:guard (* MACRO IS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING))
  (begin  ;; setting number of rows
         (vanishes! TOTLZ)
         (vanishes! TOTNT)
         (eq! TOTRZ
              (+ (- (any-to-ram-max-tlo) (any-to-ram-min-tlo)) 1))
         ;; preprocessing row n°3
         (callToEq 3 0 TOTRZ 1)
         ;; preprocessing row n°4
         (callToIszero 4 0 (any-to-ram-min-tbo))
         (callToEuc 4 (+ 1 (any-to-ram-max-tbo)) LLARGE)
         (eq! (any-to-ram-pure-padding-last-padding-is-full)
              (* (- 1 (any-to-ram-pure-padding-totrz-is-one)) (shift prprc/EUC_QUOT 4)))
         (eq! (any-to-ram-pure-padding-last-padding-size)
              (* (- 1 (any-to-ram-pure-padding-totrz-is-one)) (+ 1 (any-to-ram-max-tbo))))
         ;; mmio constant values
         (eq! (shift micro/CN_T NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO) macro/TGT_ID)
         ;; first and only common mmio
         (eq! (shift micro/TLO NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO) (any-to-ram-min-tlo))
         (eq! (shift micro/TBO NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO) (any-to-ram-min-tbo))
         (if-zero (any-to-ram-pure-padding-totrz-is-one)
                  ;; first mmio
                  (begin (if-zero (any-to-ram-pure-padding-first-padding-is-full)
                                  (eq! (shift micro/INST NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO)
                                       MMIO_INST_RAM_EXCISION)
                                  (eq! (shift micro/INST NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO)
                                       MMIO_INST_RAM_VANISHES))
                         (eq! (shift micro/SIZE NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO)
                              (any-to-ram-pure-padding-first-padding-size)))
                  ;; only mmio
                  (begin (if-zero (any-to-ram-pure-padding-only-padding-is-full)
                                  (eq! (shift micro/INST NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO)
                                       MMIO_INST_RAM_EXCISION)
                                  (eq! (shift micro/INST NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO)
                                       MMIO_INST_RAM_VANISHES))
                         (eq! (shift micro/SIZE NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO)
                              (any-to-ram-pure-padding-only-padding-size))))))

(defconstraint any-to-ram-pure-padding-mmio-inst (:guard IS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING)
  (begin (if-eq (force-bool (+ RZ_MDDL RZ_LAST)) 1
                (begin (did-inc! micro/TLO 1)
                       (vanishes! micro/TBO)))
         (if-eq RZ_MDDL 1 (eq! micro/INST MMIO_INST_RAM_VANISHES))
         (if-eq RZ_LAST 1
                (begin (if-zero (any-to-ram-pure-padding-last-padding-is-full)
                                (eq! micro/INST MMIO_INST_RAM_EXCISION)
                                (eq! micro/INST MMIO_INST_RAM_VANISHES))
                       (eq! micro/SIZE (any-to-ram-pure-padding-last-padding-size))))))

;;
;; SOME DATA CASE
;;
(defun (any-to-ram-some-data-tlo-increment-after-first-dt) [BIN 1])
(defun (any-to-ram-some-data-aligned) [BIN 2])
(defun (any-to-ram-some-data-middle-tbo) [OUT 1])
(defun (any-to-ram-some-data-last-dt-single-target) [BIN 3])
(defun (any-to-ram-some-data-last-dt-size) [OUT 2])
(defun (any-to-ram-some-data-tlo-increment-at-transition) [BIN 4])
(defun (any-to-ram-some-data-first-pbo) [OUT 3])
(defun (any-to-ram-some-data-first-padding-size) [OUT 4])
(defun (any-to-ram-some-data-last-padding-size) [OUT 5])
(defun (any-to-ram-some-data-data-src-is-ram) [BIN 5])
(defun (any-to-ram-some-data-totnt-is-one) (shift prprc/WCP_RES 4))
(defun (any-to-ram-some-data-only-dt-size) (any-to-ram-trsf-size))
(defun (any-to-ram-some-data-first-dt-size) (- LLARGE (any-to-ram-some-data-min-sbo)))
(defun (any-to-ram-some-data-min-src-offset) (+ macro/SRC_OFFSET_LO macro/REF_OFFSET))
(defun (any-to-ram-some-data-min-slo) (shift prprc/EUC_QUOT 5))
(defun (any-to-ram-some-data-min-sbo) (shift prprc/EUC_REM 5))
(defun (any-to-ram-some-data-max-src-offset) (+ (any-to-ram-some-data-min-src-offset) (- (any-to-ram-trsf-size) 1)))
(defun (any-to-ram-some-data-max-slo) (shift prprc/EUC_QUOT 6))
(defun (any-to-ram-some-data-max-sbo) (shift prprc/EUC_REM 6))
(defun (any-to-ram-some-data-only-dt-single-target) (force-bool (- 1 (shift prprc/EUC_QUOT 7))))
(defun (any-to-ram-some-data-only-dt-maxes-out-target) (shift prprc/WCP_RES 7))
(defun (any-to-ram-some-data-first-dt-single-target) (force-bool (- 1 (shift prprc/EUC_QUOT 8))))
(defun (any-to-ram-some-data-first-dt-maxes-out-target) (shift prprc/WCP_RES 8))
(defun (any-to-ram-some-data-last-dt-maxes-out-target) (shift prprc/WCP_RES 9))
(defun (any-to-ram-some-data-first-padding-offset) (+ (any-to-ram-min-tgt-offset) (any-to-ram-trsf-size)))
(defun (any-to-ram-some-data-first-plo) (shift prprc/EUC_QUOT 10))
(defun (any-to-ram-some-data-last-plo) (any-to-ram-max-tlo))
(defun (any-to-ram-some-data-last-pbo) (any-to-ram-max-tbo))
(defun (any-to-ram-some-data-totrz-is-one) (shift prprc/WCP_RES 10))
(defun (any-to-ram-some-data-micro-cns) (* (any-to-ram-some-data-data-src-is-ram) macro/SRC_ID))
(defun (any-to-ram-some-data-micro-id1) (* (- 1 (any-to-ram-some-data-data-src-is-ram)) macro/SRC_ID))

(defconstraint any-to-ram-some-data-preprocessing (:guard (* MACRO IS_ANY_TO_RAM_WITH_PADDING_SOME_DATA))
  (begin  ;; preprocessing row n°3
         (callToIszero 3 0 macro/EXO_SUM)
         (eq! (any-to-ram-some-data-data-src-is-ram) (shift prprc/WCP_RES 3))
         ;; setting nb of rows
         (vanishes! TOTLZ)
         (eq! TOTNT
              (+ (- (any-to-ram-some-data-max-slo) (any-to-ram-some-data-min-slo)) 1))
         ;; preprocessing row n°4
         (callToEq 4 0 TOTNT 1)
         (eq! (any-to-ram-some-data-last-dt-size) (+ (any-to-ram-some-data-max-sbo) 1))
         ;; preprocessing row n°5
         (callToEuc 5 (any-to-ram-some-data-min-src-offset) LLARGE)
         (callToEq 5 0 (any-to-ram-min-tbo) (any-to-ram-some-data-min-sbo))
         (eq! (any-to-ram-some-data-aligned) (shift prprc/WCP_RES 5))
         ;; preprocessing row n°6
         (callToEuc 6 (any-to-ram-some-data-max-src-offset) LLARGE)
         ;; preprocessing row n°7
         (if-eq (any-to-ram-some-data-totnt-is-one) 1
                (begin (callToEuc 7
                                  (+ (any-to-ram-min-tbo) (- (any-to-ram-some-data-only-dt-size) 1))
                                  LLARGE)
                       (callToEq 7 0 (shift prprc/EUC_REM 7) LLARGEMO)))
         ;; preprocessing row n°8
         (if-zero (any-to-ram-some-data-totnt-is-one)
                  (begin (callToEuc 8
                                    (+ (any-to-ram-min-tbo) (- (any-to-ram-some-data-first-dt-size) 1))
                                    LLARGE)
                         (callToEq 8 0 (shift prprc/EUC_REM 8) LLARGEMO)
                         (if-zero (any-to-ram-some-data-first-dt-maxes-out-target)
                                  (eq! (any-to-ram-some-data-middle-tbo)
                                       (+ 1 (shift prprc/EUC_REM 8)))
                                  (vanishes! (any-to-ram-some-data-middle-tbo)))))
         ;; preprocessing row n°9
         (if-zero (any-to-ram-some-data-totnt-is-one)
                  (begin (callToEuc 9
                                    (+ (any-to-ram-some-data-middle-tbo)
                                       (- (any-to-ram-some-data-last-dt-size) 1))
                                    LLARGE)
                         (callToEq 9 0 (shift prprc/EUC_REM 9) LLARGEMO)
                         (eq! (any-to-ram-some-data-last-dt-single-target)
                              (- 1 (shift prprc/EUC_QUOT 9)))
                         (eq! (any-to-ram-some-data-last-dt-maxes-out-target) (shift prprc/WCP_RES 9))
                         (if-not-zero (any-to-ram-some-data-totnt-is-one)
                                      (vanishes! (any-to-ram-some-data-tlo-increment-after-first-dt))
                                      (if-zero (any-to-ram-some-data-first-dt-single-target)
                                               (eq! (any-to-ram-some-data-tlo-increment-after-first-dt) 1)
                                               (eq! (any-to-ram-some-data-tlo-increment-after-first-dt)
                                                    (any-to-ram-some-data-first-dt-maxes-out-target))))))
         ;; justifying tlo_increments_at_transition
         (if-eq-else (any-to-ram-some-data-totnt-is-one) 1
                     (if-zero (any-to-ram-some-data-only-dt-single-target)
                              (eq! (any-to-ram-some-data-tlo-increment-at-transition) 1)
                              (eq! (any-to-ram-some-data-tlo-increment-at-transition)
                                   (any-to-ram-some-data-only-dt-maxes-out-target)))
                     (if-zero (any-to-ram-some-data-last-dt-single-target)
                              (eq! (any-to-ram-some-data-tlo-increment-at-transition) 1)
                              (eq! (any-to-ram-some-data-tlo-increment-at-transition)
                                   (any-to-ram-some-data-last-dt-maxes-out-target))))
         ;; preprocessing row n°10
         (callToEq 10 0 TOTRZ 1)
         (callToEuc 10 (any-to-ram-some-data-first-padding-offset) LLARGE)
         (if-eq (any-to-ram-pure-data) 1 (vanishes! TOTRZ))
         (if-eq (any-to-ram-mixed) 1
                (eq! TOTRZ
                     (+ (- (any-to-ram-some-data-last-plo) (any-to-ram-some-data-first-plo)) 1)))
         (eq! (any-to-ram-some-data-first-pbo)
              (* (any-to-ram-mixed) (shift prprc/EUC_REM 10)))
         (if-eq-else (any-to-ram-some-data-totrz-is-one) 1
                     (eq! (any-to-ram-some-data-first-padding-size) (any-to-ram-padd-size))
                     (begin (eq! (any-to-ram-some-data-first-padding-size)
                                 (* (any-to-ram-mixed) (- LLARGE (any-to-ram-some-data-first-pbo))))
                            (eq! (any-to-ram-some-data-last-padding-size)
                                 (* (any-to-ram-mixed) (+ 1 (any-to-ram-some-data-last-pbo))))))
         ;; initialisation
         (eq! (shift micro/CN_S NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
              (any-to-ram-some-data-micro-cns))
         (eq! (shift micro/CN_T NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO) macro/TGT_ID)
         (eq! (shift micro/EXO_SUM NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO) macro/EXO_SUM)
         (eq! (shift micro/EXO_ID NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
              (any-to-ram-some-data-micro-id1))
         (eq! (shift micro/TOTAL_SIZE NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO) macro/REF_SIZE)
         ;; FIRST and ONLY mmio inst shared values
         (eq! (shift micro/SLO NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
              (any-to-ram-some-data-min-slo))
         (eq! (shift micro/SBO NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
              (any-to-ram-some-data-min-sbo))
         (eq! (shift micro/TLO NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO) (any-to-ram-min-tlo))
         (eq! (shift micro/TBO NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO) (any-to-ram-min-tbo))
         (if-eq-else (any-to-ram-some-data-totnt-is-one) 1
                     ;; ONLY mmio inst
                     (begin (if-eq-else (any-to-ram-some-data-data-src-is-ram) 1
                                        (if-zero (any-to-ram-some-data-only-dt-single-target)
                                                 (eq! (shift micro/INST
                                                             NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                                      MMIO_INST_RAM_TO_RAM_TWO_TARGET)
                                                 (eq! (shift micro/INST
                                                             NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                                      MMIO_INST_RAM_TO_RAM_PARTIAL))
                                        (if-zero (any-to-ram-some-data-only-dt-single-target)
                                                 (eq! (shift micro/INST
                                                             NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                                      MMIO_INST_LIMB_TO_RAM_TWO_TARGET)
                                                 (eq! (shift micro/INST
                                                             NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                                      MMIO_INST_LIMB_TO_RAM_ONE_TARGET)))
                            (eq! (shift micro/SIZE NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                 (any-to-ram-some-data-only-dt-size)))
                     ;; FIRST mmio inst
                     (begin (if-eq-else (any-to-ram-some-data-data-src-is-ram) 1
                                        (if-zero (any-to-ram-some-data-first-dt-single-target)
                                                 (eq! (shift micro/INST
                                                             NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                                      MMIO_INST_RAM_TO_RAM_TWO_TARGET)
                                                 (eq! (shift micro/INST
                                                             NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                                      MMIO_INST_RAM_TO_RAM_PARTIAL))
                                        (if-zero (any-to-ram-some-data-first-dt-single-target)
                                                 (eq! (shift micro/INST
                                                             NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                                      MMIO_INST_LIMB_TO_RAM_TWO_TARGET)
                                                 (eq! (shift micro/INST
                                                             NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                                      MMIO_INST_LIMB_TO_RAM_ONE_TARGET)))
                            (eq! (shift micro/SIZE NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO)
                                 (any-to-ram-some-data-first-dt-size))))))

(defconstraint any-to-ram-some-data-mmio-writting (:guard IS_ANY_TO_RAM_WITH_PADDING_SOME_DATA)
  (begin (if-eq NT_FIRST 1
                (begin (will-inc! micro/SLO 1)
                       (vanishes! (next micro/SBO))
                       (if-zero (any-to-ram-some-data-tlo-increment-after-first-dt)
                                (will-remain-constant! micro/TLO)
                                (will-inc! micro/TLO 1))
                       (will-eq! micro/TBO (any-to-ram-some-data-middle-tbo))))
         (if-eq NT_MDDL 1
                (begin (if-eq-else (any-to-ram-some-data-data-src-is-ram) 1
                                   (if-zero (any-to-ram-some-data-aligned)
                                            (eq! micro/INST MMIO_INST_RAM_TO_RAM_TWO_TARGET)
                                            (eq! micro/INST MMIO_INST_RAM_TO_RAM_TRANSPLANT))
                                   (if-zero (any-to-ram-some-data-aligned)
                                            (eq! micro/INST MMIO_INST_LIMB_TO_RAM_TWO_TARGET)
                                            (eq! micro/INST MMIO_INST_LIMB_TO_RAM_TRANSPLANT)))
                       (eq! micro/SIZE LLARGE)
                       (will-inc! micro/SLO 1)
                       (vanishes! (next micro/SBO))
                       (will-inc! micro/TLO 1)
                       (will-eq! micro/TBO (any-to-ram-some-data-middle-tbo))))
         (if-eq NT_LAST 1
                (begin (if-eq-else (any-to-ram-some-data-data-src-is-ram) 1
                                   (if-zero (any-to-ram-some-data-last-dt-single-target)
                                            (eq! micro/INST MMIO_INST_RAM_TO_RAM_TWO_TARGET)
                                            (eq! micro/INST MMIO_INST_RAM_TO_RAM_PARTIAL))
                                   (if-zero (any-to-ram-some-data-last-dt-single-target)
                                            (eq! micro/INST MMIO_INST_LIMB_TO_RAM_TWO_TARGET)
                                            (eq! micro/INST MMIO_INST_LIMB_TO_RAM_ONE_TARGET)))
                       (eq! micro/SIZE (any-to-ram-some-data-last-dt-size))))
         (if-eq (force-bool (+ RZ_FIRST RZ_ONLY)) 1
                (begin (eq! micro/INST MMIO_INST_RAM_EXCISION)
                       (eq! micro/SIZE (any-to-ram-some-data-first-padding-size))
                       (did-inc! micro/TLO (any-to-ram-some-data-tlo-increment-at-transition))
                       (eq! micro/TBO (any-to-ram-some-data-first-pbo))))
         (if-eq (force-bool (+ RZ_FIRST RZ_MDDL)) 1
                (begin (will-inc! micro/TLO 1)
                       (vanishes! (next micro/TBO))))
         (if-eq RZ_MDDL 1 (eq! micro/INST MMIO_INST_RAM_VANISHES))
         (if-eq RZ_LAST 1
                (begin (eq! micro/INST MMIO_INST_RAM_EXCISION)
                       (eq! micro/SIZE (any-to-ram-some-data-last-padding-size))))))

;;
;; MODEXP ZERO
;;
(defconstraint modexp-zero-preprocessing (:guard (* MACRO IS_MODEXP_ZERO))
  (begin (vanishes! TOTLZ)
         (eq! TOTNT NB_MICRO_ROWS_TOT_MODEXP_ZERO)
         (vanishes! TOTRZ)
         (eq! (shift micro/EXO_SUM NB_PP_ROWS_MODEXP_ZERO_PO) EXO_SUM_WEIGHT_BLAKEMODEXP)
         (eq! (shift micro/PHASE NB_PP_ROWS_MODEXP_ZERO_PO) macro/PHASE)
         (eq! (shift micro/EXO_ID NB_PP_ROWS_MODEXP_ZERO_PO) macro/TGT_ID)))

(defconstraint modexp-zero-mmio-instruction-writting (:guard (* MICRO IS_MODEXP_ZERO))
  (begin (standard-progression micro/TLO)
         (eq! micro/INST MMIO_INST_LIMB_VANISHES)))

;;
;; MODEXP DATA
;;
(defun (modexp-initial-tbo) [OUT 1])
(defun (modexp-initial-slo) [OUT 2])
(defun (modexp-initial-sbo) [OUT 3])
(defun (modexp-first-limb-bytesize) [OUT 4])
(defun (modexp-last-limb-bytesize) [OUT 5])
(defun (modexp-first-limb-single-source) [BIN 1])
(defun (modexp-aligned) [BIN 2])
(defun (modexp-last-limb-single-source) [BIN 3])
(defun (modexp-src-id) macro/SRC_ID)
(defun (modexp-tgt-id) macro/TGT_ID)
(defun (modexp-src-offset) macro/SRC_OFFSET_LO)
(defun (modexp-size) macro/SIZE)
(defun (modexp-cdo) macro/REF_OFFSET)
(defun (modexp-cds) macro/REF_SIZE)
(defun (modexp-exo-sum) macro/EXO_SUM)
(defun (modexp-phase) macro/PHASE)
(defun (modexp-param-byte-size) (modexp-size))
(defun (modexp-param-offset) (+ (modexp-cdo) (modexp-src-offset)))
(defun (modexp-leftover-data-size) (- (modexp-cds) (modexp-src-offset)))
(defun (modexp-num-left-padding-bytes) (- 512 (modexp-param-byte-size)))
(defun (modexp-data-runs-out) (shift prprc/WCP_RES 2))
(defun (modexp-num-right-padding-bytes) (* (- (modexp-param-byte-size) (modexp-leftover-data-size)) (modexp-data-runs-out)))
(defun (modexp-right-padding-remainder) (shift prprc/EUC_REM 2))
(defun (modexp-totnt-is-one) (shift prprc/WCP_RES 3))
(defun (modexp-middle-sbo) (shift prprc/EUC_REM 6))

(defconstraint modexp-preprocessing (:guard (* MACRO IS_MODEXP_DATA))
  (begin  ;; Setting total number of mmio inst
         (eq! TOT NB_MICRO_ROWS_TOT_MODEXP_DATA)
         ;; preprocessing row n°1
         (callToEuc 1 (modexp-num-left-padding-bytes) LLARGE)
         (eq! (modexp-initial-tbo) (next prprc/EUC_REM))
         (eq! TOTLZ (next prprc/EUC_QUOT))
         ;; preprocessing row n°2
         (callToLt 2 0 (modexp-leftover-data-size) (modexp-param-byte-size))
         (callToEuc 2 (modexp-num-right-padding-bytes) LLARGE)
         (eq! TOTRZ (shift prprc/EUC_QUOT 2))
         (debug (eq! TOTNT
                     (- 32 (+ TOTLZ TOTRZ))))
         ;; preprocessing row n°3
         (callToEq 3 0 TOTNT 1)
         (callToEuc 3 (modexp-param-offset) LLARGE)
         (eq! (modexp-initial-slo) (shift prprc/EUC_QUOT 3))
         (eq! (modexp-initial-sbo) (shift prprc/EUC_REM 3))
         (if-zero (modexp-totnt-is-one)
                  (eq! (modexp-first-limb-bytesize) (- LLARGE (modexp-initial-tbo)))
                  (if-zero (modexp-data-runs-out)
                           (eq! (modexp-first-limb-bytesize) (modexp-param-byte-size))
                           (eq! (modexp-first-limb-bytesize) (modexp-leftover-data-size))))
         (if-zero (modexp-data-runs-out)
                  (eq! (modexp-last-limb-bytesize) LLARGE)
                  (eq! (modexp-last-limb-bytesize) (- LLARGE (modexp-right-padding-remainder))))
         ;; preprocessing row n°4
         (callToLt 4
                   0
                   (+ (modexp-initial-sbo) (- (modexp-first-limb-bytesize) 1))
                   LLARGE)
         (eq! (modexp-first-limb-single-source) (shift prprc/WCP_RES 4))
         ;; preprocessing row n°5
         (callToEq 5 0 (modexp-initial-sbo) (modexp-initial-tbo))
         (eq! (modexp-aligned) (shift prprc/WCP_RES 5))
         ;; preprocessing row n°6
         (if-eq-else (modexp-aligned) 1
                     (eq! (modexp-last-limb-single-source) (modexp-aligned))
                     (begin (callToEuc 6 (+ (modexp-initial-sbo) (modexp-first-limb-bytesize)) LLARGE)
                            (callToLt 6
                                      0
                                      (+ (modexp-middle-sbo) (- (modexp-last-limb-bytesize) 1))
                                      LLARGE)
                            (eq! (modexp-last-limb-single-source) (shift prprc/WCP_RES 6))))
         ;; setting mmio constant values
         (eq! (shift micro/CN_S NB_PP_ROWS_MODEXP_DATA_PO) (modexp-src-id))
         (eq! (shift micro/EXO_SUM NB_PP_ROWS_MODEXP_DATA_PO) EXO_SUM_WEIGHT_BLAKEMODEXP)
         (eq! (shift micro/PHASE NB_PP_ROWS_MODEXP_DATA_PO) (modexp-phase))
         (eq! (shift micro/EXO_ID NB_PP_ROWS_MODEXP_DATA_PO) (modexp-tgt-id))))

(defconstraint modexp-mmio-instruction-writting (:guard IS_MODEXP_DATA)
  (begin (if-eq MICRO 1 (standard-progression micro/TLO))
         (if-eq (zero-row) 1 (eq! micro/INST MMIO_INST_LIMB_VANISHES))
         (if-eq (force-bool (+ NT_ONLY NT_FIRST)) 1
                (begin (if-zero (modexp-first-limb-single-source)
                                (eq! micro/INST MMIO_INST_RAM_TO_LIMB_TWO_SOURCE)
                                (eq! micro/INST MMIO_INST_RAM_TO_LIMB_ONE_SOURCE))
                       (eq! micro/SIZE (modexp-first-limb-bytesize))
                       (eq! micro/SLO (modexp-initial-slo))
                       (eq! micro/SBO (modexp-initial-sbo))
                       (eq! micro/TBO (modexp-initial-tbo))))
         (if-eq NT_FIRST 1
                (begin (if-eq-else (modexp-aligned) 1
                                   (will-inc! micro/SLO 1)
                                   (if-zero (modexp-first-limb-single-source)
                                            (begin (will-inc! micro/SLO 1)
                                                   (will-eq! micro/SBO
                                                             (- (+ micro/SBO micro/SIZE) LLARGE)))
                                            (begin (will-remain-constant! micro/SLO)
                                                   (will-eq! micro/SBO (+ micro/SBO micro/SIZE)))))
                       (vanishes! (next micro/TBO))))
         (if-eq NT_MDDL 1
                (begin (if-zero (modexp-aligned)
                                (eq! micro/INST MMIO_INST_RAM_TO_LIMB_TWO_SOURCE)
                                (eq! micro/INST MMIO_INST_RAM_TO_LIMB_TRANSPLANT))
                       (eq! micro/SIZE LLARGE)
                       (will-inc! micro/SLO 1)
                       (will-remain-constant! micro/SBO)
                       (will-remain-constant! micro/TBO)))
         (if-eq NT_LAST 1
                (begin (if-zero (modexp-last-limb-single-source)
                                (eq! micro/INST MMIO_INST_RAM_TO_LIMB_TWO_SOURCE)
                                (eq! micro/INST MMIO_INST_RAM_TO_LIMB_ONE_SOURCE))
                       (eq! micro/SIZE (modexp-last-limb-bytesize))))))
