(module logInfo)

(defconst 
  LOG0 0xa0
  LOG1 0xa1
  LOG2 0xa2
  LOG3 0xa3
  LOG4 0xa4)

(defun (if-not-eq A B then)
  (if-not-zero (- A B)
               then))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.1 Heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint first-row (:domain {0})
  (vanishes! ABS_TXN_NUM))

(defconstraint automatic-vanishing ()
  (if-zero ABS_TXN_NUM
           (begin (vanishes! ABS_TXN_NUM_MAX)
                  (vanishes! TXN_EMITS_LOGS)
                  (vanishes! ABS_LOG_NUM_MAX)
                  (vanishes! ABS_LOG_NUM)
                  (vanishes! CT_MAX)
                  (vanishes! CT))))

(defconstraint number-increments ()
  (begin (vanishes! (* (will-remain-constant! ABS_TXN_NUM) (will-inc! ABS_TXN_NUM 1)))
         (vanishes! (* (will-remain-constant! ABS_LOG_NUM) (will-inc! ABS_LOG_NUM 1)))))

(defconstraint no-logs-transaction (:guard ABS_TXN_NUM)
  (if-zero TXN_EMITS_LOGS
           (begin (remained-constant! ABS_LOG_NUM)
                  (did-inc! ABS_TXN_NUM 1)
                  (vanishes! CT_MAX)
                  (vanishes! INST))))

(defconstraint logging-transaction (:guard TXN_EMITS_LOGS)
  (begin (if-zero CT
                  (begin (did-inc! ABS_LOG_NUM 1)
                         (eq! CT_MAX
                              (+ 1 (- INST LOG0)))))
         (if-eq-else CT CT_MAX
                     ;; CT == CT_MAX
                     (begin (vanishes! (* (will-remain-constant! ABS_TXN_NUM)
                                          (will-remain-constant! ABS_LOG_NUM)))
                            (will-eq! ABS_LOG_NUM
                                      (+ ABS_LOG_NUM (next TXN_EMITS_LOGS))))
                     ;; CT != CT_MAX
                     (will-inc! CT 1))))

(defconstraint final-row (:domain {-1} :guard ABS_TXN_NUM)
  (begin (eq! ABS_TXN_NUM ABS_TXN_NUM_MAX)
         (eq! ABS_LOG_NUM ABS_LOG_NUM_MAX)
         (eq! CT CT_MAX)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    2.2 Constancies    ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint counter-constancies ()
  (begin (counter-constancy CT ABS_TXN_NUM)
         (counter-constancy CT ABS_LOG_NUM)
         (counter-constancy CT INST)
         (debug (counter-constancy CT CT_MAX))
         (counter-constancy CT ADDR_HI)
         (counter-constancy CT ADDR_LO)
         (for k [1 : 4] (counter-constancy CT [TOPIC_HI k]))
         (for k [1 : 4] (counter-constancy CT [TOPIC_LO k]))
         (counter-constancy CT DATA_SIZE)))

(defun (transaction-constancy X)
  (if-not-eq (next ABS_TXN_NUM) (+ 1 ABS_TXN_NUM) (will-remain-constant! X)))

(defconstraint transaction-constancies ()
  (begin (transaction-constancy TXN_EMITS_LOGS)))

(defconstraint batch-constancies (:guard ABS_TXN_NUM)
  (begin (will-remain-constant! ABS_TXN_NUM_MAX)
         (will-remain-constant! ABS_LOG_NUM_MAX)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    2.3 Binary constraints    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint binary-constraints ()
  (begin (for k [0 : 4] (is-binary [IS_LOG_X k]))
         (is-binary TXN_EMITS_LOGS)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                             ;;
;;    2.3 Instruction and instruction flags    ;;
;;                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint inst-and-flags ()
  (begin  ;; (eq! INST (reduce + (for k [0 : 4] (* [IS_LOG_X k] [LOG_k_INST k]))))
         (eq! INST
              (+ (* LOG0 [IS_LOG_X 0]) (* LOG1 [IS_LOG_X 1]) (* LOG2 [IS_LOG_X 2]) (* LOG3 [IS_LOG_X 3]) (* LOG4 [IS_LOG_X 4])))
         (eq! TXN_EMITS_LOGS
              (reduce + (for k [0 : 4] [IS_LOG_X k])))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ;;
;;    2.6 Verticalization    ;;
;;                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint verticalization-row-1-and-2 (:guard (reduce + (for k [0 : 4] [IS_LOG_X k])))
  (if-zero CT
           (begin (eq! PHASE RLPRECEIPT_SUBPHASE_ID_DATA_SIZE)
                  (eq! DATA_HI DATA_SIZE)
                  (eq! DATA_LO (- INST LOG0))
                  ;;
                  (eq! (shift PHASE 1) RLPRECEIPT_SUBPHASE_ID_ADDR)
                  (eq! (shift DATA_HI 1) ADDR_HI)
                  (eq! (shift DATA_LO 1) ADDR_LO))))

(defconstraint verticalization-row-3 (:guard (reduce + (for k [1 : 4] [IS_LOG_X k])))
  (if-zero CT
           (begin (eq! (shift PHASE 2)
                       (+ RLPRECEIPT_SUBPHASE_ID_TOPIC_BASE RLPRECEIPT_SUBPHASE_ID_TOPIC_DELTA))
                  (eq! (shift DATA_HI 2) [TOPIC_HI 1])
                  (eq! (shift DATA_LO 2) [TOPIC_LO 1]))))

(defconstraint verticalization-row-4 (:guard (reduce + (for k [2 : 4] [IS_LOG_X k])))
  (if-zero CT
           (begin (eq! (shift PHASE 3)
                       (+ RLPRECEIPT_SUBPHASE_ID_TOPIC_BASE (* 2 RLPRECEIPT_SUBPHASE_ID_TOPIC_DELTA)))
                  (eq! (shift DATA_HI 3) [TOPIC_HI 2])
                  (eq! (shift DATA_LO 3) [TOPIC_LO 2]))))

(defconstraint verticalization-row-5 (:guard (reduce + (for k [3 : 4] [IS_LOG_X k])))
  (if-zero CT
           (begin (eq! (shift PHASE 4)
                       (+ RLPRECEIPT_SUBPHASE_ID_TOPIC_BASE (* 3 RLPRECEIPT_SUBPHASE_ID_TOPIC_DELTA)))
                  (eq! (shift DATA_HI 4) [TOPIC_HI 3])
                  (eq! (shift DATA_LO 4) [TOPIC_LO 3]))))

(defconstraint verticalization-row-6 (:guard (reduce + (for k [4 : 4] [IS_LOG_X k])))
  (if-zero CT
           (begin (eq! (shift PHASE 5)
                       (+ RLPRECEIPT_SUBPHASE_ID_TOPIC_BASE (* 4 RLPRECEIPT_SUBPHASE_ID_TOPIC_DELTA)))
                  (eq! (shift DATA_HI 5) [TOPIC_HI 4])
                  (eq! (shift DATA_LO 5) [TOPIC_LO 4]))))

(defconstraint verticalisation-no-log ()
  (if-zero TXN_EMITS_LOGS
           (begin (eq! PHASE RLPRECEIPT_SUBPHASE_ID_NO_LOG_ENTRY)
                  (vanishes! DATA_HI)
                  (vanishes! DATA_LO))))


