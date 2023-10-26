(module txnData)

(defconst 
  nROWS0                        6
  nROWS1                        7
  nROWS2                        7
  ;;
  G_transaction                 21000
  G_txcreate                    32000
  G_accesslistaddress           2400
  G_accessliststorage           1900
  ;;
  LT                            0x10
  common_rlp_txn_phase_number_0 0
  common_rlp_txn_phase_number_1 7
  common_rlp_txn_phase_number_2 2
  common_rlp_txn_phase_number_3 8
  common_rlp_txn_phase_number_4 9
  common_rlp_txn_phase_number_5 6
  type_0_rlp_txn_phase_number_6 3
  type_1_rlp_txn_phase_number_6 3
  type_1_rlp_txn_phase_number_7 10
  type_2_rlp_txn_phase_number_6 5
  type_2_rlp_txn_phase_number_7 10)

;; sum of transaction type flags
(defun (tx-type-sum)
  (+ TYPE0 TYPE1 TYPE2))

;; constraint imposing that STAMP[i + 1] ∈ { STAMP[i], 1 + STAMP[i] }
(defpurefun (stamp-progression STAMP)
  (vanishes! (any! (will-remain-constant! STAMP) (will-inc! STAMP 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.1 Heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint first-row (:domain {0})
  (vanishes! ABS))

(defconstraint padding ()
  (if-zero ABS
           (begin (vanishes! CT)
                  (vanishes! (tx-type-sum)))))

(defconstraint abs-tx-num-increments ()
  (stamp-progression ABS))

(defconstraint new-stamp-reboot-ct ()
  (if-not-zero (will-remain-constant! ABS)
               (vanishes! (next CT))))

(defconstraint heartbeat (:guard ABS)
  (begin (= (tx-type-sum) 1)
         (if-not-zero TYPE0
                      (if-eq-else CT nROWS0 (will-inc! ABS 1) (will-inc! CT 1)))
         (if-not-zero TYPE1
                      (if-eq-else CT nROWS1 (will-inc! ABS 1) (will-inc! CT 1)))
         (if-not-zero TYPE2
                      (if-eq-else CT nROWS2 (will-inc! ABS 1) (will-inc! CT 1)))))

(defconstraint final-row (:domain {-1})
  (begin (= ABS ABS_MAX)
         (= BTC BTC_MAX)
         (= REL REL_MAX)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    2.2 Constancies    ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (transaction-constant X)
  (if-not-zero CT
               (eq! X (prev X))))

(defconstraint constancies ()
  (begin (transaction-constant BTC)
         (transaction-constant REL)
         (transaction-constant FROM_HI)
         (transaction-constant FROM_LO)
         (transaction-constant NONCE)
         (transaction-constant IBAL)
         (transaction-constant VALUE)
         (transaction-constant TO_HI)
         (transaction-constant TO_LO)
         (transaction-constant is-dep)
         (transaction-constant GLIM)
         (transaction-constant IGAS)
         (transaction-constant GPRC)
         (transaction-constant BASEFEE)
         (transaction-constant CALL_data-size)
         (transaction-constant INIT_CODE_SIZE)
         (transaction-constant TYPE0)
         (transaction-constant TYPE1)
         (transaction-constant TYPE2)
         (transaction-constant REQ_EVM)
         (transaction-constant LEFTOVER_GAS)
         (transaction-constant REF_CNT)
         (transaction-constant REF_AMT)
         (transaction-constant CUM_GAS)
         (transaction-constant STATUS_CODE)
         (transaction-constant CFI)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    2.3 Binary constraints    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint binarities ()
  (begin (is-binary is-dep)
         (is-binary TYPE0)
         (is-binary TYPE1)
         (is-binary TYPE2)
         (is-binary REQUIRES_EVM_EXECUTION)
         (is-binary STATUS_CODE)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                ;;
;;    2.4 Batch numbers and transaction number    ;;
;;                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint total-number-constancies ()
  (begin (if-zero ABS
                  (begin (vanishes! ABS_MAX)
                         (vanishes! BTC_MAX)
                         (vanishes! REL_MAX))
                  (begin (will-remain-constant! ABS_MAX)
                         (will-remain-constant! BTC_MAX)))
         (if-not-zero (will-inc! BTC 1)
                      (will-remain-constant! REL_MAX))))

(defconstraint batch-num-increments ()
  (stamp-progression BTC))

(defconstraint batchNum-txNum-lexicographic ()
  (begin (if-zero ABS
                  (begin (vanishes! BTC)
                         (vanishes! REL)
                         (if-not-zero (will-remain-constant! ABS)
                                      (begin (eq! (next BTC) 1)
                                             (eq! (next REL) 1))))
                  (if-not-zero (will-remain-constant! ABS)
                               (if-not-zero (- REL_MAX REL)
                                            (begin (will-remain-constant! BTC)
                                                   (will-inc! REL 1))
                                            (begin (will-inc! BTC 1)
                                                   (= REL 1)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          ;;
;;    2.5 Cumulative gas    ;;
;;                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint cumulative-gas ()
  (begin (if-zero ABS
                  (vanishes! CUM_GAS))
         (if-not-zero (will-remain-constant! BTC)
                      ; BTC[i + 1] != BTC[i]
                      (eq! (next CUMULATIVE_CONSUMED_GAS)
                           (next (- data-limit REFUND_AMOUNT))))
         (if-not-zero (and (will-inc! BTC 1) (will-remain-constant! ABS))
                      ; BTC[i + 1] != 1 + BTC[i] && ABS[i+1] != ABS[i] i.e. BTC[i + 1] == BTC[i] && ABS[i+1] == ABS[i] +1
                      (eq! (next CUM_GAS)
                           (+ CUM_GAS
                              (next (- data-limit REFUND_AMOUNT)))))))

;;;;;;;;;;;;;;;;;;;;;;;
;;                   ;;
;;    2.6 Aliases    ;;
;;                   ;;
;;;;;;;;;;;;;;;;;;;;;;;
(defun (tx-type)
  (shift OUTGOING_LO 0))

(defun (optional-to-addr-hi)
  (shift OUTGOING_HI 1))

(defun (optional-to-addr-lo)
  (shift OUTGOING_LO 1))

(defun (nonce)
  (shift OUTGOING_LO 2))

(defun (is-dep)
  (shift OUTGOING_HI 3))

(defun (value)
  (shift OUTGOING_LO 3))

(defun (data-cost)
  (shift OUTGOING_HI 4))

(defun (data-size)
  (shift OUTGOING_LO 4))

(defun (data-limit)
  (shift OUTGOING_LO 5))

(defun (gas-price)
  (shift OUTGOING_LO 6))

(defun (max-priority-fee)
  (shift OUTGOING_HI 6))

(defun (max-fee)
  (shift OUTGOING_LO 6))

(defun (num-keys)
  (shift OUTGOING_HI 7))

(defun (num-addr)
  (shift OUTGOING_LO 7))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ;;
;;    2.8 Verticalization    ;;
;;                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (setting_phase_numbers)
  (begin (= (shift PHASE_RLP_TXN 0) common_rlp_txn_phase_number_0)
         (= (shift PHASE_RLP_TXN 1) common_rlp_txn_phase_number_1)
         (= (shift PHASE_RLP_TXN 2) common_rlp_txn_phase_number_2)
         (= (shift PHASE_RLP_TXN 3) common_rlp_txn_phase_number_3)
         (= (shift PHASE_RLP_TXN 4) common_rlp_txn_phase_number_4)
         (= (shift PHASE_RLP_TXN 5) common_rlp_txn_phase_number_5)
         ;;
         (if-not-zero TYPE0
                      (= (shift PHASE_RLP_TXN 6) type_0_rlp_txn_phase_number_6))
         ;;
         (if-not-zero TYPE1
                      (= (shift PHASE_RLP_TXN 6) type_1_rlp_txn_phase_number_6))
         (if-not-zero TYPE1
                      (= (shift PHASE_RLP_TXN 7) type_1_rlp_txn_phase_number_7))
         ;;
         (if-not-zero TYPE2
                      (= (shift PHASE_RLP_TXN 6) type_2_rlp_txn_phase_number_6))
         (if-not-zero TYPE2
                      (= (shift PHASE_RLP_TXN 7) type_2_rlp_txn_phase_number_7))))

(defun (data_transfer)
  (begin (= (tx-type) (+ TYPE1 TYPE2 TYPE2))
         (= (nonce) NONCE)
         (= (is-dep) is-dep)
         (= (value) VALUE)
         (= (optional-to-addr-hi)
            (* (- 1 is-dep) TO_HI))
         (= (optional-to-addr-lo)
            (* (- 1 is-dep) TO_LO))
         (if-zero is-dep
                  ;; is-dep == 0
                  (begin (= (data-size) CALL_data-size)
                         (vanishes! INIT_CODE_SIZE))
                  ;; is-dep != 0
                  (begin (vanishes! CALL_data-size)
                         (= (data-size) INIT_CODE_SIZE)
                         (= (data-limit) data-limit)))))

(defun (vanishing_data_cells)
  (begin (vanishes! (shift OUTGOING_HI 0))
         (vanishes! (shift OUTGOING_HI 2))
         (vanishes! (shift OUTGOING_HI 5))
         (if-zero TYPE2
                  (vanishes! (shift OUTGOING_HI 6)))))

(defconstraint verticalization (:guard (remained-constant! ABS))
  (begin (setting_phase_numbers)
         (data_transfer)
         (vanishing_data_cells)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    2.9 Comparisons    ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; row i
(defun (sufficient_balance)
  (begin (= WCP_ARG_ONE_LO IBAL)
         (= WCP_ARG_TWO_LO
            (+ (value) (* (max-fee) (data-limit))))
         (= WCP_INST LT)
         (vanishes! WCP_RES_LO)))

(defun (upfront_gas_cost_of_transaction)
  (if-not-zero TYPE0
               ;; TYPE0 = 1
               (+ (data-cost) G_transaction (* (is-dep) G_txcreate))
               ;; TYPE0 = 0
               (+ (data-cost)
                  G_transaction
                  (* (is-dep) G_txcreate)
                  (* (num-addr) G_accesslistaddress)
                  (* (num-keys) G_accessliststorage))))

;; row i + 1
(defun (sufficient_data-limit)
  (begin (= (shift WCP_ARG_ONE_LO 1) (data-limit))
         (= (shift WCP_ARG_TWO_LO 1) (upfront_gas_cost_of_transaction))
         (= (shift WCP_INST 1) LT)
         (vanishes! (shift WCP_RES_LO 1))))

;; epsilon is the remainder in the euclidean division of [T_g - g'] by 2
(defun (epsilon)
  (- (data-limit)
     (+ LEFTOVER_GAS
        (* (shift WCP_ARG_TWO_LO 2) 2))))

;; row i + 2
(defun (upper_limit_for_refunds)
  (begin (= (shift WCP_ARG_ONE_LO 2) (- (data-limit) LEFTOVER_GAS))
         ;;  (= (shift WCP_ARG_TWO_LO 2) ???) ;; unknown
         (= (shift WCP_INST 2) LT)
         (vanishes! (shift WCP_RES_LO 2))
         (is-binary (epsilon))))

;; row i + 3
(defun (effective_refund)
  (begin (= (shift WCP_ARG_ONE_LO 3) REF_CNT)
         (= (shift WCP_ARG_TWO_LO 3) (shift WCP_ARG_TWO_LO 2))
         (= (shift WCP_INST 3) LT)
         ;;  (= (shift WCP_RES_LO     3) ???) ;; unknown
         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; applicable only to type 2 transactions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; row i + 4
(defun (type_2_comparing_max-fee_and_basefee)
  (begin (= (shift WCP_ARG_ONE_LO 4) (max-fee))
         (= (shift WCP_ARG_TWO_LO 4) BASEFEE)
         (= (shift WCP_INST 4) LT)
         (= (shift WCP_RES_LO 4) 0)))

;; row i + 5
(defun (type_2_comparing_max-fee_and_max-priority-fee)
  (begin (= (shift WCP_ARG_ONE_LO 5) (max-fee))
         (= (shift WCP_ARG_TWO_LO 5) (max-priority-fee))
         (= (shift WCP_INST 5) LT)
         (= (shift WCP_RES_LO 5) 0)))

;; row i + 6
(defun (type_2_computing_the_effective_gas-price)
  (begin (= (shift WCP_ARG_ONE_LO 6) (max-fee))
         (= (shift WCP_ARG_TWO_LO 6) (+ (max-priority-fee) BASEFEE))
         (= (shift WCP_INST 6) LT)
         ;;  (= (shift WCP_RES_LO     6) ???) ;; unknown
         ))

(defconstraint comparisons (:guard (remained-constant! ABS))
  (begin (sufficient_balance)
         (sufficient_data-limit)
         (upper_limit_for_refunds)
         (effective_refund)
         (if-not-zero TYPE2
                      (begin (type_2_comparing_max-fee_and_basefee)
                             (type_2_comparing_max-fee_and_max-priority-fee)
                             (type_2_computing_the_effective_gas-price)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                          ;;
;;    2.11 Gas and gas price constraints    ;;
;;                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint gas_and_gas-price (:guard (remained-constant! ABS))
  (begin  ;; constraining INIT_GAS
         (= IGAS
            (- (data-limit) (shift WCP_ARG_TWO_LO 1)))
         ;; constraining REFUND_AMOUNT
         (if-zero (shift WCP_RES_LO 3)
                  (= REF_AMT
                     (+ LEFTOVER_GAS (shift WCP_ARG_TWO_LO 2)))
                  (= REF_AMT (+ LEFTOVER_GAS REF_CNT)))
         ;; constraining gas-price
         (if-zero TYPE2
                  (= gas-price (gas-price))
                  (if-zero (shift WCP_RES_LO 6)
                           (= gas-price (+ (max-priority-fee) BASEFEE))
                           (= gas-price (max-fee))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                           ;;
;;    2.11 Verticalisation for RlpTxnRcpt    ;;
;;                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint verticalisation-rlp-txn-rcpt (:guard (remained-constant! ABS))
  (begin (eq! PHASE_RLP_TXNRCPT RLPRECEIPT_SUBPHASE_ID_TYPE)
         (eq! OUTGOING_RLP_TXNRCPT (tx-type))
         (eq! (next PHASE_RLP_TXNRCPT) RLPRECEIPT_SUBPHASE_ID_STATUS_CODE)
         (eq! (next OUTGOING_RLP_TXNRCPT) STATUS_CODE)
         (eq! (shift PHASE_RLP_TXNRCPT 2) RLPRECEIPT_SUBPHASE_ID_CUMUL_GAS)
         (eq! (shift OUTGOING_RLP_TXNRCPT 2) CUMULATIVE_CONSUMED_GAS)))


