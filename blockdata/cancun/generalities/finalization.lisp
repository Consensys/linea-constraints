(module blockdata)

(defconstraint   generalities---finalization-constraints
                 (:domain {-1})
                 (begin
                   (eq!   IS_BL   1)
                   (eq!   CT      CT_MAX)
                   ))
