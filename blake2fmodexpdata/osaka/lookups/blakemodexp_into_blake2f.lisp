(defun (blakemodexp-to-blake2f-selector)
  (* blakemodexp.IS_BLAKE_DATA))

;; add IDs

(defclookup
  blakemodexp-into-blake2f
  ;; target columns
  (
    (:: blake2f.h0_input blake2f.h1_input)
    (:: blake2f.h2_input blake2f.h3_input)
    (:: blake2f.h4_input blake2f.h5_input)
    (:: blake2f.h6_input blake2f.h7_input)
    (:: blake2f.mo       blake2f.m1      )
    (:: blake2f.m2       blake2f.m3      )
    (:: blake2f.m4       blake2f.m5      )
    (:: blake2f.m6       blake2f.m7      )
    (:: blake2f.m8       blake2f.m9      )
    (:: blake2f.m10      blake2f.m11     )
    (:: blake2f.m12      blake2f.m13     )
    (:: blake2f.m14      blake2f.m15     )
    (:: blake2f.to       blake2f.t1      )
  )
  ;; source selector
  (blakemodexp-to-blake2f-selector)
  ;; source columns
  (
    (shift blakemodexp.LIMB 0 )
    (shift blakemodexp.LIMB 1 )
    (shift blakemodexp.LIMB 2 )
    (shift blakemodexp.LIMB 3 )
    (shift blakemodexp.LIMB 4 )
    (shift blakemodexp.LIMB 5 )
    (shift blakemodexp.LIMB 6 )
    (shift blakemodexp.LIMB 7 )
    (shift blakemodexp.LIMB 8 )
    (shift blakemodexp.LIMB 9 )
    (shift blakemodexp.LIMB 10)
    (shift blakemodexp.LIMB 11)
    (shift blakemodexp.LIMB 12)
  ))

