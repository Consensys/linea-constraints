(module rlptxn)

(defconstraint al-finalization ()
    (if-not-zero (* IS_ACCESS_LIST PHASE_END)
        (begin
        (vanishes! (rlptxn---AL---item-countdown))
        (vanishes! (rlptxn---AL---storage-key-countdown))
        (vanishes! (rlptxn---AL---storage-key-list-countdown))
        (vanishes! (rlptxn---AL---rlp-length-countdown))
        (vanishes! (rlptxn---AL---item-rlp-length-countdown))
        )))
