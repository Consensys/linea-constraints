(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                       ;;;;
;;;;    X.1 Storage-rows   ;;;;
;;;;                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                    ;;
;;    X.1.5 Specialized constraints   ;;
;;                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (storage-reading kappa) 
  (begin
    (eq! (shift storage/VAL_CURR_HI kappa) (shift storage/VAL_NEXT_HI kappa))
    (eq! (shift storage/VAL_CURR_LO kappa) (shift storage/VAL_NEXT_LO kappa))))

(defun (turn-on-storage-warmth kappa)
  (eq! (shift storage/WARMTH_NEW kappa) 1))

(defun (same-storage-slot kappa)
  (begin
    (remained-constant! (shift storage/ADDRESS_HI        kappa) )
    (remained-constant! (shift storage/ADDRESS_LO        kappa) )
    (remained-constant! (shift storage/KEY_LO            kappa) )
    (remained-constant! (shift storage/KEY_HI            kappa) )
    (remained-constant! (shift storage/DEPLOYMENT_NUMBER kappa) )))

(defun (undo-storage-warmth-update kappa)
  (begin
    (shift (was-eq! storage/WARMTH_NEW  storage/WARMTH    ) kappa)
    (shift (was-eq! storage/WARMTH      storage/WARMTH_NEW) kappa)))

(defun (undo-storage-value-update)
  (begin
    (shift (was-eq! storage/VAL_NEXT_HI storage/VAL_CURR_HI) kappa)
    (shift (was-eq! storage/VAL_NEXT_LO storage/VAL_CURR_LO) kappa)
    (shift (was-eq! storage/VAL_CURR_HI storage/VAL_NEXT_HI) kappa)
    (shift (was-eq! storage/VAL_CURR_LO storage/VAL_NEXT_LO) kappa)))

(defun (undo-storage-warmth-and-value-update kappa)
  (begin
    (undo-storage-warmth-update kappa)
    (undo-storage-value-update  kappa)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        ;;
;;    X.1.5 Binary columns for gas cost   ;;
;;                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; TODO: make sure that binary@prove in the column declaration
;; ;; of the storage perspective makes this obsolete
;; (defconstraint storage-binarities (:perspective storage)
;;                (begin
;;                  (is-binary VAL_ORIG_IS_ZERO)
;;                  (is-binary VAL_NEXT_IS_ZERO)
;;                  (is-binary VAL_NEXT_IS_CURR)
;;                  (is-binary VAL_NEXT_IS_ORIG)
;;                  (is-binary VAL_CURR_IS_ZERO)
;;                  (is-binary VAL_CURR_IS_ORIG)
;;                  (is-binary VAL_CURR_CHANGES)))

(defconstraint setting-storage-binary-flag-VAL_ORIG_IS_ZERO (:perspective storage)
               (begin
                 (if-not-zero VAL_ORIG_HI
                              (vanishes! VAL_ORIG_IS_ZERO)
                              (if-not-zero VAL_ORIG_LO
                                           (vanishes! VAL_ORIG_IS_ZERO)
                                           (eq!       VAL_ORIG_IS_ZERO 1)))))

(defconstraint setting-storage-binary-flag-VAL_CURR_IS_ZERO (:perspective storage)
               (begin
                 (if-not-zero VAL_CURR_HI
                              (vanishes! VAL_CURR_IS_ZERO)
                              (if-not-zero VAL_CURR_LO
                                           (vanishes! VAL_CURR_IS_ZERO)
                                           (eq!       VAL_CURR_IS_ZERO 1)))))

(defconstraint setting-storage-binary-flag-VAL_NEXT_IS_ZERO (:perspective storage)
               (begin
                 (if-not-zero VAL_NEXT_HI
                              (vanishes! VAL_NEXT_IS_ZERO)
                              (if-not-zero VAL_NEXT_LO
                                           (vanishes! VAL_NEXT_IS_ZERO)
                                           (eq!       VAL_NEXT_IS_ZERO 1)))))

(defconstraint setting-storage-binary-flag-VAL_CURR_IS_ORIG (:perspective storage)
               (begin
                 (if-not-zero (- VAL_CURR_HI VAL_ORIG_HI)
                              (vanishes! VAL_CURR_IS_ORIG)
                              (if-not-zero (- VAL_CURR_LO VAL_ORIG_LO)
                                           (vanishes! VAL_CURR_IS_ORIG)
                                           (eq!       VAL_CURR_IS_ORIG 1)))))

(defconstraint setting-storage-binary-flag-VAL_NEXT_IS_CURR (:perspective storage)
               (begin
                 (if-not-zero (- VAL_NEXT_HI VAL_CURR_HI)
                              (vanishes! VAL_NEXT_IS_CURR)
                              (if-not-zero (- VAL_NEXT_LO VAL_CURR_LO)
                                           (vanishes! VAL_NEXT_IS_CURR)
                                           (eq!       VAL_NEXT_IS_CURR 1)))))

(defconstraint setting-storage-binary-flag-VAL_NEXT_IS_ORIG (:perspective storage)
               (begin
                 (if-not-zero (- VAL_NEXT_HI VAL_ORIG_HI)
                              (vanishes! VAL_NEXT_IS_ORIG)
                              (if-not-zero (- VAL_NEXT_LO VAL_ORIG_LO)
                                           (vanishes! VAL_NEXT_IS_ORIG)
                                           (eq!       VAL_NEXT_IS_ORIG 1)))))
