(module rom)

;; Constancies
(defun (cfi-constant X)
  (if-not-eq CFI
             (+ (prev CFI) 1)
             (remained-constant! X)))

(defun (cfi-incrementing X)
  (if-not-eq CFI
             (+ (prev CFI) 1)
             (or! (remained-constant! X) (did-inc! X 1))))

(defpurefun (counter-constant X ct ctmax)
  (if-not-eq ct ctmax (will-remain-constant! X)))

(defun (push-constant X)
  (if-not-zero PUSH_COUNTER
               (remained-constant! X)))

(defun (push-incrementing X)
  (if-not-zero PUSH_COUNTER
               (or! (remained-constant! X) (did-inc! X 1))))

(defconstraint cfi-constancies ()
  (cfi-constant CODE_SIZE))

(defconstraint cfi-incrementings ()
  (begin (cfi-incrementing CODE_SIZE_REACHED)
         (debug (cfi-incrementing PC))))

(defconstraint ct-constancies ()
  (begin (counter-constant LIMB CT COUNTER_MAX)
         (counter-constant LIMB_SIZE CT COUNTER_MAX)
         (counter-constant COUNTER_MAX CT COUNTER_MAX)))

(defconstraint push-constancies ()
  (begin (push-constant PUSH_COUNTER_MAX)
         (push-constant PUSH_VALUE_HI)
         (push-constant PUSH_VALUE_LO)))

;; Heartbeat
(defconstraint initialization (:domain {0})
  (vanishes! CODE_FRAGMENT_INDEX))

(defconstraint cfi-evolving-possibility ()
  (or! (will-remain-constant! CFI) (will-inc! CFI 1)))

(defconstraint no-cfi-nothing ()
  (if-zero CFI
           (begin (vanishes! CT)
                  (vanishes! COUNTER_MAX)
                  (vanishes! LIMB_BYTE)
                  (debug (vanishes! OPCODE_IS_PUSH))
                  (debug (vanishes! PUSH_CLAIMED))
                  (debug (vanishes! PUSH_COUNTER))
                  (debug (vanishes! PUSH_COUNTER_MAX))
                  (debug (vanishes! PROGRAM_COUNTER)))
           (begin (debug (or! (eq! COUNTER_MAX LLARGEMO) (eq! COUNTER_MAX WORD_SIZE_MO)))
                  (if-eq COUNTER_MAX LLARGEMO (will-remain-constant! CFI))
                  (if-not-eq COUNTER COUNTER_MAX (will-remain-constant! CFI))
                  (if-eq CT WORD_SIZE_MO (will-inc! CFI 1)))))

(defconstraint counter-evolution ()
  (if-eq-else CT COUNTER_MAX
              (vanishes! (next CT))
              (will-inc! CT 1)))

(defconstraint finalisation (:domain {-1})
  (if-not-zero CFI
               (begin (eq! CT COUNTER_MAX)
                      (eq! COUNTER_MAX WORD_SIZE_MO)
                      (eq! CFI CODE_FRAGMENT_INDEX_INFTY))))

(defconstraint cfi-infty ()
  (if-zero CFI
           (vanishes! CODE_FRAGMENT_INDEX_INFTY)
           (will-remain-constant! CODE_FRAGMENT_INDEX_INFTY)))

(defconstraint limb-accumulator ()
  (begin (if-zero CT
                  (eq! LIMB_ACC LIMB_BYTE)
                  (eq! LIMB_ACC
                       (+ (* 256 (prev LIMB_ACC))
                          LIMB_BYTE)))
         (if-eq CT COUNTER_MAX (eq! LIMB_ACC LIMB))))

;; CODE_SIZE_REACHED Constraints
(defconstraint codesizereached-trigger ()
  (if-eq PC (- CODE_SIZE 1)
         (eq! (+ CODE_SIZE_REACHED (next CODE_SIZE_REACHED))
              1)))

(defconstraint csr-impose-ctmax (:guard CFI)
  (if-zero CT
           (if-zero CODE_SIZE_REACHED
                    (eq! COUNTER_MAX LLARGEMO)
                    (eq! COUNTER_MAX WORD_SIZE_MO))))

;; nBytes constraints
(defconstraint nbytes-acc (:guard CFI)
  (if-zero CT
           (if-zero CODE_SIZE_REACHED
                    (eq! LIMB_SIZE_ACC 1)
                    (vanishes! LIMB_SIZE))
           (if-zero CODE_SIZE_REACHED
                    (did-inc! LIMB_SIZE_ACC 1)
                    (remained-constant! LIMB_SIZE_ACC))))

(defconstraint nbytes-collusion ()
  (if-eq CT COUNTER_MAX (eq! LIMB_SIZE LIMB_SIZE_ACC)))

;; LIMB_INDEX constraints
(defconstraint no-cfi-no-index ()
  (if-zero CFI
           (vanishes! LIMB_INDEX)))

(defconstraint new-cfi-reboot-index ()
  (if-not-zero (- CFI (prev CFI))
               (vanishes! LIMB_INDEX)))

(defconstraint new-ct-increment-index ()
  (if-not (or! (eq! CFI 0)
               (did-inc! CFI 1)
               (neq! CT 0))
          (did-inc! LIMB_INDEX 1)))

(defconstraint index-inc-in-middle-padding ()
  (if-eq CT LLARGE (did-inc! LIMB_INDEX 1)))

(defconstraint index-quasi-ct-cst ()
  (if-not-zero (* CT (- CT LLARGE))
               (remained-constant! LIMB_INDEX)))

;; PC constraints
(defconstraint pc-incrementing (:guard CFI)
  (if-not-eq (next CFI) (+ CFI 1) (will-inc! PC 1)))

(defconstraint pc-reboot ()
  (if-not-eq (next CFI)
             CFI
             (vanishes! (next PC))))

;; end of CFI (padding rows)
(defconstraint end-code-no-opcode ()
  (if-eq CODE_SIZE_REACHED 1 (vanishes! LIMB_BYTE)))

;; Constraints Related to PUSHX instructions
(defconstraint not-a-push-data ()
  (if-zero PUSH_CLAIMED
           (begin (vanishes! PUSH_COUNTER)
                  (eq! OPCODE LIMB_BYTE))))

(defconstraint ispush-ispushdata-exclusivity ()
  (or! (eq! OPCODE_IS_PUSH 0) (eq! PUSH_CLAIMED 0)))

(defconstraint ispush-implies-next-pushdata ()
  (if-not-zero OPCODE_IS_PUSH (eq! (next PUSH_CLAIMED) 1)))

(defconstraint ispush-constraint ()
  (if-not-zero OPCODE_IS_PUSH
               (begin (eq! PUSH_COUNTER_MAX
                           (- OPCODE (- EVM_INST_PUSH1 1)))
                      (vanishes! PUSH_VALUE_ACC)
                      (vanishes! (+ PUSH_FUNNEL_BIT (next PUSH_FUNNEL_BIT))))))

(defconstraint ispushdata-constraint ()
  (if-not-zero PUSH_CLAIMED
               (begin (eq! (+ (prev OPCODE_IS_PUSH) (prev PUSH_CLAIMED))
                           1)
                      (eq! OPCODE EVM_INST_INVALID)
                      (did-inc! PUSH_COUNTER 1)
                      (if-zero (- (+ PUSH_COUNTER LLARGE) PUSH_COUNTER_MAX)
                               (begin (will-inc! PUSH_FUNNEL_BIT 1)
                                      (eq! PUSH_VALUE_HI PUSH_VALUE_ACC))
                               (if-eq (next PUSH_CLAIMED) 1 (will-remain-constant! PUSH_FUNNEL_BIT)))
                      (if-zero (- (prev PUSH_FUNNEL_BIT) PUSH_FUNNEL_BIT)
                               (eq! PUSH_VALUE_ACC
                                    (+ (* 256 (prev PUSH_VALUE_ACC))
                                       LIMB_BYTE))
                               (eq! PUSH_VALUE_ACC LIMB_BYTE))
                      (if-eq PUSH_COUNTER PUSH_COUNTER_MAX
                             (begin (if-zero PUSH_FUNNEL_BIT
                                             (vanishes! PUSH_VALUE_HI))
                                    (eq! PUSH_VALUE_ACC PUSH_VALUE_LO)
                                    (vanishes! (next PUSH_CLAIMED)))))))


