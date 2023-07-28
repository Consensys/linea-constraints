(module txRlp)

(defconst
  int_short               128  ;;RLP prefix of a short integer (<56 bytes), defined in the EYP.
  int_long                183  ;;RLP prefix of a long integer (>55 bytes), defined in the EYP.
  list_short              192  ;;RLP prefix of a short list (<56 bytes), defined in the EYP.
  list_long               247  ;;RLP prefix of a long list (>55 bytes), defined in the EYP.
  G_txdatazero            4    ;;Gas cost for a zero data byte, defined in the EYP.
  G_txdatanonzero         16   ;;Gas cost for a non-zero data byte, defined in the EYP.
  LLARGE                  16
  LLARGEMO                15)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    2.3 Global Constraints    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint boolean-constraint ()
  (begin 
  (is-binary LIMB_CONSTRUCTED)
  (is-binary LT)
  (is-binary LX)
  (is-binary REQUIRES_EVM_EXECUTION)
  (for i [14]
   (is-binary [PHASE i]))
  (is-binary end_phase)
  (is-binary DONE)
  (is-binary BIT)
  (is-binary is_bytesize)
  (is-binary is_list)
  (is-binary COMP)
  (is-binary is_padding)
  (is-binary is_prefix)
  (is-binary [DEPTH 1])
  (is-binary [DEPTH 2])))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.1 Constancy columns  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Definition counter-incrementing.
(defpurefun (counter-incrementing CT C)
  (if-not-zero CT
               (or! (remained-constant! C)
                    (did-inc! C 1))))

;; Definition phase-constancy.
(defpurefun (phase-constancy PHASE C)
  (if-eq (* PHASE (prev PHASE)) 1
         (remained-constant! C)))

;; Definition phase-incrementing
(defpurefun (phase-incrementing PHASE C)
  (if-eq (* PHASE (prev PHASE)) 1
         (or! (remained-constant! C)
              (did-inc! C 1))))

;; Definition phase-decrementing
(defpurefun (phase-decrementing PHASE C)
  (if-eq (* PHASE (prev PHASE)) 1
         (or! (remained-constant! C)
              (did-dec! C 1))))

;; Definition block-constant
(defpurefun (block-constant ABS_TX_NUM C)
  (if-zero ABS_TX_NUM
    (vanishes! C)
    (will-remain-constant! C)))

;; 2.3.1.1
(defconstraint stamp-constancies ()
(begin
  (stamp-constancy ABS_TX_NUM TYPE)
  (stamp-constancy ABS_TX_NUM REQUIRES_EVM_EXECUTION)
  (stamp-constancy ABS_TX_NUM CODE_FRAGMENT_INDEX)))

;; 2.3.1.2
(defconstraint counter-constancy ()
  (begin
   (counter-constancy CT [INPUT 1])
   (counter-constancy CT [INPUT 2])
   (counter-constancy CT number_step)
   (counter-constancy CT LT)
   (counter-constancy CT LX)
   (counter-constancy CT is_prefix)
   (counter-constancy CT is_bytesize)
   (counter-constancy CT is_list)
   (counter-constancy CT is_padding)
   (counter-constancy CT nb_Addr)
   (counter-constancy CT nb_Sto)
   (counter-constancy CT nb_Sto_per_Addr)
   (counter-constancy CT [DEPTH 1])
   (counter-constancy CT [DEPTH 2])
   (counter-constancy CT COMP)))

;; 2.3.1.3 & (debug 2.3.1.9)
(defconstraint counter-incrementing ()
  (begin
   (counter-incrementing CT LC)
   (debug (counter-incrementing CT DONE))
   (debug (counter-incrementing CT ACC_BYTESIZE))))

(defconstraint phase0-constancy ()
  (begin
   (phase-constancy [PHASE 0] RLP_LT_BYTESIZE)
   (phase-constancy [PHASE 0] RLP_LX_BYTESIZE)
   (phase-constancy [PHASE 0] DATA_HI)
   (phase-constancy [PHASE 0] DATA_LO)))

(defconstraint phase9-decrementing ()
  (phase-decrementing [PHASE 9] is_prefix))

(defconstraint phasek-constancies ()
  (for i [2:10]
       (begin
        (phase-constancy [PHASE i] DATA_HI)
        (phase-constancy [PHASE i] DATA_LO))))

(defconstraint block-constancies ()
  (block-constant ABS_TX_NUM ABS_TX_NUM_INFINY))

;; 2.3.1.7 (debug 2.3.1.11)
;; (defconstraint phase9-incrementing ()
;;   (begin
;;    (debug (phase-incrementing [PHASE 9] INDEX_DATA))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                      ;;
;;    2.3.2 Global Phase Constraints    ;;
;;                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.3.2.1
(defconstraint initial-stamp (:domain {0})
  (vanishes! ABS_TX_NUM))

;; 2.3.2.2
(defconstraint ABS_TX_NUM-is-zero ()
  (if-zero ABS_TX_NUM
           (vanishes! (reduce + (for i [0 : 14] [PHASE i])))))

;; 2.3.2.3
(defconstraint ABS_TX_NUM-is-nonzero ()
  (if-not-zero ABS_TX_NUM
               (eq! 1 (reduce + (for i [0 : 14] [PHASE i])))))

;; 2.3.2.4
(defconstraint ABS_TX_NUM-evolution()
  (eq! ABS_TX_NUM
       (+ (prev ABS_TX_NUM)
          (* [PHASE 0] (remained-constant! [PHASE 0])))))

;; 2.3.2.5
(defconstraint LC-null()
  (if-zero LC (vanishes! LIMB)))

;; 2.3.2.6
(defconstraint LT-and-LX()
  (if-eq (reduce + (for i [1 : 10] [PHASE i])) 1
         (eq! (+ LT LX) 2)))

;; 2.3.2.7
(defconstraint LT-only()
  (if-eq (reduce + (for i [12 : 14] [PHASE i])) 1
         (eq! 1 (+ LT (* 2 LX)))))

;; 2.3.2.8
(defconstraint no-done-no-end ()
  (if-zero DONE
           (vanishes! end_phase)))

;; 2.3.2.9
(defconstraint no-end-no-changephase ()
  (if-zero end_phase
           (vanishes! (reduce + (for i [0 : 14]
                                     (* i
                                        (- (next [PHASE i]) [PHASE i])))))))


;; 2.3.2.10
(defconstraint phase-transition ()
  (if-eq end_phase 1
         (begin
          (if-eq [PHASE 0] 1
                 (if-zero TYPE
                          (eq! (next [PHASE 2]) 1)
                          (eq! (next [PHASE 1]) 1)))
          (if-eq [PHASE 1] 1
                 (eq! (next [PHASE 2]) 1))
          (if-eq [PHASE 2] 1
                 (if-eq-else TYPE 2
                             (eq! (next [PHASE 4]) 1)
                             (eq! (next [PHASE 3]) 1)))
          (if-eq [PHASE 3] 1
                 (eq! (next [PHASE 6]) 1))
          (if-eq [PHASE 4] 1
                 (eq! (next [PHASE 5]) 1))
          (if-eq [PHASE 5] 1
                 (eq! (next [PHASE 6]) 1))
          (if-eq [PHASE 6] 1
                 (eq! (next [PHASE 7]) 1))
          (if-eq [PHASE 7] 1
                 (eq! (next [PHASE 8]) 1))
          (if-eq [PHASE 8] 1
                 (eq! (next [PHASE 9]) 1))
          (if-eq [PHASE 9] 1
                 (begin
                  (debug (vanishes! PHASE_BYTESIZE))
                  (vanishes! DATAGASCOST)
                  (if-zero TYPE
                           (eq! (next [PHASE 11]) 1)
                           (eq! (next [PHASE 10]) 1))))
          (if-eq [PHASE 10] 1
                 (begin
                  (debug (vanishes! PHASE_BYTESIZE))
                  (vanishes! nb_Addr)
                  (vanishes! nb_Sto)
                  (vanishes! nb_Sto_per_Addr)
                  (eq! (next [PHASE 12]) 1)))
          (if-eq [PHASE 11] 1
                 (eq! (next [PHASE 13]) 1))
          (if-eq [PHASE 12] 1
                 (eq! (next [PHASE 13]) 1))
          (if-eq [PHASE 13] 1
                 (eq! (next [PHASE 14]) 1))
          (if-eq [PHASE 14] 1
                 (begin
                  (vanishes! RLP_LT_BYTESIZE)
                  (vanishes! RLP_LX_BYTESIZE)
                  (eq! (next [PHASE 0]) 1))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.3 Byte decomposition's loop heartbeat  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.3.3.2 & 2.3.3.3
(defconstraint cy-imply-done (:guard ABS_TX_NUM)
  (if-eq-else CT (- number_step 1)
              (eq! DONE 1)
              (vanishes! DONE)))

;; 2.3.3.4 & 2.3.3.5
(defconstraint done-imply-heartbeat (:guard ABS_TX_NUM)
  (if-zero DONE
           (will-inc! CT 1)
           (begin
            (eq! LC (- 1 is_padding))
            (vanishes! (next CT)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.4 Blind Byte and Bit decomposition  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.3.4.1
(defconstraint byte-decompositions ()
  (for k [1:2]
       (byte-decomposition CT [ACC k] [BYTE k])))

;; 2.3.4.2
(defconstraint bit-decomposition ()
  (if-zero CT
           (eq! BIT_ACC BIT)
           (eq! BIT_ACC (+ (* 2 (prev BIT_ACC)) BIT))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.5 Global Constraints  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.3.5.1 & 2.3.5.2
(defconstraint init-index()
  (if-zero (remained-constant! ABS_TX_NUM)
           (begin
            (eq! INDEX_LT
                 (+ (prev INDEX_LT)
                    (* (prev LC) (prev LT))))
            (eq! INDEX_LX
                 (+ (prev INDEX_LX)
                    (* (prev LC) (prev LX)))))
           (begin
            (vanishes! INDEX_LT)
            (vanishes! INDEX_LX))))

;; 2.3.5.3
(defconstraint rlpbytesize-decreasing()
  (if-eq 1 (reduce + (for i [1 : 14] [PHASE i]))
         (begin
          (eq! RLP_LT_BYTESIZE
               (- (prev RLP_LT_BYTESIZE)
                  (* LC LT nBYTES)))
          (eq! RLP_LX_BYTESIZE
               (- (prev RLP_LX_BYTESIZE)
                  (* LC LX nBYTES))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                      ;;
;;    2.3.6 Finalisation Constraints    ;;
;;                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint finalisation (:domain {-1})
  (if-not-zero ABS_TX_NUM
               (begin
                (eq! ABS_TX_NUM_INFINY ABS_TX_NUM)
                (eq! 2
                    (+ end_phase [PHASE 14])))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3 Constraints patterns   ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            ;;
;;    3.1 RLP prefix constraint of 1 Input    ;;
;;                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (rlpPrefixConstraints input ct nbstep isbytesize islist)
    (if-eq-else number_step 1
                 (begin                                                                                            ;; 1.a
                  (if-zero islist                                                                                          ;; 1
                           (eq! LIMB (* int_short (^ 256 LLARGEMO)))
                           (eq! LIMB (* list_short (^ 256 LLARGEMO))))
                  (eq! nBYTES 1))
                 (begin
                  (if-eq number_step 8 (ByteCountingConstraints 1 (- LLARGE 8)))                ;; 2.a
                  (if-eq number_step 12 (ByteCountingConstraints 1 (- LLARGE 12)))
                  (if-eq DONE 1                                                                                            ;; 2.b
                         (begin
                          (eq! [ACC 1] input)                                                                        ;; 2.b.i
                          (eq! BIT_ACC [BYTE 1])                                                                             ;;2.b.ii
                          (eq! [ACC 2]                                                                  ;; 2.b.iii
                               (- (* (- (* 2 COMP) 1)
                                     (- input 55))
                                  COMP))
                          (if-zero isbytesize                                          ;;2.b.iv
                                   (begin
                                    (if-zero (+ (- ACC_BYTESIZE 1)
                                                (shift BIT -7))
                                             (vanishes! (prev LC))                                             ;;2.b.iv.A
                                             (begin                                                                ;; 2.B.iv.B/C/D
                                              (did-change! (prev LC))
                                              (eq! (prev LIMB)
                                                   (* (+ int_short ACC_BYTESIZE)
                                                      (^ 256 15)))
                                              (eq! (prev nBYTES) 1)))
                                    (eq! LIMB (* input P))
                                    (eq! nBYTES ACC_BYTESIZE)))
                          (if-zero (+ (- 1 isbytesize)
                                      islist)                    ;;2.b.v
                                   (if-zero COMP
                                            (begin                                                  ;; 2.b.v.A
                                             (vanishes! (prev LC))
                                             (eq! LIMB
                                                  (* (+ int_short input)
                                                     (^ 256 15)))
                                             (eq! nBYTES 1))
                                            (begin                                                  ;; 2.b.v.B
                                             (did-change! (prev LC))
                                             (eq! (prev LIMB) (* (+ int_long ACC_BYTESIZE)
                                                                 (^ 256 15)))
                                             (eq! (prev nBYTES) 1)
                                             (eq! LIMB (* input P))
                                             (eq! nBYTES ACC_BYTESIZE))))
                          (if-eq islist 1                   ;;2.b.vi
                                 (if-zero COMP
                                          (begin                                                  ;; 2.b.vi.A
                                           (vanishes! (prev LC))
                                           (eq! LIMB
                                                (* (+ list_short input)
                                                   (^ 256 15)))
                                           (eq! nBYTES 1))
                                          (begin                                                  ;; 2.b.vi.B
                                           (did-change! (prev LC))
                                           (eq! (prev LIMB)
                                                (* (+ list_long ACC_BYTESIZE)
                                                   (^ 256 15)))
                                           (eq! (prev nBYTES) 1)
                                           (eq! LIMB (* input P))
                                           (eq! nBYTES ACC_BYTESIZE)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.2 RLP prefix constraint of a 32 bytes integer  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (rlp32bytesIntegerConstraints input_hi input_lo number_step ct)
    (if-eq-else number_step 1
                 (begin                                                                ;; 1
                  (eq! LIMB (* int_short (^ 256 15)))
                  (eq! nBYTES 1))
                 (begin                                                                           ;; 2
                  (eq! number_step 16)
                  (if-zero input_hi
                           (ByteCountingConstraints 2 0)                                         ;;2.b
                           (ByteCountingConstraints 1 0))                                            ;;2.c
                  (if-eq DONE 1                                                         ;;2.d
                         (begin
                          (eq! [ACC 1] input_hi)
                          (eq! [ACC 2] input_lo)
                          (if-zero input_hi
                                   (begin                                                  ;; 2.d.iii
                                    (eq! BIT_ACC [BYTE 2])                      ;; 2.d.ii
                                    (if-zero (+ (- ACC_BYTESIZE 1)
                                                (shift BIT -7))

                                             (begin                      ;; 2.d.iii.A
                                              (did-change! LC)
                                              (eq! LIMB (* input_lo P))
                                              (eq! nBYTES ACC_BYTESIZE))
                                             (begin                      ;; 2.d.iii.B
                                              (did-change! (prev LC))
                                              (eq! (prev LIMB) (* (+ int_short ACC_BYTESIZE)
                                                                  (^ 256 15)))
                                              (eq! (prev nBYTES) 1)
                                              (eq! LIMB (* input_lo P))
                                              (eq! nBYTES ACC_BYTESIZE))))
                                   (begin                                                    ;; 2.d.iv
                                    (did-change! (shift LC -2))
                                    (eq! (shift LIMB -2)
                                         (* (+ int_short LLARGE ACC_BYTESIZE)
                                            (^ 256 LLARGEMO)))
                                    (eq! (shift nBYTES -2) 1)
                                    (eq! (prev LIMB) (* input_hi P))
                                    (eq! (prev nBYTES) ACC_BYTESIZE)
                                    (eq! LIMB input_lo)
                                    (eq! nBYTES LLARGE))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.3 RLP of a 20 bytes address  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (rlpAddressConstraints input_hi input_lo ct)
    (if-eq-else number_step 1
                 (begin   ;; 1
                  (eq! LIMB (* int_short (^ 256 LLARGEMO)))
                  (eq! nBYTES 1))
                 (begin   ;; 2
                  (eq! number_step 16)
                  (if-eq DONE 1
                         (begin
                          (eq! [ACC 1] input_hi)
                          (vanishes! (shift [ACC 1] -4))
                          (eq! [ACC 2] input_lo)
                          (did-change! (shift LC -2))
                          (eq! (shift LIMB -2)
                               (* (+ int_short 20)
                                  (^ 256 LLARGEMO)))
                          (eq! (shift nBYTES -2)
                               1)
                          (eq! (prev LIMB)
                               (* input_hi (^ 256 12)))
                          (eq! (prev nBYTES)
                               4)
                          (eq! LIMB input_lo)
                          (eq! nBYTES LLARGE))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.3 RLP of a 32 bytes STorage Key  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (rlpStorageKeyConstraints input_hi input_lo ct)
    (begin
     (eq! number_step LLARGE)
     (if-eq DONE 1
            (begin
             (eq! [ACC 1] input_hi)
             (eq! [ACC 2] input_lo)
             (did-change! (shift LC -2))
             (eq! (shift LIMB -2)
                  (* (+ int_short 32)
                     (^ 256 LLARGEMO)))
             (eq! (shift nBYTES -2) 1)
             (eq! (prev LIMB) input_hi)
             (eq! (prev nBYTES) LLARGE)
             (eq! LIMB input_lo)
             (eq! nBYTES LLARGE)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.4 Byte counting constraints  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (ByteCountingConstraints k base_offset)
    (if-zero CT
             (if-zero [ACC k]
                      (begin                      ;; 1.a
                       (vanishes! ACC_BYTESIZE)
                       (eq! P (^ 256 (+ base_offset 1))))
                      (begin                                          ;; 1.b
                       (eq! ACC_BYTESIZE 1)
                       (eq! P (^ 256 base_offset))))
             (if-zero [ACC k]                                 ;; 2
                      (begin (vanishes! ACC_BYTESIZE)                    ;; 2.a.i
                             (eq! P (* 256 (prev P))))   ;; 2.a.ii
                      (begin (did-inc! ACC_BYTESIZE 1)                    ;; 2.b.i
                             (remained-constant! P)))))                      ;;2.b.ii

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4 Phase Heartbeat  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.1 Phase 0 : RLP prefix  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint phase0-1 (:guard [PHASE 0])   ;; 4.1.1
  (if-zero (prev [PHASE 0])
           (begin
            (eq! number_step 1)
            (vanishes! (+ (- 1 LT)           ;;1.b
                          (- 1 LX)           ;;1.c
                          end_phase           ;;1.d
                          (- 1 (next LT))           ;;1.g
                          (next LX)))           ;;1.h
            (if-zero TYPE
                     (eq! is_padding 1)                  ;; 1.e
                     (begin                                    ;;1.f
                      (vanishes! is_padding)
                      (eq! LIMB (* TYPE (^ 256 LLARGEMO)))
                      (eq! nBYTES 1)))
            (eq! DATA_LO TYPE))))

(defconstraint phase0-2 (:guard [PHASE 0])   ;; 4.1.2
  (if-zero (+ (- 1 LT)
              LX)
           (begin
            (vanishes! (+ is_padding                      ;; 2.a
                          end_phase                     ;; 2.b
                          (- 1 is_bytesize)                     ;; 2.c
                          (- 1 is_list)))                     ;; 2.c
            (eq! [INPUT 1] RLP_LT_BYTESIZE)            ;; 2.c
            (eq! number_step 8)
            (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list)
            (if-eq DONE 1                             ;; 2.d
                   (vanishes! (+ (next LT)
                                 (- 1 (next LX))))))))

(defconstraint phase0-3 (:guard [PHASE 0])   ;; 4.1.3
  (if-zero (+ LT
              (- 1 LX))
           (begin
            (vanishes! (+ is_padding                           ;; 3.a
                          (- 1 is_bytesize)                    ;; 3.b
                          (- 1 is_list)))                    ;; 3.b
            (eq! [INPUT 1] RLP_LX_BYTESIZE)            ;; 3.b
            (eq! number_step 8)
            (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list)
            (if-eq DONE 1                      ;; 3.c
                   (eq! end_phase 1)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.2 Phase 1, 2, 3, 4, 5 , 6 , 8 , 12 : RLP(integer))  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint phaseinteger (:guard (+ (reduce + (for i [1 : 6] [PHASE i]))
                                       [PHASE 8]
                                       [PHASE 12]))
  (begin
   (if-zero [INPUT 1]
            (eq! number_step 1)
            (eq! number_step
                 (+ (* 8 (+ (reduce + (for i [1 : 6] [PHASE i]))
                            [PHASE 12]))
                    (* 12 [PHASE 8]))))
   (vanishes! (+ is_bytesize is_list))
   (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list)
   (if-eq DONE 1
          (begin
           (eq! end_phase 1)
           (if-eq (+ [PHASE 2] [PHASE 3] [PHASE 5] [PHASE 6] [PHASE 8]) 1
            (eq! DATA_LO [INPUT 1]))
           (if-eq [PHASE 4] 1
            (eq! (next DATA_HI) [INPUT 1]))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.3 Phase 7 : Address  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint phase7 (:guard [PHASE 7])
  (begin
   (rlpAddressConstraints [INPUT 1] [INPUT 2] CT)
   (if-eq DONE 1
          (begin
           (eq! end_phase 1)
           (eq! DATA_HI [INPUT 1])
           (eq! DATA_LO [INPUT 2])
           (if-eq-else number_step 1
            (eq! (next DATA_HI) 1)
            (vanishes! (next DATA_HI)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.4 Phase 9 : Data  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 4.4.2.1 & 4.4.2.2
(defconstraint phase9-1-2 (:guard [PHASE 9])
  (if-eq-else is_prefix 1
    (vanishes! INDEX_DATA)
    (if-zero (+ (prev is_prefix)
                (* (- 1 (prev LC))
                   (- 1 (prev is_padding))))
      (did-inc! INDEX_DATA 1)
      (remained-constant! INDEX_DATA))))

;; 4.4.2.3
(defconstraint phase9-3 (:guard [PHASE 9])
  (if-zero is_padding
           (vanishes! end_phase)))

;; 4.4.2.4
(defconstraint phase9-4 (:guard [PHASE 9])
  (if-zero (+ is_prefix
              (- 1 is_padding)
              (- 1 DONE))
           (eq! end_phase 1)))

;; 4.4.2.5
(defconstraint phase9-5 (:guard [PHASE 9])
  (if-zero (prev [PHASE 9])
          (begin
           (if-zero PHASE_BYTESIZE
                    (eq! number_step 1)
                    (eq! number_step 8))
           (eq! DATA_HI DATAGASCOST)
           (eq! DATA_LO PHASE_BYTESIZE))))

;; 4.4.2.6
(defconstraint phase9-6 (:guard [PHASE 9])
  (if-zero (+ number_step
              (prev [PHASE 9]))
           (begin
            (eq! [INPUT 1] PHASE_BYTESIZE)
            (vanishes! (+ (- 1 is_bytesize)  
                          is_list        
                          (- 1 (+ is_prefix (next is_prefix)))
                          is_padding
                          (- 1 (next is_padding))))
            (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list)
            (eq! (next number_step) 1))))        
            

;; 4.4.2.7
(defconstraint phase9-7 (:guard [PHASE 9])
  (if-not-zero (- 1 number_step)
           ;; 7.a
           (begin
            (if-zero (prev [PHASE 9])
                     (eq! is_prefix 1))
            ;; 7.b
            (if-eq is_prefix 1
                    (begin
                     (eq! number_step 8)
                     (vanishes! is_list)
                     (will-remain-constant! PHASE_BYTESIZE)
                     (will-remain-constant! DATAGASCOST)
                     (if-eq-else PHASE_BYTESIZE 1
                            (if-eq DONE 1
                                    (begin
                                      (eq! (next [INPUT 1])
                                           (* [INPUT 1]
                                              (^ 256 15)))
                                      (eq! BIT_ACC [BYTE 1]) 
                                      (eq! [ACC 1] [INPUT 1])
                                      (vanishes! (prev LC))
                                      (if-zero (shift BIT -7)
                                              (eq! is_padding 1)
                                              (begin 
                                                (vanishes! is_padding)
                                                (eq! LIMB (* (+ int_short 1)
                                                             (^ 256 LLARGEMO)))
                                                (eq! nBYTES 1)))))
                            (begin 
                              (vanishes! (+ is_padding
                                            (- 1 is_bytesize)))
                              (eq! [INPUT 1] PHASE_BYTESIZE)
                              (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list)))))
            ;; 7.c
            (if-zero (+ is_prefix is_padding)
                     (begin
                      (eq! number_step LLARGE)  ;; 7.c.i
                      (if-not-zero PHASE_BYTESIZE
                                   (begin                                                  ;; 7.c.ii
                                    (will-dec! PHASE_BYTESIZE 1)                                           ;;7.c.ii.A
                                    (if-zero [BYTE 1]
                                             (will-dec! DATAGASCOST G_txdatazero)                   ;;7.c.ii.B
                                             (will-dec! DATAGASCOST G_txdatanonzero)))                      ;;7.c.ii.C
                                   (begin                                    ;; 7.c.iii
                                    (will-remain-constant! PHASE_BYTESIZE)             ;; 7.c.iii.A
                                    (will-remain-constant! DATAGASCOST)))                 ;; 7.c.iii.B
                      (if-zero CT
                               (eq! ACC_BYTESIZE 1)                ;; 7.c.iv
                               (if-not-zero PHASE_BYTESIZE
                                            (did-inc! ACC_BYTESIZE 1) ;; 7.c.v.A
                                            (begin                      ;; 7.c.v.B
                                             (remained-constant! ACC_BYTESIZE)
                                             (vanishes! [BYTE 1]))))
                      (if-eq DONE 1                                    ;; 7.c.vi
                             (begin
                              (vanishes! (prev LC))        ;; 7.c.vi.A
                              (eq! [ACC 1] [INPUT 1])        ;; 7.c.vi.B
                              (eq! LIMB [INPUT 1])        ;; 7.c.vi.C
                              (eq! nBYTES ACC_BYTESIZE)         ;; 7.c.vi.D
                              (if-eq-else (^ PHASE_BYTESIZE 2) PHASE_BYTESIZE
                                          (begin                             ;; 7.c.vi.E
                                           (eq! (next number_step) 2)
                                           (vanishes! (+ is_padding
                                                         (- 1 (next is_padding))
                                                         (- 1 (shift is_padding 2))))
                                           (vanishes! (+ (next LIMB)
                                                         (shift LIMB 2)))
                                           (eq! (next PHASE_BYTESIZE)
                                                (shift PHASE_BYTESIZE 2))
                                           (eq! (next DATAGASCOST)
                                                (shift DATAGASCOST 2)))
                                          (vanishes! (next is_padding))))))))))   ;; 7.c.vi.F

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.5 Phase 10 : AccessList  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint phase10-1 (:guard [PHASE 10])   ;; 4.5.2.1
  (if-not-zero PHASE_BYTESIZE (vanishes! end_phase)))

(defconstraint phase10-2 (:guard [PHASE 10])  ;; 4.5.2.2
  (if-zero (+ PHASE_BYTESIZE
              DONE)
           (eq! end_phase 1)))

;; 4.5.2.3
(defconstraint phase10-3-4 (:guard [PHASE 10])
  (if-zero (prev [PHASE 10])
          (begin
           (eq! DATA_HI nb_Sto)
           (eq! DATA_LO nb_Addr)
           (if-zero nb_Addr
                    (begin                      ;; 3.a
                     (eq! [INPUT 1] PHASE_BYTESIZE)
                     (eq! number_step 1)
                     (vanishes! (+ (- 1 is_bytesize)
                                   (- 1 is_list)))
                     (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list))
                    (begin                      ;; 3.b
                     (vanishes! (+ (- 1 is_prefix)            ;; 3.b.i
                                   [DEPTH 1]              ;; 3.b.ii
                                   [DEPTH 2]              ;; 3.b.iii
                                   (- 1 is_bytesize)
                                   (- 1 is_list)))
                     (eq! [INPUT 1] PHASE_BYTESIZE)            ;; 3.b.iv
                     (eq! number_step 8)
                     (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list)
                     (if-eq DONE 1               ;; 3.b.v
                            (vanishes! (+ (- 1 (next is_prefix))
                                          (- 1 (next [DEPTH 1]))
                                          (next [DEPTH 2])))))))))

(defconstraint phase10-5 (:guard [PHASE 10])   ;; 4.5.2.4
  (if-zero (+ (- 1 is_prefix)
              (- 1 [DEPTH 1])
              [DEPTH 2])
           (begin               ;; 4.a
            (eq! [INPUT 1] ACCESS_TUPLE_BYTESIZE)
            (eq! number_step 8)
            (vanishes! (+ (- 1 is_bytesize)
                          (- 1 is_list)))
            (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list)
            (if-eq DONE 1               ;;4.b
                   (vanishes! (+ (next is_prefix)
                                 (- 1 (next [DEPTH 1]))
                                 (next [DEPTH 2])))))))

(defconstraint phase10-6 (:guard [PHASE 10])   ;; 4.5.2.5
  (if-zero (+ is_prefix
              (- 1 [DEPTH 1])
              [DEPTH 2])
           (begin
            (eq! [INPUT 1] ADDR_HI)     ;; 5.a
            (eq! [INPUT 2] ADDR_LO)
            (eq! number_step 16)
            (rlpAddressConstraints [INPUT 1] [INPUT 2] CT)
            (if-eq DONE 1               ;; 5.b
                   (eq! 3
                        (+ (next is_prefix)
                           (next [DEPTH 1])
                           (next [DEPTH 2])))))))

(defconstraint phase10-7 (:guard  [PHASE 10])   ;; 4.5.2.6
  (if-eq 3 (+ is_prefix
              [DEPTH 1]
              [DEPTH 2])
         (begin
          (if-zero nb_Sto_per_Addr
                   (eq! number_step 1)            ;;6.a
                   (eq! number_step 8))
          (eq! [INPUT 1] (* 33 nb_Sto_per_Addr))          ;; 6.c
          (eq! 2 (+ is_bytesize is_list))
          (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list))))

(defconstraint phase10-8 (:guard  [PHASE 10])   ;; 4.5.2.7
  (if-zero (+ is_prefix
              (- 1 [DEPTH 1])
              (- 1 [DEPTH 2]))
           (rlpStorageKeyConstraints [INPUT 1] [INPUT 2] CT)))

(defconstraint phase10-9 (:guard  [PHASE 10])   ;; 4.5.2.8
  (if-zero (+ (- 1 [DEPTH 2])
              (- 1 DONE))
           (if-not-zero nb_Sto_per_Addr
                        (vanishes! (+ (next is_prefix)                 ;; 8.a
                                      (- 1 (next [DEPTH 1]))
                                      (- 1 (next [DEPTH 2]))))
                        (begin                                    ;; 8.b
                         (vanishes! ACCESS_TUPLE_BYTESIZE)              ;; 8.b.i
                         (if-not-zero nb_Addr              ;; 8.b.ii
                                      (vanishes! (+ (- 1 (next is_prefix))
                                                    (- 1 (next [DEPTH 1]))
                                                    (next [DEPTH 2]))))))))

(defconstraint phase10-10to14 (:guard  [PHASE 10])   
  (if-zero [DEPTH 1]
               (will-remain-constant! PHASE_BYTESIZE)
               (begin
                (did-dec! PHASE_BYTESIZE (* LC nBYTES)) ;;10
                (if-zero (* is_prefix              ;;11
                            (- 1 [DEPTH 2]))
                         (did-dec! ACCESS_TUPLE_BYTESIZE (* LC nBYTES)))
                (if-zero CT
                         (begin
                          (did-dec! nb_Addr (* is_prefix                         ;; 12
                                               (- 1 [DEPTH 2])))
                          (did-dec! nb_Sto (* (- 1 is_prefix)                        ;; 13
                                              [DEPTH 2])))))))

;; 4.5.2.14
(defconstraint phase10-15 (:guard  [PHASE 10])
  (if-zero (+ CT
              (* is_prefix (- 1 [DEPTH 2])))
           (did-dec! nb_Sto_per_Addr (* (- 1 is_prefix) [DEPTH 2]))))


;; 4.5.2.15
(defconstraint phase10-16 (:guard  [PHASE 10])
  (if-zero (+ [DEPTH 2]
              (- nb_Addr
                 (prev nb_Addr)))
           (begin
            (remained-constant! ADDR_HI)
            (remained-constant! ADDR_LO))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.6 Phase 11 : Beta / w  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint phase11-1 (:guard  [PHASE 11])   ;; 4.6.1
  (if-zero (prev [PHASE 11])
           (begin
            (vanishes! (+ (- 1 LT)
                          LX
                          is_bytesize
                          is_list))
            (eq! number_step 8)
            (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list)
            (if-eq DONE 1
                   (vanishes! (+ is_padding
                                 end_phase
                                 (next LT)
                                 (- 1 (next LX))))))))

(defconstraint phase11-2 (:guard  [PHASE 11])   ;; 4.6.2
  (if-zero (+ (prev LX)
              (- 1 LX))
           (if-eq-else (^ (- [INPUT 1] 27) 2) (- [INPUT 1] 27)
                        (begin 
                         (eq! number_step 1)
                         (eq! 2                                     ;; 2.a
                            (+ is_padding
                               end_phase)))
                       (begin                      ;; 2.b
                        (eq! number_step 8)
                        (eq! 0 (+ is_bytesize is_list))
                        (rlpPrefixConstraints [INPUT 1] CT number_step is_bytesize is_list)
                        (if-eq DONE 1                      ;; 2.b.i
                               (begin
                                (vanishes! (+ is_padding
                                              end_phase
                                              (next LT)
                                              (- 1 (next LX))
                                              (next is_padding)
                                              (- 1 (next end_phase))))
                                (eq! (next number_step) 1)
                                (eq! (next LIMB)
                                     (+ (* int_short (^ 256 LLARGEMO))
                                        (* int_short (^ 256 14))))
                                (eq! (next nBYTES) 2)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.7 Phase 13-14 : r & s  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint phase13_14 (:guard (+ [PHASE 13] [PHASE 14]))   ;; 4.7
  (begin
   (if-zero (+ (~ [INPUT 1]) (~ [INPUT 2]))
            (eq! number_step 1)   ;; 1
            (eq! number_step 16)) ;; 2 & 3
   (rlp32bytesIntegerConstraints [INPUT 1] [INPUT 2] number_step CT) ;; 4
   (if-eq DONE 1   ;; 5
          (eq! end_phase 1))))
