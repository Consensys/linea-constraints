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

(defun (storage-reading) 
  (begin
    (eq! storage/VAL_CURR_HI storage/VAL_NEXT_HI)
    (eq! storage/VAL_CURR_LO storage/VAL_NEXT_LO)))

(defun (turn-on-storage-warmth)
  (eq! storage/WARMTH_NEW 1))

(defun (same-storage-slot)
  (begin
    (remained-constant! storage/ADDRESS_HI        )
    (remained-constant! storage/ADDRESS_LO        )
    (remained-constant! storage/KEY_LO            )
    (remained-constant! storage/KEY_HI            )
    (remained-constant! storage/DEPLOYMENT_NUMBER )))

(defun (undo-storage-warmth-update)
  (begin
    (was-eq! storage/WARMTH_NEW storage/WARMTH)
    (was-eq! storage/WARMTH     storage/WARMTH_NEW)))

(defun (undo-storage-value-update)
  (begin
    (was-eq! storage/VAL_NEXT_HI storage/VAL_CURR_HI)
    (was-eq! storage/VAL_NEXT_LO storage/VAL_CURR_LO)
    (was-eq! storage/VAL_CURR_HI storage/VAL_NEXT_HI)
    (was-eq! storage/VAL_CURR_LO storage/VAL_NEXT_LO)))

(defun (undo-storage-warmth-and-value-updates)
  (begin
    (undo-storage-warmth-update)
    (undo-storage-value-update)))

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
