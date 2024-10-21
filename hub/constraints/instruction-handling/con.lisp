(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                               ;;;;
;;;;    X.5 Instruction handling   ;;;;
;;;;                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    X.5.27 Context   ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


(defconst
  ROFF_CONTEXT_INSTRUCTION___CONTEXT_ROW    1)

;; NOTE: bytes from the invalid instruction family
;; (ither not an opcode or the INVALID opcode)
;; can't raise stack exceptions
(defun (context-instruction---standard-hypothesis)    (* PEEK_AT_STACK
                                                         stack/CON_FLAG
                                                         (- 1 stack/SUX stack/SOX)))

(defun    (context-instruction---result-hi)            [ stack/STACK_ITEM_VALUE_HI 4 ])
(defun    (context-instruction---result-lo)            [ stack/STACK_ITEM_VALUE_LO 4 ])

(defun    (context-instruction---is-ADDRESS)           [ stack/DEC_FLAG 1 ])
(defun    (context-instruction---is-CALLER)            [ stack/DEC_FLAG 2 ])
(defun    (context-instruction---is-CALLVALUE)         [ stack/DEC_FLAG 3 ])
(defun    (context-instruction---is-CALLDATASIZE)      [ stack/DEC_FLAG 4 ]) ;; ""
(defun    (context-instruction---is-RETURNDATASIZE)    (-  1
                                                           (context-instruction---is-ADDRESS)
                                                           (context-instruction---is-CALLER)
                                                           (context-instruction---is-CALLVALUE)
                                                           (context-instruction---is-CALLDATASIZE)))


(defconstraint    context-instruction---setting-the-stack-pattern (:guard (context-instruction---standard-hypothesis))
                  (stack-pattern-0-1))

(defconstraint    context-instruction---setting-the-gas-cost      (:guard (context-instruction---standard-hypothesis))
                  (eq! GAS_COST stack/STATIC_GAS))

(defconstraint    context-instruction---setting-NSR               (:guard (context-instruction---standard-hypothesis))
                  (eq! NSR
                       (+ 1 CMC)))

(defconstraint    context-instruction---setting-peeking-flags     (:guard (context-instruction---standard-hypothesis))
                  (begin 
                    (eq! NSR (+ (shift PEEK_AT_CONTEXT        ROFF_CONTEXT_INSTRUCTION___CONTEXT_ROW)
                                (* CMC (shift PEEK_AT_CONTEXT 2))))
                    (read-context-data 1 CONTEXT_NUMBER)))

(defconstraint    context-instruction---value-constraints         (:guard (context-instruction---standard-hypothesis))
                  (if-zero CMC
                           (begin
                             (if-not-zero (context-instruction---is-ADDRESS)
                                          (begin    (eq!    (context-instruction---result-hi)    context/ACCOUNT_ADDRESS_HI)
                                                    (eq!    (context-instruction---result-lo)    context/ACCOUNT_ADDRESS_LO)))
                             (if-not-zero (context-instruction---is-CALLER)
                                          (begin    (eq!    (context-instruction---result-hi)    context/CALLER_ADDRESS_HI)
                                                    (eq!    (context-instruction---result-lo)    context/CALLER_ADDRESS_LO)))
                             (if-not-zero (context-instruction---is-CALLVALUE)
                                          (begin    (eq!    (context-instruction---result-hi)    0)
                                                    (eq!    (context-instruction---result-lo)    context/CALL_VALUE)))
                             (if-not-zero (context-instruction---is-CALLDATASIZE)
                                          (begin    (eq!    (context-instruction---result-hi)    0)
                                                    (eq!    (context-instruction---result-lo)    context/CALL_DATA_SIZE)))
                             (if-not-zero (context-instruction---is-RETURNDATASIZE)
                                          (begin    (eq!    (context-instruction---result-hi)    0)
                                                    (eq!    (context-instruction---result-lo)    context/RETURN_DATA_SIZE))))))
