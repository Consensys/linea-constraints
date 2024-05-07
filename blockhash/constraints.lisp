(module blockhash)

(defconstraint first-row (:domain {0})
  (vanishes! IOMF))

(defconstraint heartbeat ()
  (if-zero IOMF
           (begin (vanishes! IN_RANGE)
                  (vanishes! BLOCK_NUMBER_HI)
                  (vanishes! BLOCK_NUMBER_LO))
           (begin (eq! IOMF 1)
                  (eq! (next IOMF) IOMF))))

(defconstraint horizontal-byte-dec ()
  (begin (eq! BLOCK_HASH_HI
              (+ (for i
                      [0 : LLARGEMO]
                      (* (^ 256 i) [BYTE_HI i]))))
         (eq! BLOCK_HASH_LO
              (+ (for i
                      [0 : LLARGEMO]
                      (* (^ 256 i) [BYTE_LO i]))))))

(defconstraint constency ()
  (begin (eq! IN_RANGE (* LOWER_BOUND_CHECK UPPER_BOUND_CHECK))
         (eq! RES_HI (* IN_RANGE BLOCK_HASH_HI))
         (eq! RES_LO (* IN_RANGE BLOCK_HASH_LO))
         (if-zero (remained-constant! BLOCK_NUMBER_LO)
                  (begin (remained-constant! BLOCK_HASH_HI)
                         (remained-constant! BLOCK_HASH_LO)))))


