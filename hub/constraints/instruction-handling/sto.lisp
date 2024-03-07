(module hub)

;; (defun (storage-no-stack-exceptions)
;;   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   (* PEEK_AT_STACK
;;      stack/STO_FLAG
;;      (- 1 stack/SUX stack/SOX)))
;;
;; (defconstraint storage-stack-pattern (:guard (storage-no-stack-exceptions))
;;                (load-store-stack-pattern [ stack/DEC_FLAG 1 ]))
;;
;; ;; TODO: comment out
;; (defconstraint storage-valid-exceptions (:guard (storage-no-stack-exceptions))
;;                (if-zero (force-bin [ stack/DEC_FLAG 1 ])
;;                         (eq! XAHOY
;;                              stack/OOGX)
;;                         (eq! XAHOY
;;                              (+ stack/STATICX
;;                                 stack/SSTOREX
;;                                 stack/OOGX))))
;;
;; (defconstraint storage-setting-NSR-and-peeking-flags-STATICX (:guard (storage-no-stack-exceptions))
;;                  ;; static exception
;;                  ;;;;;;;;;;;;;;;;;;;
;;                  (if-not-zero stack/STATICX
;;                               (begin
;;                                 (eq! NSR 2)
;;                                 (eq! NSR
;;                                      (+ (shift PEEK_AT_CONTEXT 1)
;;                                         (shift PEEK_AT_CONTEXT 2))))))
;;
;; (defconstraint storage-setting-NSR-and-peeking-flags-SSTOREX (:guard (storage-no-stack-exceptions))
;;                  ;; sstore gas exception
;;                  ;;;;;;;;;;;;;;;;;;;;;;;
;;                  (if-not-zero stack/SSTOREX
;;                               (begin
;;                                 (eq! NSR 3)
;;                                 (eq! NSR
;;                                      (+ (shift PEEK_AT_CONTEXT 1)
;;                                         (shift PEEK_AT_MISC    2)
;;                                         (shift PEEK_AT_CONTEXT 3))))))
;;
;; (defconstraint storage-setting-NSR-and-peeking-flags-OOGX (:guard (storage-no-stack-exceptions))
;;                  ;; out of gas exception
;;                  ;;;;;;;;;;;;;;;;;;;;;;;
;;                  (if-not-zero stack/SSTOREX
;;                               (begin
;;                                 (eq! NSR 5)
;;                                 (eq! NSR
;;                                      (+ (shift PEEK_AT_CONTEXT 1)
;;                                         (shift PEEK_AT_MISC    2)
;;                                         (shift PEEK_AT_STORAGE 3)
;;                                         (shift PEEK_AT_STORAGE 4)
;;                                         (shift PEEK_AT_CONTEXT 5))))))
;;
;; (defconstraint storage-setting-NSR-and-peeking-flags-UNEXCEPTIONAL (:guard (storage-no-stack-exceptions))
;;                  ;; unexceptional
;;                  ;;;;;;;;;;;;;;;;
;;                  (if-zero XAHOY
;;                           (begin
;;                             (eq! NSR (+ 3 CONTEXT_WILL_REVERT))
;;                             (eq! NSR
;;                                  (+ (shift PEEK_AT_CONTEXT 1)
;;                                     (shift PEEK_AT_MISC    2)
;;                                     (shift PEEK_AT_STORAGE 3)
;;                                     (* CONTEXT_WILL_REVERT (shift PEEK_AT_STORAGE 4)))))))
;;
;; (defconstraint storage-first-context-row (:guard (storage-no-stack-exceptions))
;;                (read-context-data
;;                  1                  ;; row offset
;;                  CONTEXT_NUMBER     ;; context to read
;;                  ))
;;
;; (defconstraint storage-justifying-STATICX (:guard (storage-no-stack-exceptions))
;;                (eq! stack/STATICX
;;                     (* [ stack/DEC_FLAG 1 ]
;;                        (shift context/IS_STATIC 1))))
;;
;; (defconstraint storage-setting-MISC-row (:guard (storage-no-stack-exceptions))
;;                (if-not-zero (shift PEEK_AT_MISK 2)
;;                             (begin
;;                               (eq! (weighted-MISC-flag-sum 2)
;;                                    (* [ stack/DEC_FLAG 1 ] MISC_OOB_WEIGHT))
;;                               (set-oob-inst-sstore 2                   ;; offset
;;                                                    GAS_ACTUAL ))))     ;; GAS_ACTUAL
;;
;; (defconstraint storage-justifying-SSTOREX (:guard (storage-no-stack-exceptions))
;;                (if-not-zero [ stack/DEC_FLAG 1 ]
;;                             (eq! stack/SSTOREX
;;                                  (shift [ misc/OOB_DATA 7 ] 2))))
;;
;; (defconstraint storage-justifying-SSTOREX (:guard (storage-no-stack-exceptions))
;;                (if-not-zero (shift PEEK_AT_MISK 2)
;;                             (if-not-zero [ stack/DEC_FLAG 1 ]
;;                                          (eq! stack/SSTOREX
;;                                               (shift [ misc/OOB_DATA 7 ] 2)
;;
;; (defun (oogx-or-no-exception) (+ stack/OOGX (- 1 XAHOY)))
;;
;; (defconstraint storage-setting-storage-slot-parameters (:guard (storage-no-stack-exceptions))
;;                (if-not-zero (oogx-or-no-exception)
;;                             (begin
;;                               (eq! (shift storage/ADDRESS_HI        3) (shift context/ACCOUNT_ADDRESS_HI        1))
;;                               (eq! (shift storage/ADDRESS_LO        3) (shift context/ACCOUNT_ADDRESS_LO        1))
;;                               (eq! (shift storage/DEPLOYMENT_NUMBER 3) (shift context/ACCOUNT_DEPLOYMENT_NUMBER 1))
;;                               (eq! (shift storage/KEY_HI            3) [ stack/STACK_ITEM_VALUE_HI  1 ])
;;                               (eq! (shift storage/KEY_LO            3) [ stack/STACK_ITEM_VALUE_LO  1 ])
;;                               (turn-on-storage-warmth               3)
;;                               (standard-dom-sub-stamps              3        ;; kappa
;;                                                                     0))))    ;; c
;;
;; (defconstraint storage-setting-storage-slot-parameters (:guard (storage-no-stack-exceptions))
;;                (if-not-zero (oogx-or-no-exception)
;;                             (begin
;;                               (if-zero (force-bin [ stack/DEC_FLAG 1 ])
;;                                        (begin
;;                                          (storage-reading 3)
;;                                          (eq! [ stack/STACK_ITEM_VALUE_HI 4 ] (shift storage/VALUE_CURR_HI 3))
;;                                          (eq! [ stack/STACK_ITEM_VALUE_LO 4 ] (shift storage/VALUE_CURR_LO 3)))
;;                                        (begin
;;                                          (eq! [ stack/STACK_ITEM_VALUE_HI 4 ] (shift storage/VALUE_NEXT_HI 3))
;;                                          (eq! [ stack/STACK_ITEM_VALUE_LO 4 ] (shift storage/VALUE_NEXT_LO 3))))
;;                               (if-not-zero CONTEXT_WILL_REVERT
;;                                            (begin
;;                                              (same-storage-slot                    4)
;;                                              (undo-storage-warmth-and-value-update 4)
;;                                              (revert-dom-sub-stamp                 4         ;; kappa
;;                                                                                    0))))))   ;; c

(defun (orig-is-zero) (shift storage/VALUE_ORIG_IS_ZERO 3))
(defun (curr-is-zero) (shift storage/VALUE_CURR_IS_ZERO 3))
(defun (next-is-zero) (shift storage/VALUE_NEXT_IS_ZERO 3))
(defun (curr-is-orig) (shift storage/VALUE_CURR_IS_ORIG 3))
(defun (next-is-orig) (shift storage/VALUE_NEXT_IS_ORIG 3))
(defun (next-is-curr) (shift storage/VALUE_NEXT_IS_CURR 3))


(defconstraint storage-setting-gas-costs (:guard (storage-no-stack-exceptions))
               (if-not-zero (oogx-or-no-exception)
                            (if-zero (force-bin [ stack/DEC_FLAG 1 ])
                                     (if-zero (force-bin (shift storage/WARMTH 3))
                                              (eq! GAS_COST GAS_CONST_G_COLD_SLOAD)
                                              (eq! GAS_COST GAS_CONST_G_WARM_ACCESS)

(defconstraint storage-setting-stack-values (:guard (storage-no-stack-exceptions))
               (if-not-zero [ stack/DEC_FLAG 1 ]
                            (begin
                              (eq! [ stack/STACK_ITEM_VALUE_HI 4 ] stack/PUSH_VALUE_HI )
                              (eq! [ stack/STACK_ITEM_VALUE_LO 4 ] stack/PUSH_VALUE_LO ))))
