(module rlptxn)

(defconstraint al-finalization ()
    (if-not-zero (* IS_ACCESS_LIST PHASE_END)
        (begin
        (vanishes! (rlptxn---access-list---item-countdown))
        (vanishes! (rlptxn---access-list---storage-key-countdown))
        (vanishes! (rlptxn---access-list---storage-key-list-countdown))
        (vanishes! (rlptxn---access-list---AL-RLP-length-countdown))
        (vanishes! (rlptxn---access-list---AL-item-RLP-length-countdown))
        )))
