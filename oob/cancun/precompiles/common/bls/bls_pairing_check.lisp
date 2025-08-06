(module oob)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ;;
;;   For BLS_PAIRING_CHECK   ;;
;;                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (prc-blspairingcheck---standard-precondition)                                   IS_BLS_PAIRING_CHECK)
(defun (prc-blspairingcheck---remainder)                                               (shift OUTGOING_RES_LO 2))
(defun (prc-blspairingcheck---cds-is-multiple-of-min-bls-pairing-check-size)           (shift OUTGOING_RES_LO 3))
(defun (prc-blspairingcheck---insufficient-gas)                                        (shift OUTGOING_RES_LO 4))
(defun (prc-blspairingcheck---sufficient-gas)                                          (- 1 (prc-blspairingcheck---insufficient-gas)))

(defun (prc-blspairingcheck---precompile-cost_PRC_BLS_PAIRING_CHECK_SIZE_MIN)       (*    (prc-blspairingcheck---cds-is-multiple-of-min-bls-pairing-check-size)
                                                                  (+ (* GAS_CONST_BLS_PAIRING_CHECK PRC_BLS_PAIRING_CHECK_SIZE_MIN) (* GAS_CONST_BLS_PAIRING_CHECK_PAIR (prc---cds)))))

(defconstraint prc-blspairingcheck---mod-cds-by-PRC_BLS_PAIRING_CHECK_SIZE_MIN (:guard (* (assumption---fresh-new-stamp) (prc-blspairingcheck---standard-precondition)))
  (call-to-MOD 2 0 (prc---cds) 0 PRC_BLS_PAIRING_CHECK_SIZE_MIN))

(defconstraint prc-blspairingcheck---check-remainder-is-zero (:guard (* (assumption---fresh-new-stamp) (prc-blspairingcheck---standard-precondition)))
  (call-to-ISZERO 3 0 (prc-blspairingcheck---remainder)))

(defconstraint prc-blspairingcheck---compare-call-gas-against-precompile-cost (:guard (* (assumption---fresh-new-stamp) (prc-blspairingcheck---standard-precondition)))
  (if-zero (prc-blspairingcheck---cds-is-multiple-of-min-bls-pairing-check-size)
           (noCall 4)
           (begin (vanishes! (shift ADD_FLAG 4))
                  (vanishes! (shift MOD_FLAG 4))
                  (eq! (shift WCP_FLAG 4) 1)
                  (eq! (shift OUTGOING_INST 4) EVM_INST_LT)
                  (vanishes! (shift [OUTGOING_DATA 1] 4))
                  (eq! (shift [OUTGOING_DATA 2] 4) (prc---callee-gas))
                  (vanishes! (shift [OUTGOING_DATA 3] 4))
                  (eq! (* (shift [OUTGOING_DATA 4] 4) PRC_BLS_PAIRING_CHECK_SIZE_MIN)
                       (prc-blspairingcheck---precompile-cost_PRC_BLS_PAIRING_CHECK_SIZE_MIN)))))

(defconstraint prc-blspairingcheck---justify-hub-predictions (:guard (* (assumption---fresh-new-stamp) (prc-blspairingcheck---standard-precondition)))
  (begin (eq! (prc---hub-success)
              (* (prc---cds-is-non-zero) (prc-blspairingcheck---cds-is-multiple-of-min-bls-pairing-check-size) (prc-blspairingcheck---sufficient-gas)))
         (if-zero (prc---hub-success)
                  (vanishes! (prc---return-gas))
                  (eq! (* (prc---return-gas) PRC_BLS_PAIRING_CHECK_SIZE_MIN)
                       (- (* (prc---callee-gas) PRC_BLS_PAIRING_CHECK_SIZE_MIN) (prc-blspairingcheck---precompile-cost_PRC_BLS_PAIRING_CHECK_SIZE_MIN))))))
