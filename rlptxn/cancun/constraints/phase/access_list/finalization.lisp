(module rlptxn)

(defconstraint al-finalization ()
    (if-not-zero (* IS_ACCESS_LIST PHASE_END)
        (begin
        (vanishes! (AL-item-countdown))
        (vanishes! (storage-key-countdown))
        (vanishes! (storage-key-list-countdown))
        (vanishes! (AL-rlp-length-countdown))
        (vanishes! (AL-item-rlp-length-countdown))
        )))