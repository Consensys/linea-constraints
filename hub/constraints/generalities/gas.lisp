(module hub)

;;;;;;;;;;;;;;;;;
;;             ;;
;;   4.4 Gas   ;;
;;             ;;
;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                   ;;
;;   4.4.1 Gas column generalities   ;;
;;                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint gas-column-constancies ()
               (begin (hub-stamp-constancy GAS_EXPECTED)
                      (hub-stamp-constancy GAS_ACTUAL)
                      (hub-stamp-constancy GAS_COST)
                      (hub-stamp-constancy GAS_NEXT)
                      (hub-stamp-constancy REFGAS)
                      (hub-stamp-constancy REFGAS_NEW)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                      ;;
;;   4.4.2 Gas transition constraints   ;;
;;                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint setting-GAS_NEXT (:guard TX_EXEC)
               (begin
                 (if-zero XAHOY
                          (eq!       GAS_NEXT (- GAS_ACTUAL GAS_COST))
                          (vanishes! GAS_NEXT))))

(defconstraint gas-transitions-at-hub-stamp-transition ()
               (begin
                 (if-not-zero (will-remain-constant! HUB_STAMP)
                              (if-not-zero TX_EXEC
                                           (if-not-zero (next TX_EXEC)
                                                        (begin
                                                          (if-eq CN_NEW CN               (eq! (next GAS_ACTUAL) (next GAS_EXPECTED)))
                                                          (if-eq CN_NEW CALLER_CN        (eq! (next GAS_ACTUAL) (+ (next GAS_EXPECTED) GAS_NEXT)))
                                                          (if-eq CN_NEW (+ 1 HUB_STAMP)  (eq! (next GAS_ACTUAL) (next GAS_EXPECTED)))))))))
                                                                                           ;; can't define GAS_EXPECTED at this level of generality
