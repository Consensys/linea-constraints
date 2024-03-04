(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                                          ;;;;
;;;;    X.6 Storage consistency constraints   ;;;;
;;;;                                          ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpermutation 
  ;; permuted columns
  ;; replace scp with storage_consistency_permutation
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (
    scp_PEEK_AT_STORAGE
    scp_ADDRESS_HI
    scp_ADDRESS_LO
    scp_STORAGE_KEY_HI
    scp_STORAGE_KEY_LO
    scp_DOM_STAMP
    scp_SUB_STAMP
    ;;
    scp_ABS_TX_NUM
    scp_VAL_ORIG_HI
    scp_VAL_ORIG_LO
    scp_VAL_CURR_HI
    scp_VAL_CURR_LO
    scp_VAL_NEXT_HI
    scp_VAL_NEXT_LO
    ;;
    scp_WARM
    scp_WARM_NEW
    scp_DEPLOYMENT_NUMBER
    scp_DEPLOYMENT_NUMBER_INFTY
  )
  ;; original columns
  ;;;;;;;;;;;;;;;;;;;
  (
    (↓ PEEK_AT_STORAGE )
    (↓ storage/ADDRESS_HI )
    (↓ storage/ADDRESS_LO )
    (↓ storage/STORAGE_KEY_HI )
    (↓ storage/STORAGE_KEY_LO )
    (↓ DOM_STAMP )
    (↑ SUB_STAMP )
    ;;
    ABS_TX_NUM
    storage/VAL_ORIG_HI
    storage/VAL_ORIG_LO
    storage/VAL_CURR_HI
    storage/VAL_CURR_LO
    storage/VAL_NEXT_HI
    storage/VAL_NEXT_LO
    ;;
    storage/WARM
    storage/WARM_NEW
    storage/DEPLOYMENT_NUMBER
    storage/DEPLOYMENT_NUMBER_INFTY
  )
)

;; we should be guaranteed that this is a 20B integer given how it is filled:
;; - during pre-warming addresses are checked for smallness in the RLP_TXN
;; - or during SSTORE / SSLOAD operations addresses are obtained from context data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (scp_full_address) (+ (* (^ 256 16) scp_ADDRESS_HI)
                             scp_ADDRESS_LO))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        ;;
;;    X.6.3 Constraints for FIRST/FINAL   ;;
;;                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint sto-FIRST-FINAL-are-binary ()
               (begin
                 (is-binary sto_FIRST)
                 (is-binary sto_FINAL)))

(defconstraint sto-FIRST-FINAL-trivial ()
               (if-not-zero (- 1 scp_PEEK_AT_STORAGE)
                            (vanishes! (+ sto_FIRST sto_FINAL))))

(defconstraint sto-FIRST-FINAL-initialization ()
               (if-not-zero (prev (- 1 scp_PEEK_AT_STORAGE))
                            (if-not-zero scp_PEEK_AT_STORAGE
                                         (eq! 1 sto_FIRST))))

(defconstraint sto-FIRST-FINAL-régime-de-croisière ()
               (if-not-zero (prev scp_PEEK_AT_STORAGE)
                            (if-not-zero scp_PEEK_AT_STORAGE
                                         (begin
                                           (if-not-zero (remained-constant! (scp_full_address))
                                                        (begin
                                                          (was-eq! sto_FINAL 1)
                                                          (eq!     sto_FIRST 1)))
                                           (if-not-zero (remained-constant! scp_STORAGE_KEY_HI)
                                                        (begin
                                                          (was-eq! sto_FINAL 1)
                                                          (eq!     sto_FIRST 1)))
                                           (if-not-zero (remained-constant! scp_STORAGE_KEY_LO)
                                                        (begin
                                                          (was-eq! sto_FINAL 1)
                                                          (eq!     sto_FIRST 1)))
                                           (if-zero (remained-constant! (scp_full_address))
                                                    (if-zero (remained-constant! scp_STORAGE_KEY_HI)
                                                             (if-zero (remained-constant! scp_STORAGE_KEY_LO)
                                                                      (begin
                                                                        (vanishes! (prev sto_FINAL))
                                                                        (vanishes!       sto_FIRST)))))))))

(defconstraint sto-FIRST-FINAL-final-storage-row-1 ()
               (if-not-zero (prev scp_PEEK_AT_STORAGE)
                            (if-not-zero (- 1 scp_PEEK_AT_STORAGE)
                                         (eq! (prev sto_FINAL) 1))))

(defconstraint sto-FIRST-FINAL-final-storage-row-2 (:domain {-1})
               (if-not-zero scp_PEEK_AT_STORAGE
                            (vanishes! sto_FINAL)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;    X.6.4 Constraints   ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint setting-original-storage-value ()
               (if-not-zero sto_FIRST
                            (begin
                              (eq! scp_VAL_ORIG_HI scp_VAL_CURR_HI)
                              (eq! scp_VAL_ORIG_LO scp_VAL_CURR_LO))))

(defconstraint perpetuating-original-storage-value ()
               (if-not-zero scp_PEEK_AT_STORAGE
                            (if-not-zero (- 1 sto_FIRST)
                                         (if-eq-else scp_ABS_TX_NUM (prev scp_ABS_TX_NUM)
                                                     (begin
                                                       (remained-constant! scp_VAL_ORIG_HI)
                                                       (remained-constant! scp_VAL_ORIG_LO))
                                                     (begin
                                                       (eq!  scp_VAL_ORIG_HI  scp_VAL_CURR_HI)
                                                       (eq!  scp_VAL_ORIG_LO  scp_VAL_CURR_LO))))))

(defconstraint setting-and-resetting-storage-value ()
               (if-not-zero sto_FIRST
                            (if-not-zero scp_DEPLOYMENT_NUMBER
                                         (begin
                                           (vanishes! scp_VAL_CURR_HI)
                                           (vanishes! scp_VAL_CURR_LO)))
                            (if-not-zero scp_PEEK_AT_STORAGE
                                         (if-not-zero (remained-constant! scp_DEPLOYMENT_NUMBER)
                                                      (begin
                                                        (vanishes! scp_VAL_CURR_HI)
                                                        (vanishes! scp_VAL_CURR_LO))
                                                      (begin
                                                        (was-eq! scp_VAL_NEXT_HI scp_VAL_CURR_HI)
                                                        (was-eq! scp_VAL_NEXT_LO scp_VAL_CURR_LO))))))

(defconstraint setting-and-resetting-storage-key-warmth ()
               (if-not-zero scp_PEEK_AT_STORAGE
                            (if-zero sto_FIRST
                                     (remained-constant! scp_DEPLOYMENT_NUMBER_INFTY))))
