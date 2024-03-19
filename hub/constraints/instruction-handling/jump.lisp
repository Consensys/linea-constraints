(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                               ;;;;
;;;;    X.5 Instruction handling   ;;;;
;;;;                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;    X.5.27 Jump instructions   ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (jump-instruction-no-stack-exception)
  (* PEEK_AT_STACK
     stack/JUMP_FLAG
     (- 1 stack/SUX stack/SOX)))

(defun (jump-instruction-no-stack-exception-and-no-oogx)
  (* (jump-instruction-no-stack-exception)
     (- 1 stack/OOGX)))

(defconst
  jump-context-row-offset           1
  jump-account-row-offset           2
  jump-misc-row-offset              3
  jump-context-row-offset-exception 4)

(defun (jump-instruction-new-pc-hi)                         [ stack/STACK_ITEM_VALUE_HI 1 ])
(defun (jump-instruction-new-pc-lo)                         [ stack/STACK_ITEM_VALUE_LO 1 ])
(defun (jump-instruction-jump-condition-hi)                 [ stack/STACK_ITEM_VALUE_HI 2 ])
(defun (jump-instruction-jump-condition-lo)                 [ stack/STACK_ITEM_VALUE_LO 2 ])
(defun (jump-instruction-is-jump)                           [ stack/DEC_FLAG 1 ])
(defun (jump-instruction-is-jumpi)                          [ stack/DEC_FLAG 2 ])
;;
(defun (jump-instruction-code-address-hi)                   (shift  context/BYTE_CODE_ADDRESS_HI  jump-context-row-offset))
(defun (jump-instruction-code-address-lo)                   (shift  context/BYTE_CODE_ADDRESS_LO  jump-context-row-offset))
;;
(defun (jump-instruction-code-size)                         (shift  account/CODE_SIZE             jump-account-row-offset))
;;
(defun (jump-instruction-JUMP-guaranteed-exception)         (shift  [ misc/OOB_DATA 7 ]           jump-misc-row-offset))
(defun (jump-instruction-JUMP-must-be-attempted)            (shift  [ misc/OOB_DATA 8 ]           jump-misc-row-offset))
;;
(defun (jump-instruction-JUMPI-jump-not-attempted)          (shift  [ misc/OOB_DATA 6 ]           jump-misc-row-offset))
(defun (jump-instruction-JUMPI-guaranteed-exception)        (shift  [ misc/OOB_DATA 7 ]           jump-misc-row-offset))
(defun (jump-instruction-JUMPI-must-be-attempted)           (shift  [ misc/OOB_DATA 8 ]           jump-misc-row-offset))

(defconstraint jump-instruction-setting-the-stack-pattern                   (:guard (jump-instruction-no-stack-exception))
               (begin
                 (if-not-zero (jump-instruction-is-jump)   (stack-pattern-1-0))
                 (if-not-zero (jump-instruction-is-jumpi)  (stack-pattern-2-0))))

(defconstraint jump-instruction-setting-the-gas-cost                        (:guard (jump-instruction-no-stack-exception))
               (eq! GAS_COST stack/STATIC_GAS))

(defconstraint jump-instruction-setting-NSR                                 (:guard (jump-instruction-no-stack-exception))
               (if-not-zero (force-bin stack/OOGX)
                            ;; OOGX = 1
                            (begin (eq! NSR CMC)
                                   (debug (eq! NSR 1)))
                            ;; OOGX = 0
                            (eq! NSR (+ 3 CMC))))

(defconstraint jump-instruction-setting-peeking-flags                       (:guard (jump-instruction-no-stack-exception))
               (if-not-zero (force-bin stack/OOGX)
                            ;; OOGX = 1
                            (eq! NSR (shift PEEK_AT_CONTEXT  jump-context-row-offset)) ;; TODO: redundant, make debug
                            ;; OOGX = 0
                            (eq! NSR (+ (shift PEEK_AT_CONTEXT             jump-context-row-offset)
                                        (shift PEEK_AT_ACCOUNT             jump-account-row-offset)
                                        (shift PEEK_AT_MISCELLANEOUS       jump-misc-row-offset)
                                        (* CMC (shift PEEK_AT_CONTEXT      jump-context-row-offset-exception))))))

(defconstraint jump-instruction-setting-the-first-context-row               (:guard (jump-instruction-no-stack-exception))
               (if-not-zero (force-bin stack/OOGX)
                            ;; OOGX = 1
                            (execution-provides-empty-return-data          jump-context-row-offset)
                            ;; OOGX = 0
                            (begin
                              (read-context-data                           jump-context-row-offset
                                                                           CONTEXT_NUMBER)
                              ;; sanity check
                              (debug (eq! (shift context/CALLER_CONTEXT_NUMBER jump-context-row-offset)
                                          CALLER_CONTEXT_NUMBER)))))


;; stronger preconditions start here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint jump-instruction-the-account-row                            (:guard (jump-instruction-no-stack-exception-and-no-oogx))
               (begin
                 (eq! (shift account/ADDRESS_HI  jump-account-row-offset)  (jump-instruction-code-address-hi))
                 (eq! (shift account/ADDRESS_LO  jump-account-row-offset)  (jump-instruction-code-address-lo))
                 (account-same-balance                           jump-account-row-offset)
                 (account-same-nonce                             jump-account-row-offset)
                 (account-same-code                              jump-account-row-offset)
                 (account-same-deployment-number-and-status      jump-account-row-offset)
                 (account-same-warmth                            jump-account-row-offset)
                 (account-same-marked-for-selfdestruct           jump-account-row-offset)
                 (standard-dom-sub-stamps                        jump-account-row-offset
                                                                 0)))

(defconstraint jump-instruction-the-miscellaneous-row-flags                 (:guard (jump-instruction-no-stack-exception-and-no-oogx))
               (eq! (weighted-MISC-flag-sum   jump-misc-row-offset)    MISC_WEIGHT_OOB))

(defconstraint jump-instruction-the-miscellaneous-row-OOB-instruction       (:guard (jump-instruction-no-stack-exception-and-no-oogx))
               (begin
                 (if-not-zero (jump-instruction-is-jump)
                              (set-oob-inst-jump    jump-misc-row-offset
                                                    (jump-instruction-new-pc-hi)
                                                    (jump-instruction-new-pc-lo)
                                                    (jump-instruction-code-size)))
                 (if-not-zero (jump-instruction-is-jumpi)
                              (set-oob-inst-jumpi   jump-misc-row-offset
                                                    (jump-instruction-new-pc-hi)
                                                    (jump-instruction-new-pc-lo)
                                                    (jump-instruction-jump-condition-hi)
                                                    (jump-instruction-jump-condition-lo)
                                                    (jump-instruction-code-size)))))


(defconstraint jump-instruction-setting-PC_NEW-and-JUMP_DESTINATION_VETTING-for-JUMP (:guard (jump-instruction-no-stack-exception-and-no-oogx))
               (if-not-zero (jump-instruction-is-jump)
                            (begin
                              (if-not-zero (jump-instruction-JUMP-guaranteed-exception)
                                           (begin (eq! stack/JUMP_DESTINATION_VETTING_REQUIRED 0)
                                                  (eq! stack/JUMPX 1)))
                              (if-not-zero (jump-instruction-JUMP-must-be-attempted)
                                           (begin (eq! stack/JUMP_DESTINATION_VETTING_REQUIRED 1)
                                                  (if-zero XAHOY (eq! PC_NEW (jump-instruction-new-pc-lo))))))))


(defconstraint jump-instruction-setting-PC_NEW-and-JUMP_DESTINATION_VETTING-for-JUMPI (:guard (jump-instruction-no-stack-exception-and-no-oogx))
               (if-not-zero (jump-instruction-is-jumpi)
                            (begin
                              (if-not-zero (jump-instruction-JUMPI-jump-not-attempted)
                                           (begin (eq! stack/JUMP_DESTINATION_VETTING_REQUIRED 0)
                                                  (eq! stack/JUMPX 0)
                                                  (eq! PC_NEW (+ 1 PC))))
                              (if-not-zero (jump-instruction-JUMPI-guaranteed-exception)
                                           (begin (eq! stack/JUMP_DESTINATION_VETTING_REQUIRED 0)
                                                  (eq! stack/JUMPX 1)))
                              (if-not-zero (jump-instruction-JUMPI-must-be-attempted)
                                           (begin (eq! stack/JUMP_DESTINATION_VETTING_REQUIRED 1)
                                                  (eq! PC_NEW (jump-instruction-new-pc-lo)))))))
