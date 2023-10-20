(defconst 
  int_short                         128  ;;RLP prefix of a short integer (<56 bytes), defined in the EYP.
  int_long                          183  ;;RLP prefix of a long integer (>55 bytes), defined in the EYP.
  list_short                        192  ;;RLP prefix of a short list (<56 bytes), defined in the EYP.
  list_long                         247  ;;RLP prefix of a long list (>55 bytes), defined in the EYP.
  LLARGE                            16
  LLARGEMO                          15
  G_txdatazero                      4    ;;Gas cost for a zero data byte, defined in the EYP.
  G_txdatanonzero                   16   ;;Gas cost for a non-zero data byte, defined in the EYP.
  create2_shift                     0xff ;; create2 first byte
  const_recipe_1                    1    ;; for RlpAddr, used to discriminate between recipe for create
  const_recipe_2                    2    ;; for RlpAddr, used to discriminate between recipe for create
  rlp_txnrcpt_subPhaseId_Type       7
  rlp_txnrcpt_subPhaseId_StatusCode 2
  rlp_txnrcpt_subPhaseId_CumulGas   3
  rlp_txnrcpt_subPhaseId_NoLogEntry 11
  rlp_txnrcpt_subPhaseId_Addr       53
  rlp_txnrcpt_subPhaseId_TopicBase  65
  rlp_txnrcpt_subPhaseId_DataLimb   77
  rlp_txnrcpt_subPhaseId_DataSize   83
  rlp_txnrcpt_subPhaseId_TopicDelta 96)

;;  Comparaison to 55 ;;
(defpurefun (compTo55 length comp acc)
  (eq! acc
       (- (* (- (* 2 comp) 1)
             (- length 55))
          comp)))

;; Byte counting constraints    ;;
(defpurefun (byteCountAndPower ct nStep done acc byteSize power)
  (if-zero ct
           (begin (if-zero acc
                           (begin (vanishes! byteSize)
                                  (if-eq nStep 8
                                         (eq! power (^ 256 9)))
                                  (if-eq nStep 16 (eq! power 256)))
                           (begin (eq! byteSize 1)
                                  (if-eq nStep 8
                                         (eq! power (^ 256 8)))
                                  (if-eq nStep 16 (eq! power 1)))))
           (if-zero (+ acc done)
                    (begin (remained-constant! byteSize)
                           (eq! power
                                (* 256 (prev power))))
                    (begin (did-inc! byteSize 1)
                           (remained-constant! power)))))

;; Rlp prefix of a small (< 16 bytes long) integer / bytestring ;;
;; we remind that this pattern excludes the case integer == 0, but includes the case bytestring == 0x00 ;;
(defpurefun (rlpPrefixInt input ct nStep done byte acc byteSize power bit bitAcc limb lc nBytes)
  (begin (byteCountAndPower ct nStep done acc byteSize power)
         (if-eq done 1
                (begin (eq! acc input)
                       (eq! bitAcc byte)
                       (if-zero (+ (shift bit -7) (- byteSize 1))
                                (vanishes! (prev lc))
                                (begin (eq! (+ (shift lc -2) (prev lc))
                                            1)
                                       (eq! (prev limb)
                                            (* (+ int_short byteSize) (^ 256 LLARGEMO)))
                                       (eq! (prev nBytes) 1)))))))

;;  RLP prefix for a byte string ;;
(defpurefun (rlpPrefixOfByteString length ct nStep done isList byteSize power comp acc1 acc2 lc limb nBytes)
  (begin (byteCountAndPower ct nStep done acc1 byteSize power)
         (if-eq done 1
                (begin (eq! acc1 length)
                       (compTo55 length comp acc2)
                       (if-zero comp
                                (begin (eq! (+ (prev lc) lc)
                                            1)
                                       (eq! limb
                                            (* (+ (* int_short (- 1 isList))
                                                  (* list_short isList)
                                                  length)
                                               (^ 256 LLARGEMO)))
                                       (eq! nBytes 1))
                                (begin (eq! (+ (shift lc -2) (prev lc))
                                            1)
                                       (eq! (prev limb)
                                            (* (+ (* int_long (- 1 isList))
                                                  (* list_long isList)
                                                  byteSize)
                                               (^ 256 LLARGEMO)))
                                       (eq! (prev nBytes) 1)
                                       (eq! limb (* length power))
                                       (eq! nBytes byteSize)))))))

;;  Limb Shifting     ;;
(defpurefun (limbShifting input power inputLength limb nBytes)
  (begin (eq! limb (* input power))
         (eq! nBytes inputLength)))


