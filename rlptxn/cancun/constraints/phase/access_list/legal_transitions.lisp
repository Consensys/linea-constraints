(module rlptxn)

(defconstraint setting-first-row-after-prefix ()
    (if-not-zero (is-payload-size-analysis-row)
        (eq! (next IS_PREFIX_OF_ACCESS_LIST_ITEM) (next IS_ACCESS_LIST))))

(defconstraint setting-flag-after-rlp-tuple ()
    (if-not-zero IS_PREFIX_OF_ACCESS_LIST_ITEM
        (begin 
        (eq! (+ IS_PREFIX_OF_ACCESS_LIST_ITEM IS_ACCESS_LIST_ADDRESS) 1)
        (eq! (next IS_ACCESS_LIST_ADDRESS)                            DONE))))

(defconstraint setting-flag-after-address ()
    (if-not-zero IS_ACCESS_LIST_ADDRESS
        (begin 
        (eq! (+ IS_ACCESS_LIST_ADDRESS IS_PREFIX_OF_STORAGE_KEY_LIST) 1)
        (eq! (next IS_PREFIX_OF_STORAGE_KEY_LIST)                            DONE))))

(defconstraint setting-flag-after-storage-list-list-rlp ()
    (if-not-zero IS_PREFIX_OF_STORAGE_KEY_LIST
        (begin 
        (eq! (+ IS_PREFIX_OF_STORAGE_KEY_LIST IS_ACCESS_LIST_STORAGE_KEY IS_PREFIX_OF_ACCESS_LIST_ITEM)       (next IS_ACCESS_LIST))
        (eq! (+ (next IS_ACCESS_LIST_STORAGE_KEY) (next IS_PREFIX_OF_ACCESS_LIST_ITEM))                       (* (next IS_ACCESS_LIST) DONE)))))

(defconstraint setting-flag-after-storage-key ()
    (if-not-zero IS_ACCESS_LIST_STORAGE_KEY
        (begin 
        (eq! (+ IS_ACCESS_LIST_STORAGE_KEY IS_PREFIX_OF_ACCESS_LIST_ITEM)                       (next IS_ACCESS_LIST))
        (if-not-zero (next IS_PREFIX_OF_ACCESS_LIST_ITEM)
            (eq! DONE 1)))))