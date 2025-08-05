(module rlptxn)

;; address constancy
(defconstraint rlptxn---AL-address-constancy ()
 (if-not-zero (force-bin (+ IS_ACCESS_LIST_ADDRESS IS_PREFIX_OF_STORAGE_KEY_LIST IS_ACCESS_LIST_STORAGE_KEY))
    (begin
    (remained-constant! (rlptxn---AL-address-hi))
    (remained-constant! (rlptxn---AL-address-lo))))) 


;; access list item countdown
(defconstraint rlptxn---AL-item-countdown-initialization ()
   (if-not-zero (is-access-list-prefix)
      (eq! (AL-item-countdown) (prev txn/NUMBER_OF_PREWARMED_ADDRESSES))))

(defconstraint rlptxn---AL-item-countdown-update ()
   (if-not-zero (is-access-list-data)
      (eq! (AL-item-countdown) (- (prev (AL-item-countdown)) 
                                  (* IS_PREFIX_OF_ACCESS_LIST_ITEM (prev DONE))))))

;; storage key countdown
(defconstraint rlptxn---storage-key-countdown-initialization ()
   (if-not-zero (is-access-list-prefix)
      (eq! (storage-key-countdown) (prev txn/NUMBER_OF_PREWARMED_STORAGE_KEYS))))

(defconstraint rlptxn---storage-key-countdown-update ()
   (if-not-zero (is-access-list-data)
      (eq! (storage-key-countdown) (- (prev (storage-key-countdown)) 
                                      (* IS_ACCESS_LIST_STORAGE_KEY (prev DONE))))))

;; storage key list countdown
(defconstraint rlptxn---storage-key-list-countdown-update ()
   (if-not-zero IS_ACCESS_LIST_STORAGE_KEY
      (eq! (storage-key-list-countdown) (- (prev (storage-key-list-countdown)) 
                                           (prev DONE)))))

(defconstraint rlptxn---storage-key-list-countdown-finalization ()
   (if-not-zero (end-of-tuple-or-end-of-phase)
      (vanishes! (storage-key-list-countdown))))

;; AL rlp length countdown
(defconstraint rlptxn---AL-rlp-length-countdown-update ()
   (if-not-zero (is-access-list-data)
      (eq! (AL-rlp-length-countdown) (- (prev (AL-rlp-length-countdown)) 
                                        (* LC cmp/LIMB_SIZE)))))

;; AL item rlp length countdown
(defconstraint rlptxn---AL-item-rlp-length-countdown-update ()
   (if-not-zero (force-bin (+ IS_ACCESS_LIST_ADDRESS IS_PREFIX_OF_STORAGE_KEY_LIST IS_ACCESS_LIST_STORAGE_KEY))
      (eq! (AL-item-rlp-length-countdown) (- (prev (AL-item-rlp-length-countdown)) 
                                             (* LC cmp/LIMB_SIZE)))))
                     
(defconstraint rlptxn---AL-item-rlp-length-countdown-finalization ()
   (if-not-zero (end-of-tuple-or-end-of-phase)
      (vanishes! (AL-item-rlp-length-countdown))))