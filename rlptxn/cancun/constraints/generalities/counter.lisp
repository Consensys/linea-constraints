(module rlptxn)

(defconstraint ct-constancy-of-ct-max () (counter-constant CT_MAX CT))

(defconstraint counter-vanishes-outside-computation ()
    (if-zero CMP 
        (begin 
        (vanishes! CT)
        (vanishes! CT_MAX))))

(defconstraint ct-loop ()
    (if (== CT CT_MAX)
        (vanishes! (next CT))
        (will-inc! CT 1)))

(defcomputedcolumn (DONE :binary)
    (if (== CT CT_MAX)
        (phase-flag-sum)
        0))