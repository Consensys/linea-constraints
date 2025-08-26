(module blockdata)

(defconstraint    generalities---REL_BLOCK---initial-vanishing (:domain {-1})  ;; ""
                  (vanishes!   REL_BLOCK))

(defproperty      generalities---REL_BLOCK---has-0-1-increments
                  (has-0-1-increments   REL_BLOCK)
                  )

(defconstraint    generalities---REL_BLOCK---exact-increments ()
                  (eq!   (next   REL_BLOCK)
                         (+      REL_BLOCK
                                 (about-to-start-new-block))))

(defconstraint    generalities---REL_BLOCK--- ()
                  (if-zero   REL_BLOCK
                             (eq!   IOMF   0)
                             (eq!   IOMF   1)
                             ))
