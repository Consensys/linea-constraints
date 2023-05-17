(module tx_rlp)

(defconst
  int_short               128  ;;RLP prefix of a short integer (<56 bytes), defined in the EYP.
  int_long                183  ;;RLP prefix of a long integer (>55 bytes), defined in the EYP.
  list_short              192  ;;RLP prefix of a short list (<56 bytes), defined in the EYP.
  list_long               247  ;;RLP prefix of a long list (>55 bytes), defined in the EYP.
  G_txdatazero            4    ;;Gas cost for a zero data byte, defined in the EYP.
  G_txdatanonzero         16   ;;Gas cost for a non-zero data byte, defined in the EYP.
  LLARGE                  16
  LLARGEMO                 15)

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
  (begin
   (stamp-constancy ABS_TX_NUM TYPE)))

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
              (eq (* LT LX) 1)))

;; 2.3.2.6
(defconstraint LT-only()
  (if-eq (reduce + (for i [12 : 14] [PHASE i])) 1
              (begin
              (eq LT 1)
              (eq LX 0))))

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
 (if-zero didnt-change ABS_TX_NUM
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
;;    2.3.5 Finalisation Constraints  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint finalisation (:domain {-1})
 (if-not-zero ABS_TX_NUM
       (begin
       (eq end_phase 1)
       (eq [PHASE 14] 1))))

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
       (begin                                                                                                   ;; 2
       (defconstraint byte-counting-RLP-prefix() (ByteCountingConstraints(1 -(15 nbstep))))                   ;; 2.a
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
 (it-not-zero oli 
       (begin                                                                ;; 1
       (eq LIMB (* int_short (^ 256 15)))
       (eq nBYTES 1))
       (begin                                                                           ;; 2
       (eq number_step 16)
       (iz-zero input_hi                                       
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
                  (+ (* ((+ int_short 20) (^ 256 LLARGEMO)))
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
       (if-zero [ACC k]
              (begin
              (vanishes ACC_BYTESIZE)                    ;; 2.a.i
              (eq P                                       ;; 2.a.ii
                  (* 256 (prev P))))
              (begin 
              (did-increase ACC_BYTESIZE 1)                    ;; 2.b.i
              (didnt-change ACC_BYTESIZE)))))                      ;;2.b.ii

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4 Phase Heartbeat  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    4 Phase 0 : RLP prefix  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;