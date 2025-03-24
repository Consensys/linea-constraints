(module trm)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.1 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1
(defconstraint first-row (:domain {0})
  (vanishes! IOMF))

(defconstraint iomf-increment ()
 (or! (will-remain-constant! IOMF) (will-inc! IOMF 1)))

;; 3
(defconstraint null-stamp-null-columns ()
  (if-zero IOMF
           (begin (vanishes! RAW_ADDRESS_HI)
                  (vanishes! RAW_ADDRESS_LO)
                  (vanishes! TRM_ADDRESS_HI)
                  (vanishes! IS_PRECOMPILE)
                  (vanishes! (next CT))
                  (debug (vanishes! CT)))))

(defconstraint heartbeat (:guard IOMF)
  (begin  
        (if-zero CT (eq! FIRST 1))
        (if-zero (- TRM_CT_MAX CT)
        ;; CT = CT MAX
                      (vanishes! (next CT))
        ;; CT != CT MAX
                      (will-inc! CT 1))))

(defconstraint last-row (:domain {-1} :guard IOMF)
               (eq! CT TRM_CT_MAX))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          ;;
;;    2.2 stamp constancy   ;;
;;                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint stamp-constancies ()
  (begin (counter-constancy CT RAW_ADDRESS_HI)
         (counter-constancy CT RAW_ADDRESS_LO)
         (counter-constancy CT IS_PRECOMPILE)
         (counter-constancy CT TRM_ADDRESS_HI)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            ;;
;;    2.4 setting WCP calls   ;;
;;                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (wcpcall offset inst arg1hi arg1lo arg2hi arg2lo)
(begin (eq! (shift INST offset) inst)
       (eq! (shift ARG_1_HI offset) arg1hi)
       (eq! (shift ARG_1_LO offset) arg1lo)
       (eq! (shift ARG_2_HI offset) arg2hi)
       (eq! (shift ARG_2_LO offset) arg2lo)))

(defun (result-is-true offset)
  (eq! (shift RES offset) 1))

(defconstraint address-is-twenty-bytes (:guard FIRST)
  (begin 
  (wcpcall ROW_OFFSET_ADDRESS EVM_INST_LT TRM_ADDRESS_HI RAW_ADDRESS_LO TWOFIFTYSIX_TO_THE_FIVE 0)
  (result-is-true ROW_OFFSET_ADDRESS)))

(defconstraint leading-bytes-is-twelve-bytes (:guard FIRST)
  (begin 
  (eq! (shift INST ROW_OFFSET_ADDRESS_TRM) WCP_INST_LEQ)
  (vanishes! (shift ARG_1_HI ROW_OFFSET_ADDRESS_TRM))
  (vanishes! (shift ARG_2_HI ROW_OFFSET_ADDRESS_TRM))
  (eq! (shift ARG_2_LO ROW_OFFSET_ADDRESS_TRM) TWOFIFTYSIX_TO_THE_TWELVE_MO)
  (result-is-true ROW_OFFSET_ADDRESS_TRM)))

(defconstraint address-is-not-zero (:guard FIRST)
  (begin 
  (eq! (shift INST ROW_OFFSET_NON_ZERO_ADDR) EVM_INST_ISZERO)
  (eq! (shift ARG_1_HI ROW_OFFSET_NON_ZERO_ADDR) TRM_ADDRESS_HI)
  (eq! (shift ARG_1_LO ROW_OFFSET_NON_ZERO_ADDR) RAW_ADDRESS_LO)
  ))

(defconstraint address-is-prc-range (:guard FIRST)
(wcpcall ROW_OFFSET_PRC_ADDR WCP_INST_LEQ TRM_ADDRESS_HI RAW_ADDRESS_LO 0 NUMBER_OF_PRECOMPILES))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            ;;
;;    2.5 target constraints  ;;
;;                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint setting-precompile (:guard FIRST)
 (eq! IS_PRECOMPILE
      (* (shift RES ROW_OFFSET_PRC_ADDR)
         (- 1 (shift RES ROW_OFFSET_NON_ZERO_ADDR)))))

(defun (leading-byte) 
  (shift ARG_1_LO ROW_OFFSET_ADDRESS_TRM))

(defconstraint proving-trm (:guard FIRST)
(eq! RAW_ADDRESS_HI
     (+ (* TWOFIFTYSIX_TO_THE_FOUR (leading-byte))
        TRM_ADDRESS_HI)))