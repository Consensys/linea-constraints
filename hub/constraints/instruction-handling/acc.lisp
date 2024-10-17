(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                               ;;;;
;;;;    X.5 Instruction handling   ;;;;
;;;;                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            ;;
;;    X.5 Instructions raising the ACC_FLAG   ;;
;;                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                             ;;
;;    X.5.1 Supported instructions and flags   ;;
;;    X.5.2 Shorthands                         ;;
;;                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconst
  ROW_OFFSET___ACC_FAMILY___CONTEXT_ROW            1
  ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW    2

  ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW      1
  ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW    2
  )


(defun (account-instruction---is-BALANCE)               [ stack/DEC_FLAG 1 ] )
(defun (account-instruction---is-EXTCODESIZE)           [ stack/DEC_FLAG 2 ] )
(defun (account-instruction---is-EXTCODEHASH)           [ stack/DEC_FLAG 3 ] )
(defun (account-instruction---is-CODESIZE)              [ stack/DEC_FLAG 4 ] )
(defun (account-instruction---raw-address-hi)           [ stack/STACK_ITEM_VALUE_HI 1 ])
(defun (account-instruction---raw-address-lo)           [ stack/STACK_ITEM_VALUE_LO 1 ])
(defun (account-instruction---result-hi)                [ stack/STACK_ITEM_VALUE_HI 4 ])
(defun (account-instruction---result-lo)                [ stack/STACK_ITEM_VALUE_LO 4 ]) ;; ""

(defun (account-instruction---is-SELFBALANCE)           (-    1
                                                              (account-instruction---is-BALANCE)
                                                              (account-instruction---is-EXTCODESIZE)
                                                              (account-instruction---is-EXTCODEHASH)
                                                              (account-instruction---is-CODESIZE)))

(defun (account-instruction---touches-foreign-account)  (+ (account-instruction---is-BALANCE)
                                                           (account-instruction---is-EXTCODESIZE)
                                                           (account-instruction---is-EXTCODEHASH)))
(defun (account-instruction---touches-current-account)  (+ (account-instruction---is-CODESIZE)
                                                           (account-instruction---is-SELFBALANCE)))

(defun (account-instruction---no-trimming)              (- stack/ACC_FLAG (account-instruction---touches-foreign-account)))
(defun (account-instruction---account-address-hi)       (shift   context/ACCOUNT_ADDRESS_HI     ROW_OFFSET___ACC_FAMILY___CONTEXT_ROW))
(defun (account-instruction---account-address-lo)       (shift   context/ACCOUNT_ADDRESS_LO     ROW_OFFSET___ACC_FAMILY___CONTEXT_ROW))
(defun (account-instruction---byte-code-address-hi)     (shift   context/BYTE_CODE_ADDRESS_HI   ROW_OFFSET___ACC_FAMILY___CONTEXT_ROW))
(defun (account-instruction---byte-code-address-lo)     (shift   context/BYTE_CODE_ADDRESS_LO   ROW_OFFSET___ACC_FAMILY___CONTEXT_ROW))
(defun (account-instruction---foreign-address-warmth)   (shift   account/WARMTH                 ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;    X.5.3 Constraints   ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun (account-instruction---standard-hypothesis) (* PEEK_AT_STACK
                                                      stack/ACC_FLAG
                                                      (- 1 stack/SUX stack/SOX)))

(defun (account-instruction---unexceptional) (* (account-instruction---standard-hypothesis)
                                                (- 1 XAHOY)))

(defconstraint   account-instruction---setting-the-stack-pattern
                 (:guard (account-instruction---standard-hypothesis))
                 ;;
                 (begin
                   (if-not-zero (account-instruction---touches-foreign-account) (stack-pattern-1-1))
                   (if-not-zero (account-instruction---no-trimming)             (stack-pattern-0-1))))

(defconstraint   account-instruction---setting-allowable-exceptions
                 (:guard (account-instruction---standard-hypothesis))
                 ;;
                 (eq! XAHOY stack/OOGX))

(defconstraint   account-instruction---setting-NSR
                 (:guard (account-instruction---standard-hypothesis))
                 ;;
                 (begin
                   (if-not-zero    (account-instruction---touches-foreign-account)    (eq! NSR (+ 1 CONTEXT_WILL_REVERT CMC)))
                   (if-not-zero    (account-instruction---no-trimming)                (eq! NSR (+ 1 (- 1 CMC))))
                   (debug          (eq! XAHOY CMC))
                   (debug          (eq! XAHOY stack/OOGX))))

(defconstraint   account-instruction---setting-peeking-flags
                 (:guard (account-instruction---standard-hypothesis))
                 ;;
                 (begin
                   (if-not-zero (account-instruction---touches-foreign-account)
                                (if-zero CONTEXT_WILL_REVERT
                                         (eq! NSR
                                              (+        (shift PEEK_AT_ACCOUNT        ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                                        (* CMC (shift PEEK_AT_CONTEXT 2))))
                                         (eq! NSR
                                              (+        (shift PEEK_AT_ACCOUNT        ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                                        (shift PEEK_AT_ACCOUNT        ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW)
                                                        (* CMC (shift PEEK_AT_CONTEXT 3))))))
                   (if-not-zero (account-instruction---no-trimming)
                                (if-zero XAHOY
                                         (eq! NSR
                                              (+ (shift    PEEK_AT_CONTEXT    ROW_OFFSET___ACC_FAMILY___CONTEXT_ROW)
                                                 (shift    PEEK_AT_ACCOUNT    ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW)))
                                         (eq! NSR
                                              (shift PEEK_AT_CONTEXT    1))))))

(defconstraint   account-instruction---setting-gas-cost
                 (:guard (account-instruction---standard-hypothesis))
                 ;;
                 (begin
                   (if-not-zero (account-instruction---touches-foreign-account)
                                (eq! GAS_COST
                                     (+ (*      (account-instruction---foreign-address-warmth)  GAS_CONST_G_WARM_ACCESS)
                                        (* (- 1 (account-instruction---foreign-address-warmth)) GAS_CONST_G_COLD_ACCOUNT_ACCESS))))
                   (if-not-zero (account-instruction---no-trimming)
                                (eq! GAS_COST
                                     stack/STATIC_GAS))))

(defconstraint   account-instruction---trimming-case-garnishing-non-stack-row-make-account-row
                 (:guard (account-instruction---standard-hypothesis))
                 ;;
                 (begin
                   (if-not-zero (account-instruction---touches-foreign-account)
                                (begin
                                  (eq! account/ROMLEX_FLAG            1)
                                  (eq! account/TRM_RAW_ADDRESS_HI    (account-instruction---raw-address-hi))
                                  (eq! account/ADDRESS_LO            (account-instruction---raw-address-lo))
                                  (account-same-balance                         ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                  (account-same-nonce                           ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                  (account-same-code                            ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                  (account-same-deployment-number-and-status    ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                  (account-turn-on-warmth                       ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                  (account-same-marked-for-selfdestruct         ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                  (DOM-SUB-stamps---standard                    ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW 0)))))


(defconstraint   account-instruction---trimming-case-garnishing-non-stack-row-undo-account-row
                 (:guard (account-instruction---standard-hypothesis))
                 ;;
                 (begin
                   (if-not-zero (account-instruction---touches-foreign-account)
                                (if-not-zero CONTEXT_WILL_REVERT
                                             (begin
                                               (account-same-address-as                  ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW    ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                               (account-undo-balance-update              ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW    ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                               (account-undo-nonce-update                ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW    ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                               (account-undo-code-update                 ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW    ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                               (account-undo-deployment-status-update    ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW    ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                               (account-undo-warmth-update               ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW    ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW)
                                               (account-same-marked-for-selfdestruct     ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW)
                                               (DOM-SUB-stamps---revert-with-current     ROW_OFFSET___ACC_FAMILY___ACCOUNT_UNDOING_ROW    1))))))

(defconstraint   account-instruction---non-trim-case
                 (:guard (account-instruction---standard-hypothesis))
                 ;;
                 (begin
                   (if-not-zero (account-instruction---no-trimming)
                                (if-zero XAHOY
                                         (begin
                                           (read-context-data                            1 CONTEXT_NUMBER)
                                           (account-same-balance                         ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW)
                                           (account-same-nonce                           ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW)
                                           (account-same-code                            ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW)
                                           (account-same-deployment-number-and-status    ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW)
                                           (account-turn-on-warmth                       ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW)
                                           (account-same-marked-for-selfdestruct         ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW)
                                           (DOM-SUB-stamps---standard                    ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW    0)
                                           (if-zero (account-instruction---is-CODESIZE)
                                                    ;; DEC_FLAG_4 = 0
                                                    (begin
                                                      (eq!  (shift account/ADDRESS_HI    ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW) (account-instruction---account-address-hi))
                                                      (eq!  (shift account/ADDRESS_LO    ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW) (account-instruction---account-address-lo)))
                                                    ;; DEC_FLAG_4 = 1
                                                    (begin
                                                      (eq!  (shift account/ADDRESS_HI    ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW)  (account-instruction---byte-code-address-hi))
                                                      (eq!  (shift account/ADDRESS_LO    ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW)  (account-instruction---byte-code-address-lo)))))))))


(defun    (account-instruction---foreign-balance)         (shift     account/BALANCE                          ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW  ))
(defun    (account-instruction---foreign-code-size)       (shift  (* account/CODE_SIZE    account/HAS_CODE)   ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW  ))
(defun    (account-instruction---foreign-code-hash-hi)    (shift  (* account/CODE_HASH_HI account/EXISTS)     ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW  ))
(defun    (account-instruction---foreign-code-hash-lo)    (shift  (* account/CODE_HASH_LO account/EXISTS)     ROW_OFFSET___ACC_FAMILY___ACCOUNT_DOING_ROW  ))
(defun    (account-instruction---current-code-size)       (shift     account/CODE_SIZE                        ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW))
(defun    (account-instruction---current-balance)         (shift     account/BALANCE                          ROW_OFFSET___ACC_FAMILY___ACCOUNT_READING_ROW))


(defconstraint   account-instruction---value-constraints---the-BALANCE-case
                 (:guard (account-instruction---unexceptional))
                 ;;
                 (if-not-zero (account-instruction---is-BALANCE)
                              (begin
                                (eq!  (account-instruction---result-hi)    0)
                                (eq!  (account-instruction---result-lo)    (account-instruction---foreign-balance)))))

(defconstraint   account-instruction---value-constraints---the-EXTCODESIZE-case
                 (:guard (account-instruction---unexceptional))
                 ;;
                 (if-not-zero (account-instruction---is-EXTCODESIZE)
                              (begin
                                (eq!   (account-instruction---result-hi)   0)
                                (eq!   (account-instruction---result-lo)   (account-instruction---foreign-code-size)))))

(defconstraint   account-instruction---value-constraints---the-EXTCODEHASH-case
                 (:guard (account-instruction---unexceptional))
                 ;;
                 (if-not-zero (account-instruction---is-EXTCODEHASH)
                              (begin
                                (eq!   (account-instruction---result-hi)   (account-instruction---foreign-code-hash-hi))
                                (eq!   (account-instruction---result-lo)   (account-instruction---foreign-code-hash-lo)))))

(defconstraint   account-instruction---value-constraints---the-CODESIZE-case
                 (:guard (account-instruction---unexceptional))
                 ;;
                 (if-not-zero (account-instruction---is-CODESIZE)
                              (begin
                                (eq!   (account-instruction---result-hi)   0)
                                (eq!   (account-instruction---result-lo)   (account-instruction---current-code-size)))))

(defconstraint   account-instruction---value-constraints---the-SELFBALANCE-case
                 (:guard (account-instruction---unexceptional))
                 ;;
                 (if-not-zero (account-instruction---is-SELFBALANCE)
                              (begin
                                (eq!   (account-instruction---result-hi)   0)
                                (eq!   (account-instruction---result-lo)   (account-instruction---current-balance)))))
