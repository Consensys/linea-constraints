(module tx_rlp)

(defconst
  int-short               128  ;;RLP prefix of a short integer (<56 bytes)
  int-long                183  ;;RLP prefix of a long integer (>55 bytes)
  list-short              192  ;;RLP prefix of a short list (<56 bytes)
  list-long               247  ;;RLP prefix of a long list (>55 bytes)
  G_txdatazero            4    ;;Gas cost for a zero data byte 
  G_txdatanonzero         16   ;;Gas cost for a non-zero data byte
  LLARGE                  16
  LLARGEO                 15)   

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
  (if-zero (- (* PHASE (prev PHASE)) 1)
              (didnt-change C)))

;; Definition phase-incrementing
(defpurefun (phase-incrementing PHASE C)
  (if-zero (- (* PHASE (prev PHASE)) 1)
              (either (didnt-change C)
               (did-inc C 1))))

;; Definition phase-decrementing
(defpurefun (phase-decrementing PHASE C)
  (if-zero (- (* PHASE (prev PHASE)) 1)
              (either (didnt-change C)
               (did-dec C 1))))

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

;; 2.3.1.3
(defconstraint counter-incrementing ()
  (begin
   (counter-incrementing CT LC)))

;; 2.3.1.4
(defconstraint phase-constancy ()
  (begin
    (phase-constancy PHASE_9 OLI)))

;; 2.3.1.5
(defconstraint phase-constancy ()
  (begin
    (phase-constancy PHASE_0 RLP_LT_BYTESIZE)
    (phase-constancy PHASE_0 RLP_LX_BYTESIZE)))

;; 2.3.1.6
(defconstraint phase-decrementing ()
  (begin
    (phase-decrementing PHASE_9 is_prefix)))

;; 2.3.1.7
(defconstraint phase-incrementing ()
  (begin
    (phase-incrementing PHASE_9 is_padding)))


;; 2.3.1.8
;; TODO DEBUG/TRASH constraints



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.2 Global Phase Constraints  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.3.2.1
(defconstraint first-row (:domain {0}) (vanishes ABS_TX_NUM))

;; 2.3.2.2
(defconstraint ABS_TX_NUM-is-zero ()
  (if-zero ABS_TX_NUM
      (vanishes + (for i [15] [PHASE i]))))

;; 2.3.2.3
(defconstraint ABS_TX_NUM-is-nonzero ()
  (if-not-zero ABS_TX_NUM
      (eq 1 (+ (for i [15] [PHASE i])))))

;; 2.3.2.4
(defconstraint ABS_TX_NUM-evolution()
  (=
  ABS_TX_NUM
  (+ (prev ABS_TX_NUM) (* [PHASE 1] (- [PHASE 1] (prev [PHASE 1]))))))

;; 2.3.2.5
(defconstraint LT-and-LX()
  (if-eq (+ (for i [2 : 11] [PHASE i])) 1 
    (eq (* LT LX) 1)))

;; 2.3.2.6
(defconstraint LT-only()
  (if-eq (+ (for i [13 : 15] [PHASE i])) 1 
    (begin
    (eq LT 1)
    (eq LX 0))))

;; 2.3.2.6
(defconstraint no-done-no-end ()
  (if-zero DONE
    (vanishes end_phase)))

;; 2.3.2.7
(defconstraint no-end-no-changephase ()
  (if-zero end_phase 
    ((+ (for i [15] (* (- i 1) (- (next [PHASE i]) [PHASE i])))))))


;; 2.3.2.8
(defconstraint phase-transition ()
  (if-eq end_phase 1
    (begin
    (if-eq [PHASE 1] 1
      (if-eq-else TYPE 1
        (eq (next [PHASE 3]) 1)
        (eq (next [PHASE 2]) 1)))
    (if-eq [PHASE 2] 1
      (eq (next [PHASE 3]) 1))
    (if-eq [PHASE 3] 1
      (if-eq-else TYPE 2
        (eq (next [PHASE 5]) 1)
        (eq (next [PHASE 4]) 1)))
    (if-eq [PHASE 4] 1
      (eq (next [PHASE 7]) 1))
    (if-eq [PHASE 5] 1
      (eq (next [PHASE 6]) 1))
    (if-eq [PHASE 6] 1
      (eq (next [PHASE 7]) 1))
    (if-eq [PHASE 7] 1
      (eq (next [PHASE 8]) 1))
    (if-eq [PHASE 8] 1
      (eq (next [PHASE 9]) 1))
    (if-eq [PHASE 9] 1
      (eq (next [PHASE 10]) 1))
    (if-eq [PHASE 10] 1
      (begin
        DEBUG (vanishes PHASE_BYTESIZE)
        (vanishes DATAGASCOST)
        (if-eq-else TYPE 0
          (eq (next [PHASE 12]) 1)
          (eq (next [PHASE 11]) 1))))
    (if-eq [PHASE 11] 1
      (begin
        DEBUG (vanishes PHASE_BYTESIZE)
        (vanishes nb_Addr)
        (vanishes nb_Sto)
        (vanishes nb_Sto_per_Addr)
        (eq (next [PHASE 13]) 1)))
    (if-eq [PHASE 12] 1
      (eq (next [PHASE 14]) 1))
    (if-eq [PHASE 13] 1
      (eq (next [PHASE 14]) 1))
    (if-eq [PHASE 14] 1
      (eq (next [PHASE 15]) 1))
    (if-eq [PHASE 15] 1
      (begin
        (vanishes RLP_LT_BYTESIZE)
        (vanishes RLP_LX_BYTESIZE)
        (eq (next [PHASE 1]) 1))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3.3 Byte decomposition byte constraints  ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; 2.3.3.1
(defconstraint ())
