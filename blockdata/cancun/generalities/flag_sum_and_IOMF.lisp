(module blockdata)

(defun   (about-to-start-new-block)   (* (-  1  IS_CB) (next IS_CB)))

;; binary constraints via binary@prove
(defconstraint   generalities---flag-sum-and-IOMF---initial-vanishing (:domain {-1}) ;; ""
                 (vanishes!   IOMF))

(defconstraint   generalities---flag-sum-and-IOMF---transition-from-0-to-1 ()
                 (if-zero   IOMF
                            (eq!   (next   IOMF)
                                   (about-to-start-new-block))))

(defconstraint   generalities---flag-sum-and-IOMF---nondecreasing-property ()
                 (if-not-zero   IOMF
                                (will-eq!  IOMF  1)))

(defconstraint   generalities---flag-sum-and-IOMF---pegging-IOMF-to-flag-sum ()
                 (eq!   (flag-sum)
                        IOMF))
