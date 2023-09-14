(module log_data)

(defconst
  LLARGE 16)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.1 Heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint first-row (:domain {0}) (vanishes! ABS_LOG_NUM))

(defconstraint forced-vanishing ()
               (if-zero ABS_LOG_NUM
                        (begin
                          (vanishes! LOG_LOGS_DATA)
                          (vanishes! SIZE_TOTAL)
                          (vanishes! SIZE_ACC)
                          (vanishes! SIZE_LIMB)
                          (vanishes! LIMB)
                          (vanishes! INDEX))))

(defconstraint number-increments ()
               (vanishes! (* (remained-constant! ABS_LOG_NUM)
                             (did-inc!           ABS_LOG_NUM 1))))

(defconstraint index-reset ()
               (if-not-zero (remained-constant! ABS_LOG_NUM)
                            (vanishes! INDEX)))

(defconstraint log-logs-no-data (:guard ABS_LOG_NUM)
               (if-zero LOGS_DATA
                        (vanishes! SIZE_TOTAL)
                        (vanishes! SIZE_ACC)
                        (vanishes! SIZE_LIMB)
                        (vanishes! LIMB)
                        (did-inc! ABS_LOG_NUM 1)))

(defconstraint log-logs-data (:guard LOG_LOGS_DATA)
               (begin
                 (if-not-zero (remained-constant! ABS_LOG_NUM) (= SIZE_ACC SIZE_LIMB))
                 (if-not-zero (did-inc ABS_LOG_NUM 1)
                              (begin
                                (= SIZE_ADD (+ (prev SIZE_ADD) SIZE_LIMB))
                                (debug (= SIZE_LIMB LLARGE))
                                (did-inc INDEX 1)))
                 (if-not-zero (will-remain-constant ABS_LOG_NUM)
                              (begin
                                (= SIZE_TOTAL SIZE_ACC)
                                (vanishes! (next INDEX))))))

(defconstraint final-row (:domain {-1} :guard ABS_LOG_NUM)
               (begin
                 (= ABS_LOG_NUM ABS_LOG_NUM_MAX)
                 (if-eq LOG_LOGS_DATA 1 (= SIZE_ACC SIZE_TOTAL))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    2.2 Constancies    ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun (log-constancy X) (if-not-zero (did-inc! ABS_LOG_NUM) (remained-constant X)))

(defconstraint log-constancies ()
               (begin
                 (log-constancy SIZE_TOTAL)
                 (log-constancy LOG_LOGS_DATA)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;    2.3 LOG_LOGS_DATA    ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint log-logs-data-definition ()
               (if-zero SIZE_TOTAL
                        (vanishes! LOG_LOGS_DATA)
                        (= LOG_LOGS_DATA 1)))
