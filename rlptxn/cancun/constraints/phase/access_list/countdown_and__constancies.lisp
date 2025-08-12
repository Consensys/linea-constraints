(module rlptxn)

;; address constancy
(defconstraint rlptxn---AL---address-constancy ()
 (if-not-zero (force-bin (+ IS_ACCESS_LIST_ADDRESS IS_PREFIX_OF_STORAGE_KEY_LIST IS_ACCESS_LIST_STORAGE_KEY))
    (begin
    (remained-constant! (rlptxn---AL---address-hi))
    (remained-constant! (rlptxn---AL---address-lo))))) 


;; access list item countdown
(defconstraint rlptxn---rlptxn---AL---item-countdown-initialization ()
   (if-not-zero (is-access-list-prefix)
      (eq! (rlptxn---AL---item-countdown) (prev txn/NUMBER_OF_PREWARMED_ADDRESSES))))

(defconstraint rlptxn---rlptxn---AL---item-countdown-update ()
   (if-not-zero (is-access-list-data)
      (eq! (rlptxn---AL---item-countdown) (- (prev (rlptxn---AL---item-countdown)) 
                                  (* IS_PREFIX_OF_ACCESS_LIST_ITEM (prev DONE))))))

;; storage key countdown
(defconstraint rlptxn---rlptxn---AL---storage-key-countdown-initialization ()
   (if-not-zero (is-access-list-prefix)
      (eq! (rlptxn---AL---storage-key-countdown) (prev txn/NUMBER_OF_PREWARMED_STORAGE_KEYS))))

(defconstraint rlptxn---rlptxn---AL---storage-key-countdown-update ()
   (if-not-zero (is-access-list-data)
      (eq! (rlptxn---AL---storage-key-countdown) (- (prev (rlptxn---AL---storage-key-countdown)) 
                                      (* IS_ACCESS_LIST_STORAGE_KEY (prev DONE))))))

;; storage key list countdown
(defconstraint rlptxn---rlptxn---AL---storage-key-list-countdown-update ()
   (if-not-zero IS_ACCESS_LIST_STORAGE_KEY
      (eq! (rlptxn---AL---storage-key-list-countdown) (- (prev (rlptxn---AL---storage-key-list-countdown)) 
                                           (prev DONE)))))

(defconstraint rlptxn---rlptxn---AL---storage-key-list-countdown-finalization ()
   (if-not-zero (end-of-tuple-or-end-of-phase)
      (vanishes! (rlptxn---AL---storage-key-list-countdown))))

;; AL rlp length countdown
(defconstraint rlptxn---rlptxn---AL---rlp-length-countdown-update ()
   (if-not-zero (is-access-list-data)
      (eq! (rlptxn---AL---rlp-length-countdown) (- (prev (rlptxn---AL---rlp-length-countdown)) 
                                        (* LC cmp/LIMB_SIZE)))))

;; AL item rlp length countdown
(defconstraint rlptxn---rlptxn---AL---item-rlp-length-countdown-update ()
   (if-not-zero (force-bin (+ IS_ACCESS_LIST_ADDRESS IS_PREFIX_OF_STORAGE_KEY_LIST IS_ACCESS_LIST_STORAGE_KEY))
      (eq! (rlptxn---AL---item-rlp-length-countdown) (- (prev (rlptxn---AL---item-rlp-length-countdown)) 
                                             (* LC cmp/LIMB_SIZE)))))
                     
(defconstraint rlptxn---rlptxn---AL---item-rlp-length-countdown-finalization ()
   (if-not-zero (end-of-tuple-or-end-of-phase)
      (vanishes! (rlptxn---AL---item-rlp-length-countdown))))
