(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          ;;
;;   4.7 Auxiliary stamps   ;;
;;                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint initial-vanishing-of-stauxiliary-stamps (:domain {0})
               (begin (vanishes! HASH_INFO_STAMP)
                      (vanishes! LOG_INFO_STAMP)
                      (vanishes! MXP_STAMP)
                      (vanishes! MMU_STAMP)))

;; Note: the MMU stamp isn't hubStamp constant: you can have multiple MMU instructions being set off by a single instruction
;; e.g.
;;    * RETURN in a deployment context (invalidCodePrefixException check + byte code deployment)
;;    * generally precompiles (except for the IDENTITY) will require 3 MMU instructions (parameter extraction, full result transfer, partial result copy)
;;    * BLAKE:  you grab r, f and then potentially transfer inputs, potentially transfer the full results to RAM, potentially partially copy results to current RAM
;;    * MODEXP: you grab the bbs, ebs, mbs, rawLeadingExponentWord, potentially transfer inputs to data module, potentially transfer the full results to RAM, potentially copy partial results to RAM

(defconstraint auxiliary-stamps-hub-constancies ()
               (begin (hub-stamp-constancy HASH_INFO_STAMP)
                      (hub-stamp-constancy LOG_INFO_STAMP)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                       ;;
;;   4.7.1 HASH_INFO_STAMP constraints   ;;
;;                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint HASH_INFO_STAMP-increments ()
               (begin
                 (debug (any! (remained-constant! HASH_INFO_STAMP)
                              (did-inc! HASH_INFO_STAMP)))
                 (if-not-zero (remained-constant! HUB_STAMP)
                              (did-inc! HASH_INFO_STAMP (* PEEK_AT_STACK stack/HASH_INFO_FLAG)))))

(defconstraint necessary-conditions-for-HASH_INFO_FLAG-to-be-on (:perspective stack)
               (begin
                 (debug (is-binary HASH_INFO_FLAG))
                 (if-not-zero HASH_INFO_FLAG
                              (eq!  1
                                    (* (-  1 XAHOY)
                                       (+  stack/KEC_FLAG                          ;; selects for SHA3
                                           (* stack/CREATE_FLAG [stack/DEC_FLAG 2])      ;; selects for CREATE2
                                           (* stack/HALT_FLAG   [stack/DEC_FLAG 1])      ;; selects for RETURN
                                           ))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                      ;;
;;   4.7.2 LOG_INFO_STAMP constraints   ;;
;;                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint LOG_INFO_STAMP-increments ()
               (begin
                 (debug (any! (remained-constant! LOG_INFO_STAMP)
                              (did-inc! LOG_INFO_STAMP)))
                 (if-not-zero (remained-constant! HUB_STAMP)
                              (did-inc! LOG_INFO_STAMP (* PEEK_AT_STACK stack/LOG_INFO_FLAG)))))

(defconstraint necessary-conditions-for-LOG_INFO_FLAG-to-be-on (:perspective stack)
               (begin
                 (debug (is-binary LOG_INFO_FLAG))
                 (eq!  LOG_INFO_FLAG
                       (* LOG_FLAG (- 1 CN_WILL_REV)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 ;;
;;   4.7.3 MXP_STAMP constraints   ;;
;;                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint MXP_STAMP-increments (:perspective misc)
               (did-inc! MXP_STAMP (* PEEK_AT_MISCELLANEOUS MXP_FLAG)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                 ;;
;;   4.7.4 MMU_STAMP constraints   ;;
;;                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint MMU_STAMP-increments (:perspective misc)
               (did-inc! MMU_STAMP (* PEEK_AT_MISCELLANEOUS MXP_FLAG)))
