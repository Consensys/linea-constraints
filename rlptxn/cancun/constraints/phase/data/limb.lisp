(module rlptxn)

(defun (zeros-in-limb)      cmp/EXO_DATA_5)
(defun (nonzs-in-limb)      cmp/EXO_DATA_7)

(defconstraint data-limb-analysis ()
    (if-not-zero (is-limb-content-analysis-row)
        (begin  
        (rlputils-call-data-pricing 0 cmp/LIMB cmp/LIMB_SIZE)
        (eq! (zeros-countdown) (- (prev (zeros-countdown)) (zeros-in-limb)))
        (eq! (nonzs-countdown) (- (prev (nonzs-countdown)) (nonzs-in-limb)))
        (if-zero PHASE_END (eq! cmp/LIMB_SIZE LLARGE))
        (eq! PHASE_END (* (~ (zeros-countdown)) (~ (nonzs-countdown))))
        (eq! PHASE_END DONE)
        )))