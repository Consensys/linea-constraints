(module tx_rlp)

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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.1 Constancy columns  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Definition counter-incrementing.
(defpurefun (counter-incrementing CT C)
  (if-not-zero CT
               (either (didnt-change C)
                       (did-inc C 1))))

;; Definition phase-constancy.
(defpurefun (phase-constancy PHASE C)
  (if-eq (* PHASE (prev PHASE)) 1
           (didnt-change C)))

;; Definition phase-incrementing
(defpurefun (phase-incrementing PHASE C)
  (if-eq (* PHASE (prev PHASE)) 1
           (either (didnt-change C)
                   (did-inc C 1))))

;; Definition phase-decrementing
(defpurefun (phase-decrementing PHASE C)
  (if-eq (* PHASE (prev PHASE)) 1
           (either (didnt-change C)
                       (did-inc C 1))))

;; 2.3.1.1
(defconstraint stamp-constancies ()
   (stamp-constancy ABS_TX_NUM TYPE))

;; 2.3.1.2
(defconstraint counter-constancy ()
  (begin
   (counter-constancy CT [INPUT 1])
   (counter-constancy CT [INPUT 2])
   (counter-constancy CT OLI)
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

;; 2.3.1.4
(defconstraint phase9-constancy ()
   (phase-constancy [PHASE 9] OLI))

;; 2.3.1.5
(defconstraint phase0-constancy ()
  (begin
   (phase-constancy [PHASE 0] RLP_LT_BYTESIZE)
   (phase-constancy [PHASE 0] RLP_LX_BYTESIZE)))

;; 2.3.1.6
(defconstraint phase9-decrementing ()
   (phase-decrementing [PHASE 9] is_prefix))

;; 2.3.1.7 (debug 2.3.1.11)
(defconstraint phase9-incrementing ()
   (begin 
   (phase-incrementing [PHASE 9] is_padding)
   (debug (phase-incrementing [PHASE 9] INDEX_DATA))))

;; 2.3.1.8
(defconstraint phase0-decrementing()
       (debug (phase-decrementing [PHASE 0] is_padding)))

;; 2.3.1.9
;; with 2.3.1.3

;; 2.3.1.10
(defconstraint phasek-incrementing ()
       (for k [0:14] (debug(phase-incrementing [PHASE k] end_phase))))

;; 2.3.1.11
;; with 2.3.1.7

;; 2.3.1.12
;; todo if useful

;; 2.3.1.13
;; todo if useful

;; 2.3.1.14
;; todo if useful

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.2 Global Phase Constraints  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.3.2.1
(defconstraint initial-stamp (:domain {0})
  (vanishes ABS_TX_NUM))

;; 2.3.2.2
(defconstraint ABS_TX_NUM-is-zero ()
  (if-zero ABS_TX_NUM
           (vanishes (reduce + (for i [0 : 14] [PHASE i])))))

;; 2.3.2.3
(defconstraint ABS_TX_NUM-is-nonzero ()
  (if-not-zero ABS_TX_NUM
               (eq 1 (reduce + (for i [0 : 14] [PHASE i])))))

;; 2.3.2.4
(defconstraint ABS_TX_NUM-evolution()
  (eq
       ABS_TX_NUM
       (+ (prev ABS_TX_NUM) 
          (* [PHASE 0] (didnt-change [PHASE 0])))))

;; 2.3.2.5
(defconstraint LT-and-LX()
  (if-eq (reduce + (for i [1 : 10] [PHASE i])) 1
              (eq (+ LT LX) 2)))

;; 2.3.2.6
(defconstraint LT-only()
  (if-eq (reduce + (for i [12 : 14] [PHASE i])) 1
              (eq 1 (+ LT (* 2 LX)))))

;; 2.3.2.7
(defconstraint no-done-no-end ()
  (if-zero DONE
           (vanishes end_phase)))

;; 2.3.2.8
(defconstraint no-end-no-changephase ()
  (if-zero end_phase
       (reduce + (for i [0 : 14] 
              (* i  
                 (- (next [PHASE i]) [PHASE i]))))))


;; 2.3.2.8
(defconstraint phase-transition ()
  (if-eq end_phase 1
       (begin
       (if-eq [PHASE 0] 1
              (if-zero TYPE
                     (eq (next [PHASE 2]) 1)
                     (eq (next [PHASE 1]) 1)))
       (if-eq [PHASE 1] 1
              (eq (next [PHASE 2]) 1))
       (if-eq [PHASE 2] 1
              (if-eq-else TYPE 2
                     (eq (next [PHASE 4]) 1)
                     (eq (next [PHASE 3]) 1)))
       (if-eq [PHASE 3] 1
              (eq (next [PHASE 6]) 1))
       (if-eq [PHASE 4] 1
              (eq (next [PHASE 5]) 1))
       (if-eq [PHASE 5] 1
              (eq (next [PHASE 6]) 1))
       (if-eq [PHASE 6] 1
              (eq (next [PHASE 7]) 1))
       (if-eq [PHASE 7] 1
              (eq (next [PHASE 8]) 1))
       (if-eq [PHASE 8] 1
              (eq (next [PHASE 9]) 1))
       (if-eq [PHASE 9] 1
              (begin
              (debug (vanishes PHASE_BYTESIZE))
              (vanishes DATAGASCOST)
              (if-zero TYPE
                     (eq (next [PHASE 11]) 1)
                     (eq (next [PHASE 10]) 1))))
       (if-eq [PHASE 10] 1
              (begin
              (debug (vanishes PHASE_BYTESIZE))
              (vanishes nb_Addr)
              (vanishes nb_Sto)
              (vanishes nb_Sto_per_Addr)
              (eq (next [PHASE 12]) 1)))
       (if-eq [PHASE 11] 1
              (eq (next [PHASE 13]) 1))
       (if-eq [PHASE 12] 1
              (eq (next [PHASE 13]) 1))
       (if-eq [PHASE 13] 1
              (eq (next [PHASE 14]) 1))
       (if-eq [PHASE 14] 1
              (begin
              (vanishes RLP_LT_BYTESIZE)
              (vanishes RLP_LX_BYTESIZE)
              (eq (next [PHASE 0]) 1))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.3 Byte decomposition's loop heartbeat  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.3.3.1
(defconstraint oli-imply-step (:guard ABS_TX_NUM)
 (if-eq OLI 1
       (eq number_step 1)))

;; 2.3.3.2 & 2.3.3.3
(defconstraint cy-imply-done (:guard ABS_TX_NUM)
        (if-eq-else CT (- number_step 1)
              (eq DONE 1)
              (vanishes DONE)))

;; 2.3.3.4 & 2.3.3.5
(defconstraint done-imply-heartbeat (:guard ABS_TX_NUM)              
       (if-zero DONE
              (will-eq CT (+ CT 1))       
              (begin
              (eq LC (- 1 is_padding))
              (vanishes (next CT)))))

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
       (eq BIT_ACC BIT)
       (eq BIT_ACC (+ (* 2 (prev BIT_ACC)) BIT))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.5 Global Constraints  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.3.5.1 & 2.3.5.2
(defconstraint init-index()
 (if-zero (didnt-change ABS_TX_NUM)
       (begin
       (eq INDEX_LT 
           (+ (prev INDEX_LT) (* (prev LC) (prev LT))))
       (eq INDEX_LX 
           (+ (prev INDEX_LX) (* (prev LC) (prev LX)))))
       (begin
       (vanishes INDEX_LT)
       (vanishes INDEX_LX))))

;; 2.3.5.3 
(defconstraint rlpbytesize-decreasing()
 (if-eq 1 (reduce + (for i [1 : 14] [PHASE i]))
       (begin
       (eq RLP_LT_BYTESIZE
           (- (prev RLP_LT_BYTESIZE) (* LC LT nBYTES)))
       (eq RLP_LX_BYTESIZE
           (- (prev RLP_LX_BYTESIZE) (* LC LX nBYTES))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.6 Finalisation Constraints  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint finalisation (:domain {-1})
 (if-not-zero ABS_TX_NUM
       (eq 2
           (+ end_phase [PHASE 14]))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3 Constraints patterns  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The functiun defined in 3.1 to 3.4 write the output in LIMB, nBYTES, LC columns.
;; Functiun defined in 3.2 to 3.4 write the number of step of the byte decomposition loop in nb_step column.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.1 RLP prefix constraint of 1 Input  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (rlpPrefixConstraints input ct oli nbstep isbytesize islist)
 (if-not-zero oli
       (if-zero islist                                                                                          ;; 1
              (begin                                                                                            ;; 1.a 
              (eq LIMB (* int_short (^ 256 15)))
              (eq nBYTES 1))
              (begin                                                                                            ;;1.b
              (eq LIMB (* list_short (^ 256 15)))
              (eq nBYTES 1)))
       (begin
       (ByteCountingConstraints 1 (- 15 number_step))                  ;; 2.a
       (if-eq DONE 1                                                                                            ;; 2.b
              (begin
              (eq [ACC 1] input)                                                                                 ;; 2.b.i                                                        
              (eq BIT_ACC [BYTE 1])                                                                             ;;2.b.ii
              (eq [ACC 2]                                                                  ;; 2.b.iii
                  (- (* (- (* 2 COMP) 1) 
                        (- input 55))
                     COMP))
              (if-zero (and (vanishes isbytesize) 
                            (debug (vanishes islist)))                                            ;;2.b.iv
                     (begin
                     (if-zero (and (eq ACC_BYTESIZE 1) 
                                   (vanishes (shift BIT -7)))
                            (vanishes (prev LC))                                             ;;2.b.iv.A
                            (begin                                                                ;; 2.B.iv.B/C/D
                            (did-change (prev LC))
                            (eq (prev LIMB) 
                                (* (+ int_short ACC_BYTESIZE)
                                   (^ 256 15)))
                            (eq (prev nBYTES) 1)))
                     (eq LIMB (* input P))
                     (eq nBYTES 1)))       
              (if-zero (and (eq isbytesize 1) 
                            (vanishes islist))                    ;;2.b.v
                     (if-zero COMP
                            (begin                                                  ;; 2.b.v.A
                            (vanishes (prev LC))
                            (eq LIMB 
                                (* (+ int_short ACC_BYTESIZE)
                                   (^ 256 15)))
                            (eq nBYTES 1))
                            (begin                                                  ;; 2.b.v.B
                            (did-change (prev LC))
                            (eq (prev LIMB) (* (+ int_long ACC_BYTESIZE)
                                                (^ 256 15)))
                            (eq (prev nBYTES) 1)
                            (eq LIMB (* input P))
                            (eq nBYTES ACC_BYTESIZE))))       
              (if-zero (and (eq islist 1) 
                            (debug (vanishes isbytesize)))                    ;;2.b.vi
                     (if-zero COMP
                            (begin                                                  ;; 2.b.vi.A
                            (vanishes (prev LC))
                            (eq LIMB (* (+ list_short ACC_BYTESIZE)
                                                (^ 256 15)))
                            (eq nBYTES 1))
                            (begin                                                  ;; 2.b.vi.B
                            (did-change (prev LC))
                            (eq (prev LIMB) (* (+ list_long ACC_BYTESIZE)
                                                (^ 256 15)))
                            (eq (prev nBYTES) 1)
                            (eq LIMB (* input P))
                            (eq nBYTES ACC_BYTESIZE)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.2 RLP prefix constraint of a 32 bytes integer  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (rlp32bytesIntegerConstraints input_hi input_lo oli ct)
 (if-not-zero oli 
       (begin                                                                ;; 1
       (eq LIMB (* int_short (^ 256 15)))
       (eq nBYTES 1))
       (begin                                                                           ;; 2
       (eq number_step 16)
       (if-zero input_hi                                       
              (ByteCountingConstraints 2 0)                                         ;;2.b
              (ByteCountingConstraints 1 0))                                            ;;2.c
       (if-eq DONE 1                                                         ;;2.d
              (begin 
              (eq [ACC 1] input_hi)
              (eq [ACC 2] input_lo)
              (if-zero input_hi
                     (begin                                                  ;; 2.d.iii 
                     (did-change (prev LC))
                     (eq (prev LIMB) (* (+ int_short ACC_BYTESIZE)
                                                (^ 256 15)))
                     (eq (prev nBYTES) 1)
                     (eq LIMB (* input_lo P))
                     (eq nBYTES ACC_BYTESIZE))
                     (begin                                                    ;; 2.d.iv 
                     (did-change (shift LC -2))
                     (eq (shift LIMB -2) 
                         (* (+ int_short LLARGE ACC_BYTESIZE)
                            (^ 256 15)))
                     (eq (shift nBYTES -2) 1)
                     (eq (prev LIMB) (* input_hi P))
                     (eq (prev nBYTES) ACC_BYTESIZE)
                     (eq LIMB input_lo)
                     (eq nBYTES LLARGE))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.3 RLP of a 20 bytes address  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (rlpAddressConstraints input_hi input_lo oli ct)
 (if-not-zero oli
       (begin   ;; 1
       (eq LIMB (* int_short (^ 256 LLARGEMO)))
       (eq nBYTES 1))
       (begin   ;; 2
       (eq number_step 16)
       (if-eq DONE 1
              (begin
              (eq [ACC 1] input_hi)
              (vanishes (shift [ACC 1] -4))
              (eq [ACC 2] input_lo)
              (did-change (prev LC))
              (eq (prev LIMB)
                  (+ (* (+ int_short 20) (^ 256 LLARGEMO))
                     (* input_hi (^ 256 11))))
              (eq (prev nBYTES) 5)
              (eq LIMB input_lo)
              (eq nBYTES LLARGE))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.3 RLP of a 32 bytes STorage Key  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (rlpStorageKeyConstraints input_hi input_lo ct)
 (begin
 (vanishes OLI)
 (eq number_step LLARGE)
 (if-eq DONE 1
       (begin
       (eq [ACC 1] input_hi)
       (eq [ACC 2] input_lo)
       (did-change (shift LC -2))
       (eq (shift LIMB -2)
           (* (+ int_short 32)
              (^ 256 LLARGEMO)))
       (eq (shift nBYTES -2) 1)
       (eq (prev LIMB) input_hi)
       (eq (prev nBYTES) LLARGE)
       (eq LIMB input_lo)
       (eq nBYTES LLARGE)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.4 Byte counting constraintsy  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (ByteCountingConstraints k base_offset)
(if-zero CT
       (begin                                           ;; 1
       (if-zero [ACC k]
              (vanishes ACC_BYTESIZE)                    ;; 1.a
              (eq ACC_BYTESIZE 1))                      ;; 1.b
       (eq P (^ 256 base_offset)))                             ;; 1.c
       (if-zero [ACC k]                                 ;; 2
              (begin
              (vanishes ACC_BYTESIZE)                    ;; 2.a.i
              (eq P                                       ;; 2.a.ii
                  (* 256 (prev P))))
              (begin 
              (did-inc ACC_BYTESIZE 1)                    ;; 2.b.i
              (didnt-change ACC_BYTESIZE)))))                      ;;2.b.ii

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

(defconstraint phase0-1 (:guard (eq [PHASE 0] 1))   ;; 4.1.1
 (if-zero (prev [PHASE 0])
       (begin
       (eq 23 (+ OLI                 ;;1.a
                 (* 2 LT)           ;;1.b
                 (* 4 LX)           ;;1.c
                 (* 8 end_phase)           ;;1.d
                 (* 16 (next LT))           ;;1.g
                 (* 32 (next LX))))           ;;1.h
       (if-zero TYPE                      
              (eq is_padding 1)                  ;; 1.e
              (begin                                    ;;1.f
              (vanishes is_padding)
              (eq LIMB (* TYPE (^ 256 LLARGEMO)))
              (eq nBYTES 1))))))

(defconstraint phase0-2 (:guard (eq [PHASE 0] 1))   ;; 4.1.2
 (if-zero (+ (- 1 LT)
             LX)
       (begin
       (eq 12 (+ is_padding                      ;; 2.a
                 (* 2 end_phase)                     ;; 2.b
                 (* 4 is_bytesize)                     ;; 2.c
                 (* 8 is_list)))                     ;; 2.c
       (eq [INPUT 1] RLP_LT_BYTESIZE)            ;; 2.c
       (eq number_step 8)
       (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list)
       (if-eq DONE 1                             ;; 2.d
              (eq 2 (+ (next LT)
                       (* 2 (next LX))))))))

(defconstraint phase0-3 (:guard (eq [PHASE 0] 1))   ;; 4.1.3
 (if-zero (and (vanishes LT) (eq LX 1))
       (begin
       (eq 6 (+ is_padding                           ;; 3.a
                (* 2 is_bytesize)                    ;; 3.b
                (* 4 is_list)))                    ;; 3.b
       (eq [INPUT 1] RLP_LX_BYTESIZE)            ;; 3.b
       (eq number_step 8)
       (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list)
       (if-eq DONE 1                      ;; 3.c
              (eq end_phase 1)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.2 Phase 1, 2, 3, 4, 5 , 6 , 8 , 12 : RLP(integer))  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint phaseinteger (:guard (eq 1
                                        (+ (reduce + (for i [1 : 6] [PHASE i]))
                                           [PHASE 8]
                                           [PHASE 12])))
 (begin
 (eq number_step                                        ;; 1
     (+ (* 8 (+ (reduce + (for i [1 : 6] [PHASE i]))
                [PHASE 12]))
        (* 12 [PHASE 8])))
 (vanishes (+ is_bytesize is_list))
 (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list)
 (if-eq DONE 1                                          ;; 2
       (eq end_phase 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.3 Phase 7 : Address  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint phase7 (:guard (eq 1 [PHASE 7]))
 (begin
 (rlpAddressConstraints [INPUT 1] [INPUT 2] OLI CT)
 (if-eq DONE 1
       (eq end_phase 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.4 Phase 9 : Data  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint phase9-1 (:guard (eq 1 [PHASE 9]))   ;; 4.4.2.1
 (if-eq is_prefix 1
       (begin
       (vanishes INDEX_DATA)
       (vanishes (next INDEX_DATA)))))

(defconstraint phase9-2 (:guard (eq 1 [PHASE 9]))   ;; 4.4.2.2
 (if-zero (prev is_prefix)
       (begin
       (if-eq (prev LC) 1                               ;; 2.a
              (eq INDEX_DATA 
                  (+ (prev INDEX_DATA) 1)))
       (if-eq (prev is_padding) 1                             ;; 2.b
              (eq INDEX_DATA 
                  (+ (prev INDEX_DATA) 1))))))

(defconstraint phase9-3 (:guard (eq 1 [PHASE 9]))   ;; 4.4.2.3
 (if-zero is_padding
       (vanishes end_phase)))

(defconstraint phase9-4 (:guard (eq 1 [PHASE 9]))   ;; 4.4.2.4
 (if-zero (and (eq is_padding 1) (eq DONE 1))
       (eq end_phase 1)))

(defconstraint phase9-5 (:guard (eq 1 [PHASE 9]))   ;; 4.4.2.5
 (if-zero (prev [PHASE 9])
       (if-zero PHASE_BYTESIZE
              (eq OLI 1)
              (vanishes OLI))))

(defconstraint phase9-6 (:guard (eq 1 [PHASE 9]))   ;; 4.4.2.6
 (if-zero (and (eq OLI 1) (vanishes (prev [PHASE 9])))
       (begin
       (eq [INPUT 1] PHASE_BYTESIZE)
       (eq 5 (+ is_bytesize        ;; 6.a
                (* 2 is_list)        ;; 6.a
                (* 4 (+ is_padding (next is_padding)))))  ;; 6.b
       (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list)        ;; 6.a
       (vanishes (next LIMB))        ;; 6.c
       (debug (eq end_phase 1)))))

(defconstraint phase9-7 (:guard (eq 1 [PHASE 9]))   ;; 4.4.2.7
 (if-zero OLI
       (begin
       (if-zero (prev [PHASE 9])                 ;; 7.a
              (eq 1 (+ is_prefix
                       (* 2 is_padding))))
       (if-eq is_prefix 1                             ;; 7.b
              (begin
              (eq [INPUT 1] PHASE_BYTESIZE)             ;; 7.b.i
              (eq number_step 8)
              (eq 1 (+ is_bytesize
                       (* 2 is_list)))
              (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list)
              (remains-constant PHASE_BYTESIZE)   ;; 7.b.ii 
              (remains-constant DATAGASCOST)               ;; 7.b.iii
              (if-eq DONE 1                                    ;; 7.b.iv
                     (vanishes (+ (next is_prefix) (next is_padding))))))      
              (if-zero (and (vanishes is_prefix) (vanishes is_padding))             ;; 7.c
                     (begin
                     (eq number_step LLARGE)  ;; 7.c.i
                     (if-not-zero PHASE_BYTESIZE
                            (begin                                                  ;; 7.c.ii
                            (dec PHASE_BYTESIZE 1)                                           ;;7.c.ii.A
                            (if-zero [BYTE 1]
                                   (dec DATAGASCOST G_txdatazero)                   ;;7.c.ii.B
                                   (dec DATAGASCOST G_txdatanonzero)))                      ;;7.c.ii.C
                            (begin                                    ;; 7.c.iii
                            (remains-constant PHASE_BYTESIZE)             ;; 7.c.iii.A
                            (remains-constant DATAGASCOST)))                 ;; 7.c.iii.B
                     (if-zero CT
                            (eq ACC_BYTESIZE 1)                ;; 7.c.iv
                            (if-not-zero PHASE_BYTESIZE
                                   (did-inc ACC_BYTESIZE 1) ;; 7.c.v.A
                                   (begin                      ;; 7.c.v.B
                                   (remains-constant ACC_BYTESIZE)
                                   (vanishes [BYTE 1]))))
                     (if-eq DONE 1                                    ;; 7.c.vi
                            (begin
                            (vanishes (prev LC))        ;; 7.c.vi.A
                            (eq [ACC 1] [INPUT 1])        ;; 7.c.vi.B
                            (eq LIMB [INPUT 1])        ;; 7.c.vi.C
                            (eq nBYTES ACC_BYTESIZE)         ;; 7.c.vi.D
                            (if-eq (^ 2 PHASE_BYTESIZE) PHASE_BYTESIZE
                                   (begin                             ;; 7.c.vi.E
                                   (eq (next number_step) 2)
                                   (eq (+ is_padding (next is_padding)) 1)
                                   (vanishes (+ (next LIMB) (shift LIMB 2)))
                                   (eq (next PHASE_BYTESIZE) (shift PHASE_BYTESIZE 2))
                                   (eq (next DATAGASCOST) (shift DATAGASCOST 2))
                                   (vanishes (next is_padding)))))))))))     ;; 7.c.vi.F       

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.5 Phase 10 : AccessList  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint phase10-1 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.1
 (if-not-zero PHASE_BYTESIZE (vanishes end_phase)))

(defconstraint phase10-2 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.2
 (if-zero (and (vanishes PHASE_BYTESIZE) (eq DONE 1)) 
       (eq end_phase 1)))

(defconstraint phase10-3 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.3
 (if-zero (prev [PHASE 10])
       (if-zero nb_Addr
              (begin                      ;; 3.a
              (eq [INPUT 1] PHASE_BYTESIZE)
              (eq 7 (+ OLI
                       (* 2 is_bytesize)
                       (* 4 is_list)))
              (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list))
              (begin                      ;; 3.b
              (eq 25 (+ is_prefix            ;; 3.b.i
                        (* 2 [DEPTH 1])              ;; 3.b.ii
                        (* 4 [DEPTH 2])              ;; 3.b.iii
                        (* 8 is_bytesize)
                        (* 16 is_list)))
              (eq [INPUT 1] PHASE_BYTESIZE)            ;; 3.b.iv
              (eq number_step 8)
              (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list)
              (if-eq DONE 1               ;; 3.b.v
                     (eq 3 (+ (next is_prefix)
                              (* 2 (next [DEPTH 1]))
                              (* 4 (next [DEPTH 2])))))))))

(defconstraint phase10-4 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.4
 (if-zero (and (eq is_prefix 1)
               (eq [DEPTH 1] 1)
               (vanishes [DEPTH 2]))
       (begin               ;; 4.a
       (eq [INPUT 1] AL_item_BYTESIZE)
       (eq number_step 8)
       (eq 3 (+ is_bytesize
                (* 2 is_list)))
       (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list)
       (if-eq DONE 1               ;;4.b
              (eq 2 (+ (next is_prefix)
                       (* 2 (next [DEPTH 1]))
                       (* 4 (next [DEPTH 2]))))))))

(defconstraint phase10-5 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.5
 (if-zero (and (vanishes is_prefix)
               (eq [DEPTH 1] 1)
               (vanishes [DEPTH 2]))
       (begin
       (eq [INPUT 1] ADDR_HI)     ;; 5.a
       (eq [INPUT 2] ADDR_LO)
       (vanishes OLI)
       (rlpAddressConstraints [INPUT 1] [INPUT 2] OLI CT)
       (if-eq DONE 1               ;; 5.b
              (eq 3
                  (+ (next is_prefix) 
                     (next [DEPTH 1]) 
                     (next [DEPTH 2])))))))

(defconstraint phase10-6 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.6
 (if-eq 3 (+ is_prefix [DEPTH 1] [DEPTH 2])
       (begin
       (if-zero nb_Sto_per_Addr
              (eq (* OLI number_step) 1)            ;;6.a
              (begin            ;;6.b
              (vanishes OLI)
              (eq number_step 8)))
       (eq [INPUT 1] (* 33 nb_Sto_per_Addr))          ;; 6.c
       (eq 2 (+ is_bytesize is_list))
       (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list))))

(defconstraint phase10-7 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.7
 (if-zero (and (vanishes is_prefix)
               (eq [DEPTH 1] 1)
               (eq [DEPTH 2] 1))
       (rlpStorageKeyConstraints [INPUT 1] [INPUT 2] CT)))

(defconstraint phase10-8 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.8
 (if-zero (+ (- 1 [DEPTH 2]) 
             (- 1 DONE))
       (if-not-zero nb_Sto_per_Addr
              (eq 6 
                  (+ (next is_prefix)                 ;; 8.a
                     (* 2 (next [DEPTH 1]))
                     (* 4 (next [DEPTH 2]))))
              (begin                                    ;; 8.b
              (vanishes AL_item_BYTESIZE)              ;; 8.b.i
              (if-not-zero nb_Addr              ;; 8.b.ii
                     (eq 3 
                         (+ (next is_prefix)
                            (* 2 (next [DEPTH 1]))
                            (* 4 (next [DEPTH 2])))))))))

(defconstraint phase10-9to13 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.9 to 4.5.2.13 
 (if-zero [DEPTH 1] 
       (remains-constant PHASE_BYTESIZE)  ;; 9
       (begin
       (did-dec PHASE_BYTESIZE (* LC nBYTES)) ;;10
       (if-zero (* is_prefix              ;;11
                   (- 1 [DEPTH 2]))
              (did-dec AL_item_BYTESIZE (* LC nBYTES)))
       (if-zero CT  
              (begin
              (did-dec nb_Addr (* is_prefix                         ;; 12
                                  (- 1 [DEPTH 2])))
              (did-dec nb_Sto (* (- 1 is_prefix)                        ;; 13
                                 [DEPTH 2])))))))
 

(defconstraint phase10-14 (:guard (eq 1 [PHASE 10]))   ;; 4.5.2.14
 (if-zero (+ CT
             (* is_prefix (- 1 [DEPTH 2])))
       (did-dec nb_Sto_per_Addr (* (- 1 is_prefix) [DEPTH 2]))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.6 Phase 11 : Beta / w  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint phase11-1 (:guard (eq [PHASE 11] 1))   ;; 4.6.1
 (if-zero (prev [PHASE 0])
       (begin
       (eq 1 
           (+ LT
              (* 2 LX)
              (* 4 is_bytesize)
              (* 8 is_list)))
       (eq number_step 8)
       (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list)
       (if-eq DONE 1
              (eq 8 
                  (+ is_padding
                     (* 2 end_phase)
                     (* 4 (next LT))
                     (* 8 (next LX))))))))

(defconstraint phase11-2 (:guard (eq [PHASE 11] 1))   ;; 4.6.2
 (if-eq (+ (prev LX) LX) 1
       (if-eq-else (^ 2 (- [INPUT 1] 27)) (- [INPUT 1] 27)
              (eq 7                                     ;; 2.a
                  (+ OLI
                     (* 2 is_padding)
                     (* 4 end_phase)))
              (begin                      ;; 2.b
              (eq number_step 8)
              (eq 0 (+ is_bytesize is_list))
              (rlpPrefixConstraints [INPUT 1] CT OLI number_step is_bytesize is_list)
              (if-eq DONE 1                      ;; 2.b.i
                     (begin
                     (eq 84 
                         (+ is_padding
                            (* 2 end_phase)
                            (* 4 (next OLI))
                            (* 8 (next LT))
                            (* 16 (next LX))
                            (* 32 (next is_padding))
                            (* 64 (next end_phase))))
                     (eq (next LIMB)
                         (+ (* int_short (^ 256 LLARGEMO))
                            (* int_short (^ 256 14))))
                     (eq (next nBYTES) 2)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4.7 Phase 13-14 : r & s  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint phase13_14 (:guard (eq (+ [PHASE 13] [PHASE 14]) 1))   ;; 4.7
 (begin
 (if-zero (+ [INPUT 1] [INPUT 2])
       (eq OLI 1)   ;; 1
       (vanishes OLI)) ;; 2 & 3
 (rlp32bytesIntegerConstraints [INPUT 1] [INPUT 2] OLI CT) ;; 4
 (if-eq DONE 1   ;; 5
       (eq end_phase 1))))