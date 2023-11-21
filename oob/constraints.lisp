(module oob)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;; 2.1 shorthands and  ;;
;;     constants       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst 
  C_JUMP               0x56
  C_JUMPI              0x57
  C_RDC                0x3E
  C_CDL                0x35
  C_CALL               0xCA
  C_CREATE             0xCE
  C_SSTORE             0x55
  C_RETURN             0xF3
  C_PRC_ECRECOVER      0xFF01
  C_PRC_SHA2           0xFF02
  C_PRC_RIPEMD         0xFF03
  C_PRC_IDENTITY       0xFF04
  C_PRC_ECADD          0xFF06
  C_PRC_ECMUL          0xFF07
  C_PRC_ECPAIRING      0xFF08
  CT_MAX_JUMP          0
  CT_MAX_JUMPI         1
  CT_MAX_RDC           2
  CT_MAX_CDL           0
  CT_MAX_CALL          1
  CT_MAX_CREATE        2
  CT_MAX_SSTORE        0
  CT_MAX_RETURN        0
  CT_MAX_PRC_ECRECOVER 0
  CT_MAX_PRC_SHA2      1
  CT_MAX_PRC_RIPEMD    1
  CT_MAX_PRC_IDENTITY  1
  CT_MAX_PRC_ECADD     0
  CT_MAX_PRC_ECMUL     0
  CT_MAX_PRC_ECPAIRING 2
  LT                   0x10
  ISZERO               0x15
  ADD                  0x01
  GT                   0x11
  EQ                   0x14
  G_CALLSTIPEND        2300)

(defun (flag_sum)
  (+ IS_JUMP
     IS_JUMPI
     IS_RDC
     IS_CDL
     IS_CALL
     IS_CREATE
     IS_SSTORE
     IS_RETURN
     PRC_ECRECOVER
     PRC_SHA2
     PRC_RIPEMD
     PRC_IDENTITY
     PRC_ECADD
     PRC_ECMUL
     PRC_ECPAIRING))

(defun (wght_sum)
  (+ (* C_JUMP IS_JUMP)
     (* C_JUMPI IS_JUMPI)
     (* C_RDC IS_RDC)
     (* C_CDL IS_CDL)
     (* C_CALL IS_CALL)
     (* C_CREATE IS_CREATE)
     (* C_SSTORE IS_SSTORE)
     (* C_RETURN IS_RETURN)
     (* C_PRC_ECRECOVER PRC_ECRECOVER)
     (* C_PRC_SHA2 PRC_SHA2)
     (* C_PRC_RIPEMD PRC_RIPEMD)
     (* C_PRC_IDENTITY PRC_IDENTITY)
     (* C_PRC_ECADD PRC_ECADD)
     (* C_PRC_ECMUL PRC_ECMUL)
     (* C_PRC_ECPAIRING PRC_ECPAIRING)))

(defun (maxct_sum)
  (+ (* CT_MAX_JUMP IS_JUMP)
     (* CT_MAX_JUMPI IS_JUMPI)
     (* CT_MAX_RDC IS_RDC)
     (* CT_MAX_CDL IS_CDL)
     (* CT_MAX_CALL IS_CALL)
     (* CT_MAX_CREATE IS_CREATE)
     (* CT_MAX_SSTORE IS_SSTORE)
     (* CT_MAX_RETURN IS_RETURN)
     (* CT_MAX_PRC_ECRECOVER PRC_ECRECOVER)
     (* CT_MAX_PRC_SHA2 PRC_SHA2)
     (* CT_MAX_PRC_RIPEMD PRC_RIPEMD)
     (* CT_MAX_PRC_IDENTITY PRC_IDENTITY)
     (* CT_MAX_PRC_ECADD PRC_ECADD)
     (* CT_MAX_PRC_ECMUL PRC_ECMUL)
     (* CT_MAX_PRC_ECPAIRING PRC_ECPAIRING)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.2 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint first-row (:domain {0})
  (vanishes! STAMP))

(defconstraint padding-vanishing ()
  (if-zero STAMP
           (begin (vanishes! CT)
                  (vanishes! CT_MAX)
                  (vanishes! (+ WCP_FLAG ADD_FLAG MOD_FLAG (flag_sum))))))

(defconstraint stamp-increments ()
  (any! (remained-constant! STAMP) (did-inc! STAMP 1)))

(defconstraint counter-reset ()
  (if-not-zero (remained-constant! STAMP)
               (vanishes! CT)))

(defconstraint ct-max ()
  (eq! CT_MAX (maxct_sum)))

(defconstraint non-trivial-instruction-counter-cycle ()
  (if-not-zero STAMP
               (if-eq-else CT CT_MAX (will-inc! STAMP 1) (will-inc! CT 1))))

(defconstraint final-row (:domain {-1})
  (if-not-zero STAMP
               (eq! CT CT_MAX)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3 counter constancy    ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint counter-constancy ()
  (begin (counter-constancy CT STAMP)
         (debug (counter-constancy CT CT_MAX))
         (for i [2] (counter-constancy CT [OOB_EVENT i]))
         (for i [6] (counter-constancy CT [INCOMING_DATA i]))
         (counter-constancy CT INCOMING_INST)
         (debug (counter-constancy CT IS_JUMP))
         (debug (counter-constancy CT IS_JUMPI))
         (debug (counter-constancy CT IS_RDC))
         (debug (counter-constancy CT IS_CDL))
         (debug (counter-constancy CT IS_CALL))
         (debug (counter-constancy CT IS_CREATE))
         (debug (counter-constancy CT IS_SSTORE))
         (debug (counter-constancy CT IS_RETURN))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.4 binary constraints   ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These constraints will be auto-generated due to the type of the columns
(defconstraint binary-constraints ()
  (begin (is-binary WCP_FLAG)
         (is-binary ADD_FLAG)
         (is-binary IS_JUMP)
         (is-binary IS_JUMPI)
         (is-binary IS_RDC)
         (is-binary IS_CDL)
         (is-binary IS_CALL)
         (is-binary IS_CREATE)
         (is-binary IS_SSTORE)
         (is-binary IS_RETURN)
         (for i [2] (is-binary [OOB_EVENT i]))
         (is-binary PRC_ECRECOVER)
         (is-binary PRC_SHA2)
         (is-binary PRC_RIPEMD)
         (is-binary PRC_IDENTITY)
         (is-binary PRC_ECADD)
         (is-binary PRC_ECMUL)
         (is-binary PRC_ECPAIRING)))

(defconstraint wcp-add-mod-are-exclusive ()
  (is-binary (+ WCP_FLAG ADD_FLAG MOD_FLAG)))

(defconstraint is-create-is-jump-oob-event ()
  (if-zero (+ IS_CREATE IS_JUMPI)
           (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.5 instruction decoding ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint flag-sum-vanishes ()
  (if-zero STAMP
           (vanishes! (flag_sum))))

(defconstraint flag-sum-equal-one ()
  (if-not-zero STAMP
               (eq! (flag_sum) 1)))

(defconstraint decoding ()
  (eq! INCOMING_INST (wght_sum)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;   Populating lookup columns   ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (standing-hypothesis)
  (- STAMP (prev STAMP)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.2 For JUMP       ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (jump-hypothesis)
  IS_JUMP)

(defun (jump___pc_new_hi)
  [INCOMING_DATA 1])

(defun (jump___pc_new_lo)
  [INCOMING_DATA 2])

(defun (jump___codesize)
  [INCOMING_DATA 5])

(defconstraint valid-jump (:guard (* (standing-hypothesis) (jump-hypothesis)))
  (begin (eq! WCP_FLAG 1)
         (vanishes! ADD_FLAG)
         (eq! OUTGOING_INST LT)
         (eq! [OUTGOING_DATA 1] (jump___pc_new_hi))
         (eq! [OUTGOING_DATA 2] (jump___pc_new_lo))
         (vanishes! [OUTGOING_DATA 3])
         (eq! [OUTGOING_DATA 4] (jump___codesize))))

(defconstraint set-oob-event-jump (:guard (* (standing-hypothesis) (jump-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (- 1 OUTGOING_RES_LO))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.3 For JUMPI      ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (jumpi-hypothesis)
  IS_JUMPI)

(defun (jumpi___pc_new_hi)
  [INCOMING_DATA 1])

(defun (jumpi___pc_new_lo)
  [INCOMING_DATA 2])

(defun (jumpi___jump_condition_hi)
  [INCOMING_DATA 3])

(defun (jumpi___jump_condition_lo)
  [INCOMING_DATA 4])

(defun (jumpi___codesize)
  [INCOMING_DATA 5])

(defconstraint valid-jumpi (:guard (* (standing-hypothesis) (jumpi-hypothesis)))
  (begin (eq! WCP_FLAG 1)
         (vanishes! ADD_FLAG)
         (eq! OUTGOING_INST LT)
         (eq! [OUTGOING_DATA 1] (jumpi___pc_new_hi))
         (eq! [OUTGOING_DATA 2] (jumpi___pc_new_lo))
         (vanishes! [OUTGOING_DATA 3])
         (eq! [OUTGOING_DATA 4] (jumpi___codesize))))

(defconstraint valid-jumpi-future (:guard (* (standing-hypothesis) (jumpi-hypothesis)))
  (begin (eq! (next WCP_FLAG) 1)
         (vanishes! (next ADD_FLAG))
         (eq! (next OUTGOING_INST) ISZERO)
         (eq! (next [OUTGOING_DATA 1]) (jumpi___jump_condition_hi))
         (eq! (next [OUTGOING_DATA 2]) (jumpi___jump_condition_lo))
         (vanishes! (next [OUTGOING_DATA 3]))
         (vanishes! (next [OUTGOING_DATA 4]))))

(defconstraint set-oob-event-jumpi (:guard (* (standing-hypothesis) (jumpi-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (* (- 1 (next OUTGOING_RES_LO))
                 (- 1 OUTGOING_RES_LO)))
         (eq! [OOB_EVENT 2]
              (- 1 (next OUTGOING_RES_LO)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.4 For               ;;
;; RETURNDATACOPY        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (rdc-hypothesis)
  IS_RDC)

(defun (rdc___offset_hi)
  [INCOMING_DATA 1])

(defun (rdc___offset_lo)
  [INCOMING_DATA 2])

(defun (rdc___size_hi)
  [INCOMING_DATA 3])

(defun (rdc___size_lo)
  [INCOMING_DATA 4])

(defun (rdc___rds)
  [INCOMING_DATA 5])

(defconstraint valid-rdc (:guard (* (standing-hypothesis) (rdc-hypothesis)))
  (begin (eq! WCP_FLAG 1)
         (vanishes! ADD_FLAG)
         (eq! OUTGOING_INST ISZERO)
         (eq! [OUTGOING_DATA 1] (rdc___offset_hi))
         (eq! [OUTGOING_DATA 2] (rdc___size_hi))
         (vanishes! [OUTGOING_DATA 3])
         (vanishes! [OUTGOING_DATA 4])))

(defconstraint valid-rdc-future (:guard (* (standing-hypothesis) (rdc-hypothesis)))
  (begin (vanishes! (next WCP_FLAG))
         (eq! (next ADD_FLAG) OUTGOING_RES_LO)
         (eq! (next OUTGOING_INST) ADD)
         (vanishes! (next [OUTGOING_DATA 1]))
         (eq! (next [OUTGOING_DATA 2]) (rdc___offset_lo))
         (vanishes! (next [OUTGOING_DATA 3]))
         (eq! (next [OUTGOING_DATA 4]) (rdc___size_lo))))

(defconstraint valid-rdc-future-future (:guard (* (standing-hypothesis) (rdc-hypothesis)))
  (begin (eq! (shift WCP_FLAG 2) OUTGOING_RES_LO)
         (vanishes! (shift ADD_FLAG 2))
         (eq! (shift OUTGOING_INST 2) GT)
         (vanishes! (shift [OUTGOING_DATA 3] 2))
         (eq! (shift [OUTGOING_DATA 4] 2) (rdc___rds))))

(defconstraint set-oob-event-rdc (:guard (* (standing-hypothesis) (rdc-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ (- 1 OUTGOING_RES_LO)
                 (* OUTGOING_RES_LO (shift OUTGOING_RES_LO 2))))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.5 For               ;;
;; CALLDATALOAD          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (cdl-hypothesis)
  IS_CDL)

(defun (cdl___offset_hi)
  [INCOMING_DATA 1])

(defun (cdl___offset_lo)
  [INCOMING_DATA 2])

(defun (cdl___cds)
  [INCOMING_DATA 5])

(defconstraint valid-cdl (:guard (* (standing-hypothesis) (cdl-hypothesis)))
  (begin (eq! WCP_FLAG 1)
         (vanishes! ADD_FLAG)
         (eq! OUTGOING_INST LT)
         (eq! [OUTGOING_DATA 1] (cdl___offset_hi))
         (eq! [OUTGOING_DATA 2] (cdl___offset_lo))
         (vanishes! [OUTGOING_DATA 3])
         (eq! [OUTGOING_DATA 4] (cdl___cds))))

(defconstraint set-oob-event-cdl (:guard (* (standing-hypothesis) (cdl-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (- 1 OUTGOING_RES_LO))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.6 For CALL's     ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (call-hypothesis)
  IS_CALL)

(defun (call___val_hi)
  [INCOMING_DATA 1])

(defun (call___val_lo)
  [INCOMING_DATA 2])

(defun (call___bal)
  [INCOMING_DATA 3])

(defun (call___csd)
  [INCOMING_DATA 6])

(defconstraint valid-call (:guard (* (standing-hypothesis) (call-hypothesis)))
  (begin (eq! WCP_FLAG 1)
         (vanishes! ADD_FLAG)
         (eq! OUTGOING_INST LT)
         (vanishes! [OUTGOING_DATA 1])
         (eq! [OUTGOING_DATA 2] (call___bal))
         (eq! [OUTGOING_DATA 3] (call___val_hi))
         (eq! [OUTGOING_DATA 4] (call___val_lo))))

(defconstraint valid-call-future (:guard (* (standing-hypothesis) (call-hypothesis)))
  (begin (eq! (next WCP_FLAG) 1)
         (vanishes! (next ADD_FLAG))
         (eq! (next OUTGOING_INST) LT)
         (vanishes! (next [OUTGOING_DATA 1]))
         (eq! (next [OUTGOING_DATA 2]) (call___csd))
         (vanishes! (next [OUTGOING_DATA 3]))
         (eq! (next [OUTGOING_DATA 4]) 1024)))

(defconstraint set-oob-event-call (:guard (* (standing-hypothesis) (call-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ OUTGOING_RES_LO
                 (* (- 1 OUTGOING_RES_LO)
                    (- 1 (next OUTGOING_RES_LO)))))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.7 For               ;;
;; CREATE's              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (create-hypothesis)
  IS_CREATE)

(defun (create___val_hi)
  [INCOMING_DATA 1])

(defun (create___val_lo)
  [INCOMING_DATA 2])

(defun (create___bal)
  [INCOMING_DATA 3])

(defun (create___nonce)
  [INCOMING_DATA 4])

(defun (create___has_code)
  [INCOMING_DATA 5])

(defun (create___csd)
  [INCOMING_DATA 6])

(defconstraint valid-create (:guard (* (standing-hypothesis) (create-hypothesis)))
  (begin (eq! WCP_FLAG 1)
         (vanishes! ADD_FLAG)
         (eq! OUTGOING_INST LT)
         (vanishes! [OUTGOING_DATA 1])
         (eq! [OUTGOING_DATA 2] (create___bal))
         (eq! [OUTGOING_DATA 3] (create___val_hi))
         (eq! [OUTGOING_DATA 4] (create___val_lo))))

(defconstraint valid-create-future (:guard (* (standing-hypothesis) (create-hypothesis)))
  (begin (eq! (next WCP_FLAG) 1)
         (vanishes! (next ADD_FLAG))
         (eq! (next OUTGOING_INST) LT)
         (vanishes! (next [OUTGOING_DATA 1]))
         (eq! (next [OUTGOING_DATA 2]) (create___csd))
         (vanishes! (next [OUTGOING_DATA 3]))
         (eq! (next [OUTGOING_DATA 4]) 1024)))

(defconstraint valid-create-future-future (:guard (* (standing-hypothesis) (create-hypothesis)))
  (begin (eq! (shift WCP_FLAG 2) 1)
         (vanishes! (shift ADD_FLAG 2))
         (eq! (shift OUTGOING_INST 2) ISZERO)
         (vanishes! (shift [OUTGOING_DATA 1] 2))
         (eq! (shift [OUTGOING_DATA 2] 2) (create___nonce))
         (vanishes! (shift [OUTGOING_DATA 3] 2))
         (vanishes! (shift [OUTGOING_DATA 4] 2))))

(defconstraint set-oob-event-create (:guard (* (standing-hypothesis) (create-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ OUTGOING_RES_LO
                 (* (- 1 OUTGOING_RES_LO)
                    (- 1 (next OUTGOING_RES_LO)))))
         (eq! [OOB_EVENT 2]
              (* (- 1 [OOB_EVENT 1])
                 (+ (create___has_code)
                    (* (- 1 (create___has_code))
                       (- 1 (shift OUTGOING_RES_LO 2))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.8 For               ;;
;; SSTORE                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (sstore-hypothesis)
  IS_SSTORE)

(defun (sstore___gas)
  [INCOMING_DATA 5])

(defconstraint valid-sstore (:guard (* (standing-hypothesis) (sstore-hypothesis)))
  (begin (eq! WCP_FLAG 1)
         (vanishes! ADD_FLAG)
         (eq! OUTGOING_INST LT)
         (vanishes! [OUTGOING_DATA 1])
         (eq! [OUTGOING_DATA 2] G_CALLSTIPEND)
         (vanishes! [OUTGOING_DATA 3])
         (eq! [OUTGOING_DATA 4] (sstore___gas))))

(defconstraint set-oob-event-sstore (:guard (* (standing-hypothesis) (sstore-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (- 1 OUTGOING_RES_LO))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.9 For               ;;
;; RETURN                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (return-hypothesis)
  IS_RETURN)

(defun (return___size_hi)
  [INCOMING_DATA 1])

(defun (return___size_lo)
  [INCOMING_DATA 2])

(defconstraint valid-return (:guard (* (standing-hypothesis) (return-hypothesis)))
  (begin (eq! WCP_FLAG 1)
         (vanishes! ADD_FLAG)
         (eq! OUTGOING_INST LT)
         (vanishes! [OUTGOING_DATA 1])
         (eq! [OUTGOING_DATA 2] 24576)
         (eq! [OUTGOING_DATA 3] (return___size_hi))
         (eq! [OUTGOING_DATA 4] (return___size_lo))))

(defconstraint set-oob-event-return (:guard (* (standing-hypothesis) (return-hypothesis)))
  (begin (eq! [OOB_EVENT 1] OUTGOING_RES_LO)
         (vanishes! [OOB_EVENT 2])))


