(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                   ;;
;;   10.2 SCEN General constraints   ;;
;;                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defconstraint scenario-binarities (:perspective scenario)
;;                (begin
;;                  (debug (is-binary CALL_EXCEPTION                                   ))
;;                  (debug (is-binary CALL_ABORT_WILL_REVERT                           ))
;;                  (debug (is-binary CALL_ABORT_WONT_REVERT                           ))
;;                  (debug (is-binary CALL_EOA_SUCCESS_CALLER_WILL_REVERT              ))
;;                  (debug (is-binary CALL_EOA_SUCCESS_CALLER_WONT_REVERT              ))
;;                  (debug (is-binary CALL_SMC_FAILURE_CALLER_WILL_REVERT              ))
;;                  (debug (is-binary CALL_SMC_FAILURE_CALLER_WONT_REVERT              ))
;;                  (debug (is-binary CALL_SMC_SUCCESS_CALLER_WILL_REVERT              ))
;;                  (debug (is-binary CALL_SMC_SUCCESS_CALLER_WONT_REVERT              ))
;;                  (debug (is-binary CALL_PRC_FAILURE                                 ))
;;                  (debug (is-binary CALL_PRC_SUCCESS_CALLER_WILL_REVERT              ))
;;                  (debug (is-binary CALL_PRC_SUCCESS_CALLER_WONT_REVERT              ))
;;                  (debug (is-binary CREATE_EXCEPTION                                 ))
;;                  (debug (is-binary CREATE_ABORT                                     ))
;;                  (debug (is-binary CREATE_FAILURE_CONDITION_WILL_REVERT             ))
;;                  (debug (is-binary CREATE_FAILURE_CONDITION_WONT_REVERT             ))
;;                  (debug (is-binary CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT    ))
;;                  (debug (is-binary CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT    ))
;;                  (debug (is-binary CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT    ))
;;                  (debug (is-binary CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT    ))
;;                  (debug (is-binary CREATE_EMPTY_INIT_CODE_WILL_REVERT               ))
;;                  (debug (is-binary CREATE_EMPTY_INIT_CODE_WONT_REVERT               ))
;;                  (debug (is-binary PRC_ECRECOVER                                    ))
;;                  (debug (is-binary PRC_SHA2-256                                     ))
;;                  (debug (is-binary PRC_RIPEMD-160                                   ))
;;                  (debug (is-binary PRC_IDENTITY                                     ))
;;                  (debug (is-binary PRC_MODEXP                                       ))
;;                  (debug (is-binary PRC_ECADD                                        ))
;;                  (debug (is-binary PRC_ECMUL                                        ))
;;                  (debug (is-binary PRC_ECPAIRING                                    ))
;;                  (debug (is-binary PRC_BLAKE2f                                      ))
;;                  (debug (is-binary PRC_SUCCESS_CALLER_WILL_REVERT                   ))
;;                  (debug (is-binary PRC_SUCCESS_CALLER_WONT_REVERT                          ))
;;                  (debug (is-binary PRC_FAILURE_KNOWN_TO_HUB                         ))
;;                  (debug (is-binary PRC_FAILURE_KNOWN_TO_RAM                         ))
;;                  (debug (is-binary RETURN_EXCEPTION                                 ))
;;                  (debug (is-binary RETURN_MESSAGE_CALL_WILL_TOUCH_RAM               ))
;;                  (debug (is-binary RETURN_MESSAGE_CALL_WONT_TOUCH_RAM               ))
;;                  (debug (is-binary RETURN_DEPLOYMENT_EMPTY_CODE_WILL_REVERT         ))
;;                  (debug (is-binary RETURN_DEPLOYMENT_EMPTY_CODE_WONT_REVERT         ))
;;                  (debug (is-binary RETURN_DEPLOYMENT_NONEMPTY_CODE_WILL_REVERT      ))
;;                  (debug (is-binary RETURN_DEPLOYMENT_NONEMPTY_CODE_WONT_REVERT      ))
;; ))

(defconstraint only-one-active-scenario (:perspective scenario)
               (is-binary
                 (+
                   (scenario-shorthand---CALL---sum)
                   (scenario-shorthand---CREATE---sum)
                   (scenario-shorthand---PRC---sum)
                   (scenario-shorthand---RETURN---sum)
                   (scenario-shorthand---SELFDESTRUCT---sum)
                   )))

(defconstraint   at-most-one-precompile-address-bit-is-active   (:perspective scenario)
                 (eq!   (scenario-shorthand---PRC---full-address-bit-sum)
                        (scenario-shorthand---PRC---sum)))
