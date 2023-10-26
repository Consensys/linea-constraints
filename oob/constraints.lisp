(module oob)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;; 2.1 shorthands and  ;;
;;     constants       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst 
  C_JUMP        0x56
  C_JUMPI       0x57
  C_RDC         0x3E
  C_CDL         0x35
  C_CALL        0xCA
  C_CREATE      0xCE
  C_SSTORE      0x55
  C_RETURN      0xF3
  CT_MAX_JUMP   0
  CT_MAX_JUMPI  1
  CT_MAX_RDC    2
  CT_MAX_CDL    0
  CT_MAX_CALL   1
  CT_MAX_CREATE 2
  CT_MAX_SSTORE 0
  CT_MAX_RETURN 0
  LT            0x10
  ISZERO        0x15
  ADD_OPCODE    0x01
  GT            0x11
  EQ            0x14)

(defun (flag_sum)
  (+ IS_JUMP IS_JUMPI IS_RDC IS_CDL IS_CALL IS_CREATE IS_SSTORE IS_RETURN))

(defun (wght_sum)
  (+ (* C_JUMP IS_JUMP)
     (* C_JUMPI IS_JUMPI)
     (* C_RDC IS_RDC)
     (* C_CDL IS_CDL)
     (* C_CALL IS_CALL)
     (* C_CREATE IS_CREATE)
     (* C_SSTORE IS_SSTORE)
     (* C_RETURN IS_RETURN)))

(defun (maxct_sum)
  (+ (* CT_MAX_JUMP IS_JUMP)
     (* CT_MAX_JUMPI IS_JUMPI)
     (* CT_MAX_RDC IS_RDC)
     (* CT_MAX_CDL IS_CDL)
     (* CT_MAX_CALL IS_CALL)
     (* CT_MAX_CREATE IS_CREATE)
     (* CT_MAX_SSTORE IS_SSTORE)
     (* CT_MAX_RETURN IS_RETURN)))

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
                  (vanishes! (+ WCP ADD (flag_sum))))))

(defconstraint stamp-increments ()
  (any! (remained-constant! STAMP) (did-inc! STAMP 1)))

(defconstraint counter-reset ()
  (if-not-zero (remained-constant! STAMP)
               (vanishes! CT)))

(defconstraint ct-max ()
  (eq! CT_MAX (maxct_sum)))

(defconstraint non-trivial-instruction-counter-cycle (:domain {-1})
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

;; TODO: write all contraints and run the non-implied ones only in debug mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.4 binary constraints   ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These constraints will be auto-generated due to the type of the columns
(defconstraint binary-constraints ()
  (begin (is-binary WCP)
         (is-binary ADD)
         (is-binary IS_JUMP)
         (is-binary IS_JUMPI)
         (is-binary IS_RDC)
         (is-binary IS_CDL)
         (is-binary IS_CALL)
         (is-binary IS_CREATE)
         (is-binary IS_SSTORE)
         (is-binary IS_RETURN)
         (for i [2] (is-binary [OOB_EVENT i]))))

(defconstraint wcp-add-are-exclusive ()
  (vanishes! (* WCP ADD)))

;; IS_CREATE = 0 => OOB_EVENT_2 = 0
(defconstraint is-create-oob-event ()
  (if-zero IS_CREATE
           (vanishes! [OOB_EVENT 2])))

;; for lookups check commented code in mxp and bin/hub_into_bin.lisp
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
  (did-change! STAMP))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.2 For JUMP       ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (jump-hypothesis)
  (eq! IS_JUMP 1))

(defun (pc_new_hi)
  [INCOMING_DATA 1])

(defun (pc_new_lo)
  [INCOMING_DATA 2])

(defun (codesize)
  [INCOMING_DATA 5])

(defconstraint valid-jump (:guard (and! (standing-hypothesis) (jump-hypothesis)))
  (begin (eq! WCP 1)
         (vanishes! ADD)
         (eq! OUTGOING_INST LT)
         (eq! [OUTGOING_DATA 1] (pc_new_hi))
         (eq! [OUTGOING_DATA 2] (pc_new_lo))
         (vanishes! [OUTGOING_DATA 3])
         (eq! [OUTGOING_DATA 4] (codesize))))

(defconstraint set-oob-event-jump (:guard (and! (standing-hypothesis) (jump-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (- 1 OUTGOING_RES_LO))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.3 For JUMPI      ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (jumpi-hypothesis)
  (eq! IS_JUMP 1))

;; Here we re-use some aliases from the previous section
(defun (jump_condition_hi)
  [INCOMING_DATA 3])

(defun (jump_condition_lo)
  [INCOMING_DATA 4])

(defconstraint valid-jumpi (:guard (and! (standing-hypothesis) (jumpi-hypothesis)))
  (begin (eq! WCP 1)
         (vanishes! ADD)
         (eq! OUTGOING_INST LT)
         (eq! [OUTGOING_DATA 1] (pc_new_hi))
         (eq! [OUTGOING_DATA 2] (pc_new_lo))
         (vanishes! [OUTGOING_DATA 3])
         (eq! [OUTGOING_DATA 4] (codesize))))

(defconstraint valid-jumpi-future (:guard (and! (standing-hypothesis) (jumpi-hypothesis)))
  (begin (eq! (next WCP) 1)
         (vanishes! (next ADD))
         (eq! OUTGOING_INST ISZERO)
         (eq! (next [OUTGOING_DATA 1]) (jump_condition_hi))
         (eq! (next [OUTGOING_DATA 2]) (jump_condition_lo))
         (vanishes! (next [OUTGOING_DATA 3]))
         (vanishes! (next [OUTGOING_DATA 4]))))

(defconstraint set-oob-event-jumpi (:guard (and! (standing-hypothesis) (jumpi-hypothesis)))
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
  (eq! IS_RDC 1))

(defun (offset_hi)
  [INCOMING_DATA 1])

(defun (offset_lo)
  [INCOMING_DATA 2])

(defun (size_hi)
  [INCOMING_DATA 3])

(defun (size_lo)
  [INCOMING_DATA 4])

(defun (rds)
  [INCOMING_DATA 5])

(defconstraint valid-rds (:guard (and! (standing-hypothesis) (rdc-hypothesis)))
  (begin (eq! WCP 1)
         (vanishes! ADD)
         (eq! OUTGOING_INST ISZERO)
         (eq! [OUTGOING_DATA 1] (offset_hi))
         (eq! [OUTGOING_DATA 2] (size_hi))
         (vanishes! [OUTGOING_DATA 3])
         (vanishes! [OUTGOING_DATA 4])))

(defconstraint valid-rds-future (:guard (and! (standing-hypothesis) (rdc-hypothesis)))
  (begin (vanishes! (next WCP))
         (eq! (next ADD) OUTGOING_RES_LO)
         (eq! (next OUTGOING_INST) ADD_OPCODE)
         (vanishes! (next [OUTGOING_DATA 1]))
         (eq! (next [OUTGOING_DATA 2]) (offset_lo))
         (vanishes! (next [OUTGOING_DATA 3]))
         (eq! (next [OUTGOING_DATA 4]) (size_lo))))

(defconstraint valid-rds-future-future (:guard (and! (standing-hypothesis) (rdc-hypothesis)))
  (begin (eq! (shift WCP 2) OUTGOING_RES_LO)
         (vanishes! (shift ADD 2))
         (eq! (shift OUTGOING_INST 2) GT)
         (vanishes! (shift [OUTGOING_DATA 3] 2))
         (eq! (shift [OUTGOING_DATA 4] 2) (rds))))

(defconstraint set-oob-event-rds (:guard (and! (standing-hypothesis) (rdc-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ (- 1 OUTGOING_RES_LO)
                 (+ OUTGOING_RES_LO (shift OUTGOING_RES_LO 2))))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.5 For               ;;
;; CALLDATALOAD          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (cdl-hypothesis)
  (eq! IS_CDL 1))

;; Here we re-use some aliases from the previous section
(defun (cds)
  [INCOMING_DATA 5])

(defconstraint valid-cdl (:guard (and! (standing-hypothesis) (cdl-hypothesis)))
  (begin (eq! WCP 1)
         (vanishes! ADD)
         (eq! OUTGOING_INST LT)
         (eq! [OUTGOING_DATA 1] (offset_hi))
         (eq! [OUTGOING_DATA 2] (offset_lo))
         (vanishes! [OUTGOING_DATA 3])
         (eq! [OUTGOING_DATA 4] (cds))))

(defconstraint set-oob-event-cdl (:guard (and! (standing-hypothesis) (cdl-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (- 1 OUTGOING_RES_LO))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.6 For CALL's     ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (call-hypothesis)
  (eq! IS_CALL 1))

(defun (val_hi)
  [INCOMING_DATA 1])

(defun (val_lo)
  [INCOMING_DATA 2])

(defun (bal)
  [INCOMING_DATA 3])

(defun (csd)
  [INCOMING_DATA 6])

(defconstraint valid-call (:guard (and! (standing-hypothesis) (call-hypothesis)))
  (begin (eq! WCP 1)
         (vanishes! ADD)
         (eq! OUTGOING_INST LT)
         (vanishes! [OUTGOING_DATA 1])
         (eq! [OUTGOING_DATA 2] (bal))
         (eq! [OUTGOING_DATA 3] (val_hi))
         (eq! [OUTGOING_DATA 4] (val_lo))))

(defconstraint valid-call-future (:guard (and! (standing-hypothesis) (call-hypothesis)))
  (begin (eq! (next WCP) 1)
         (vanishes! (next ADD))
         (eq! OUTGOING_INST EQ)
         (vanishes! (next [OUTGOING_DATA 1]))
         (eq! (next [OUTGOING_DATA 2]) (csd))
         (vanishes! (next [OUTGOING_DATA 3]))
         (eq! (next [OUTGOING_DATA 4] 1024))))

(defconstraint set-oob-event-call (:guard (and! (standing-hypothesis) (call-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ OUTGOING_RES_LO
                 (* (- 1 OUTGOING_RES_LO)
                    (- 1 (next OUTGOING_RES_LO)))))
         (vanishes! [OOB_EVENT 2])))


