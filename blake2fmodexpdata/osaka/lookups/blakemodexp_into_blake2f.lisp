(defun (blakemodexp-to-blake2f-selector)
  (* (- 1 (prev blake2fmodexpdata.IS_BLAKE_DATA)) blake2fmodexpdata.IS_BLAKE_DATA))

(defclookup
  (blakemodexp-into-blake2f :unchecked)
  ;; unchecked because of r and f
  ;; target columns
  (
    (:: blake2f.h0_input blake2f.h1_input)
    (:: blake2f.h2_input blake2f.h3_input)
    (:: blake2f.h4_input blake2f.h5_input)
    (:: blake2f.h6_input blake2f.h7_input)
    (:: blake2f.m0       blake2f.m1      )
    (:: blake2f.m2       blake2f.m3      )
    (:: blake2f.m4       blake2f.m5      )
    (:: blake2f.m6       blake2f.m7      )
    (:: blake2f.m8       blake2f.m9      )
    (:: blake2f.m10      blake2f.m11     )
    (:: blake2f.m12      blake2f.m13     )
    (:: blake2f.m14      blake2f.m15     )
    (:: blake2f.t0       blake2f.t1      )
    blake2f.r
    blake2f.f
    (:: blake2f.h0       blake2f.h1      )
    (:: blake2f.h2       blake2f.h3      )
    (:: blake2f.h4       blake2f.h5      )
    (:: blake2f.h6       blake2f.h7      )
  )
  ;; source selector
  (blakemodexp-to-blake2f-selector)
  ;; source columns
  (
    (shift blake2fmodexpdata.LIMB 0 )
    (shift blake2fmodexpdata.LIMB 1 )
    (shift blake2fmodexpdata.LIMB 2 )
    (shift blake2fmodexpdata.LIMB 3 )
    (shift blake2fmodexpdata.LIMB 4 )
    (shift blake2fmodexpdata.LIMB 5 )
    (shift blake2fmodexpdata.LIMB 6 )
    (shift blake2fmodexpdata.LIMB 7 )
    (shift blake2fmodexpdata.LIMB 8 )
    (shift blake2fmodexpdata.LIMB 9 )
    (shift blake2fmodexpdata.LIMB 10)
    (shift blake2fmodexpdata.LIMB 11)
    (shift blake2fmodexpdata.LIMB 12)
    (shift blake2fmodexpdata.LIMB 13)
    (shift blake2fmodexpdata.LIMB 14)
    (shift blake2fmodexpdata.LIMB 15)
    (shift blake2fmodexpdata.LIMB 16)
    (shift blake2fmodexpdata.LIMB 17)
    (shift blake2fmodexpdata.LIMB 18)
  ))

