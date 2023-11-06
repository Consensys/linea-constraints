(module stp)

(defconst 
  DIV                 0x04
  LT                  0x10
  GT                  0x11
  EQ                  0x14
  ISZERO              0x15
  max_CT_CALL         6
  max_CT_CALL_OOGX    2
  ;; CT_MAX_DELTA                 4
  G_create            32000
  G_warmaccess        100
  G_coldaccountaccess 2600
  G_callvalue         9000
  G_newaccount        25000
  G_callstipend       2300)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.1 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint first-row (:domain {0})
  (vanishes! STAMP))

(defconstraint stamp-increments ()
  (vanishes! (* (will-inc! STAMP 1) (will-remain-constant! STAMP))))

(defconstraint initial-vanishings ()
  (if-zero STAMP
           (begin (vanishes! CT)
                  (vanishes! (+ WCP_FLAG MOD_FLAG)))))

(defconstraint counter-reset ()
  (if-not-zero (will-remain-constant! STAMP)
               (vanishes! (next CT))))

(defconstraint heartbeat (:guard STAMP)
  (begin (eq! (+ CT_MAX
                 INST_TYPE
                 (* (- max_CT_CALL max_CT_CALL_OOGX) OOGX))
              max_CT_CALL_OOGX)
         (if-eq-else CT CT_MAX (will-inc! STAMP 1) (will-inc! CT 1))))

;; (if-zero INST_TYPE
;;          ;; INST_TYPE eq! 0 i.e. dealing will CALL-type instructions
;;          (if-eq-else CT max_ct_CALL
;;                      ;; CT eq!eq! max_ct_CALL
;;                      (will-inc! STAMP 1)
;;                      ;; CT !eq! max_ct_CALL
;;                      (will-inc! CT 1))
;;          ;; INST_TYPE eq! 1 i.e. dealing will CREATE-type instructions
;;          (if-eq-else CT max_ct_CREATE
;;                      ;; CT eq!eq! max_ct_CREATE
;;                      (will-inc! STAMP 1)
;;                      ;; CT !eq! max_ct_CREATE
;;                      (will-inc! CT 1)))))
(defconstraint final-row (:domain {-1})
  (if-not-zero STAMP
               (if-zero INST_TYPE
                        (eq! CT CT_MAX))))

;; (eq! CT max_ct_CALL)       ;; INST_TYPE eq! 0  <eq!eq!>  CALL-type instruction
;; (eq! CT max_ct_CREATE))))  ;; INST_TYPE eq! 1  <eq!eq!>  CREATE-type instruction
;;;;;;;;;;;;;;;;;;;;;;
;;                  ;;
;;    2.2 binary    ;;
;;                  ;;
;;;;;;;;;;;;;;;;;;;;;;
(defconstraint binary-constraints ()
  (begin (debug (is-binary INST_TYPE))
         (debug (is-binary CCTV))
         (debug (is-binary TO_EXISTS))
         (debug (is-binary TO_WARM))
         (debug (is-binary OOGX))
         (debug (is-binary TO_HAS_CODE))
         (debug (is-binary ABORT))
         (debug (is-binary FCOND))
         (is-binary WCP_FLAG)
         (is-binary MOD_FLAG)))

(defconstraint exclusive-flags ()
  (vanishes! (* WCP_FLAG MOD_FLAG)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    2.4 constancies    ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint counter-constancies ()
  (begin (counter-constancy CT GAS_ACTUAL)
         (counter-constancy CT GAS_MXP)
         (counter-constancy CT GAS_COST)
         (counter-constancy CT GAS_STIPEND)
         ;
         (counter-constancy CT GAS_HI)
         (counter-constancy CT GAS_LO)
         ;
         (counter-constancy CT VAL_HI)
         (counter-constancy CT VAL_LO)
         ;
         (counter-constancy CT TO_EXISTS)
         (counter-constancy CT TO_WARM)
         ;
         (counter-constancy CT CSD)
         (counter-constancy CT FROM_BALANCE)
         (counter-constancy CT TO_HAS_CODE)
         (counter-constancy CT TO_NONCE)
         (counter-constancy CT ABORT)
         (counter-constancy CT FCOND)
         ;
         (counter-constancy CT OOGX)
         (counter-constancy CT INST_TYPE)
         (counter-constancy CT CCTV)
         (counter-constancy CT CT_MAX)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                    ;;
;;    3.2 Constraints for CREATE-type instructions    ;;
;;                                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (first-row-of-CREATE)
  (* (remained-constant! STAMP) INST_TYPE))

(defun (first-row-of-unexceptional-CREATE)
  (* (first-row-of-CREATE) (- 1 OOGX)))

(defun (create-gActual)
  GAS_ACTUAL)

(defun (create-gPrelim)
  (+ GAS_MXP G_create))

(defun (create-gDiff)
  (- (create-gActual) (create-gPrelim)))

(defun (create-oneSixtyFourth)
  (shift RES_LO 2))

(defun (create-LgDiff)
  (- (create-gDiff) (create-oneSixtyFourth)))

(defun (create-abortSum)
  (+ (- 1 (shift RES_LO 3)) ;; <- evaluates to 1 iff CSD >eq! 1024
     (shift RES_LO 4)))     ;; <- evaluates to 1 iff CALL_VALUE > FROM_BALANCE

(defun (create-fCondSum)
  (+ (- 1 (shift RES_LO 5)) ;; <- evaluates to 1 iff TO address has nonzero nonce
     TO_HAS_CODE))          ;; <- evaluates to 1 iff TO address has nonempty code

;; common rows of all CREATE instructions
(defconstraint CREATE-type-common (:guard (first-row-of-CREATE))
  (begin  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (vanishes! ARG_1_HI)
         (eq! ARG_1_LO (create-gActual))
         (vanishes! ARG_2_LO)
         (eq! EXO_INST LT)
         (vanishes! RES_LO)
         (eq! WCP_FLAG 1)
         ;; (eq! MOD_FLAG 0)
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 1   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (vanishes! (next ARG_1_HI))
         (eq! (next ARG_1_LO) (create-gActual))
         (eq! (next ARG_2_LO) (create-gPrelim))
         (eq! (next EXO_INST) LT)
         (eq! (next RES_LO) OOGX)
         (eq! (next WCP_FLAG) 1)
         ;; (eq! (next MOD_FLAG) 0)
         ))

;; rows of CREATE instructions that don't produce an OOGX
(defconstraint CREATE-type-no-exception (:guard (first-row-of-unexceptional-CREATE))
  (begin  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 2   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (vanishes! (shift ARG_1_HI 2))
         (eq! (shift ARG_1_LO 2) (create-gDiff))
         (eq! (shift ARG_2_LO 2) 64)
         (eq! (shift EXO_INST 2) DIV)
         ;; (eq! (shift RES_LO 2) ...)
         (vanishes! (shift WCP_FLAG 2))
         (eq! (shift MOD_FLAG 2) (- 1 OOGX))
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 3   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (vanishes! (shift ARG_1_HI 3))
         (eq! (shift ARG_1_LO 3) CSD)
         (eq! (shift ARG_2_LO 3) 1024)
         (eq! (shift EXO_INST 3) LT)
         ;; (eq! (shift RES_LO 3) ...)
         (eq! (shift WCP_FLAG 3) 1)
         ;; (vanishes! (shift MOD_FLAG 3))
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 4   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (eq! (shift ARG_1_HI 4) VAL_HI)
         (eq! (shift ARG_1_LO 4) VAL_LO)
         (eq! (shift ARG_2_LO 4) FROM_BALANCE)
         (eq! (shift EXO_INST 4) GT)
         ;; (eq! (shift RES_LO 4) ...)
         (eq! (shift WCP_FLAG 4) 1)
         ;; (vanishes! (shift MOD_FLAG 4))
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 5   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (vanishes! (shift ARG_1_HI 5))
         (eq! (shift ARG_1_LO 5) TO_NONCE)
         (vanishes! (shift ARG_2_LO 5))
         (eq! (shift EXO_INST 5) ISZERO)
         ;; (eq! (shift RES_LO 5) ...)
         (eq! (shift WCP_FLAG 5) 1)
         ;; (vanishes! (shift MOD_FLAG 5))))
         ))

(defconstraint CREATE-type-outputs (:guard (first-row-of-unexceptional-CREATE))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;   Setting GAS_COST and GAS_STPD   ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (if-zero OOGX
           ;; OOGX eq!eq! 0
           (begin (eq! GAS_COST (+ (create-gPrelim) (create-LgDiff)))
                  (eq! GAS_STIPEND (create-LgDiff))
                  (if-zero (create-abortSum)
                           (vanishes! ABORT)
                           (eq! ABORT 1))
                  (if-zero ABORT
                           (if-zero (create-fCondSum)
                                    (vanishes! FCOND)
                                    (eq! FCOND 1))
                           (vanishes! FCOND)))
           ;; OOGX eq!eq! 1
           (begin (eq! GAS_COST (create-gPrelim))
                  (vanishes! GAS_STIPEND)
                  (vanishes! ABORT))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                  ;;
;;    3.2 Constraints for CALL-type instructions    ;;
;;                                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; all of these definitions implicitly assume that the current row (i) is such that
;; - STAMP[i] !eq! STAMP[i - 1]       <eq! first row of the instruction
;; - INST_TYPE eq! 0                  <eq! CALL-type instruction
(defun (first-row-of-CALL)
  (* (remained-constant! STAMP) (- 1 INST_TYPE)))

(defun (first-row-of-unexceptional-CALL)
  (* (first-row-of-CALL) (- 1 OOGX)))

(defun (call-valueIsZero)
  (next RES_LO))

(defun (call-gActual)
  GAS_ACTUAL)

(defun (call-gAccess)
  (+ (* TO_WARM G_warmaccess)
     (* (- 1 TO_WARM) G_coldaccountaccess)))

(defun (call-gCreate)
  (* (- 1 TO_EXISTS) G_newaccount))

(defun (call-gTransfer)
  (* CCTV (- 1 (call-valueIsZero)) G_callvalue))

(defun (call-gXtra)
  (+ (call-gAccess) (call-gCreate) (call-gTransfer)))

(defun (call-gPrelim)
  (+ GAS_MXP (call-gXtra)))

(defun (call-oneSixtyFourths)
  (shift RES_LO 3))

(defun (call-gDiff)
  (- (call-gActual) (call-gPrelim)))

(defun (call-stpComp)
  (shift RES_LO 4))

(defun (call-LgDiff)
  (- (call-gDiff) (call-oneSixtyFourths)))

(defun (call-gMin)
  (+ (* (- 1 (call-stpComp)) (call-LgDiff))
     (* (call-stpComp) GAS_LO)))

(defun (call-abortSum)
  (+ (- 1 (shift RES_LO 5)) ;; <- evaluates to 1 iff CSD >eq! 1024
     (shift RES_LO 6)))     ;; <- evaluates to 1 iff CALL_VALUE > FROM_BALANCE

;; common rows of all CREATE instructions
(defconstraint CALL-type-common (:guard (first-row-of-CALL))
  (begin  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (vanishes! ARG_1_HI)
         (eq! ARG_1_LO (call-gActual))
         (vanishes! ARG_2_LO)
         (eq! EXO_INST LT)
         (vanishes! RES_LO)
         (eq! WCP_FLAG 1)
         ;; (eq! MOD_FLAG 0)
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 1   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (eq! (next ARG_1_HI) VAL_HI)
         (eq! (next ARG_1_LO) VAL_LO)
         (vanishes! (next ARG_2_LO))
         (eq! (next EXO_INST) ISZERO)
         ;; (eq! (next RES_LO) ...)
         (eq! (next WCP_FLAG) CCTV)
         (vanishes! (next MOD_FLAG))
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 2   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (vanishes! (shift ARG_1_HI 2))
         (eq! (shift ARG_1_LO 2) (call-gActual))
         (eq! (shift ARG_2_LO 2) (call-gPrelim))
         (eq! (shift EXO_INST 2) LT)
         (eq! (shift RES_LO 2) OOGX)
         (eq! (shift WCP_FLAG 2) 1)
         ;; (vanishes! (shift MOD_FLAG 2))
         ))

;; 
(defconstraint CALL-type-no-exception (:guard (first-row-of-unexceptional-CALL))
  (begin  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 3   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (vanishes! (shift ARG_1_HI 3))
         (if-zero OOGX
                  (eq! (shift ARG_1_LO 3) (call-gDiff)))
         (eq! (shift ARG_2_LO 3) 64)
         (eq! (shift EXO_INST 3) DIV)
         ;; (eq! (shift RES_LO 3) ...)
         ;; (vanishes! (shift WCP_FLAG 3))
         (eq! (shift MOD_FLAG 3) 1)
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 4   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (eq! (shift ARG_1_HI 4) GAS_HI)
         (eq! (shift ARG_1_LO 4) GAS_LO)
         (eq! (shift ARG_2_LO 4) (call-LgDiff))
         (eq! (shift EXO_INST 4) LT)
         ;; (eq! (shift RES_LO 4) ...)
         (eq! (shift WCP_FLAG 4) 1)
         ;; (vanishes! (shift MOD_FLAG 4))
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 5   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (vanishes! (shift ARG_1_HI 5))
         (eq! (shift ARG_1_LO 5) CSD)
         (eq! (shift ARG_2_LO 5) 1024)
         (eq! (shift EXO_INST 5) LT)
         ;; (eq! (shift RES_LO 5) ...)
         (eq! (shift WCP_FLAG 5) 1)
         ;; (vanishes! (shift MOD_FLAG 5))
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ;;   ------------->   row i + 6   ;;
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         (eq! (shift ARG_1_HI 6) VAL_HI)
         (eq! (shift ARG_1_LO 6) VAL_LO)
         (eq! (shift ARG_2_LO 6) FROM_BALANCE)
         (eq! (shift EXO_INST 6) GT)
         ;; (eq! (shift RES_LO 6) ...)
         (eq! (shift WCP_FLAG 6) 1)
         ;; (vanishes! (shift MOD_FLAG 6))
         ))

(defconstraint CALL-type-outputs (:guard (first-row-of-CALL))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;   Setting GAS_COST and GAS_STPD   ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (if-zero OOGX
           ;; OOGX eq!eq! 0
           (begin (eq! GAS_COST (+ (call-gPrelim) (call-gMin)))
                  (eq! GAS_STIPEND
                       (+ (call-gMin)
                          (* CCTV (- 1 (call-valueIsZero)) G_callstipend)))
                  (if-zero (call-abortSum)
                           (vanishes! ABORT)
                           (eq! ABORT 1)))
           ;; OOGX eq!eq! 1
           (begin (eq! GAS_COST (call-gPrelim))
                  (vanishes! GAS_STIPEND))))


