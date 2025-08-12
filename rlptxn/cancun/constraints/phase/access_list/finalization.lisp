(module rlptxn)

(defconstraint al-finalization ()
    (if-not-zero (* IS_ACCESS_LIST PHASE_END)
        (begin
        (vanishes! (rlptxn---access-list---item-countdown))
        (vanishes! (rlptxn---access-list---storage-key-countdown))
        (vanishes! (rlptxn---access-list---storage-key-list-countdown))
        (vanishes! (rlptxn---access-list---AL-rlp-length-countdown))
        (vanishes! (rlptxn---access-list---AL-item-rlp-length-countdown))
        )))
