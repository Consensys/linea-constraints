(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                          ;;
;;   10.5 SCEN/PRC instruction shorthands   ;;
;;                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  PRC/sum
(defun (scenario-shorthand-PRC-sum)
  (+ 
    PRC_ECRECOVER
    PRC_SHA2-256
    PRC_RIPEMD-160
    PRC_IDENTITY
    PRC_MODEXP
    PRC_ECADD
    PRC_ECMUL
    PRC_ECPAIRING
    PRC_BLAKE2f
    ;; PRC_SUCCESS_WILL_REVERT
    ;; PRC_SUCCESS_WONT_REVERT
    ;; PRC_FAILURE_KNOWN_TO_HUB
    ;; PRC_FAILURE_KNOWN_TO_RAM
    ))

;;  PRC/weighted_sum
(defun (scenario-shorthand-PRC-weighted-sum)
  (+ 
    (*  1  PRC_ECRECOVER  )
    (*  2  PRC_SHA2-256   )
    (*  3  PRC_RIPEMD-160 )
    (*  4  PRC_IDENTITY   )
    (*  5  PRC_MODEXP     )
    (*  6  PRC_ECADD      )
    (*  7  PRC_ECMUL      )
    (*  8  PRC_ECPAIRING  )
    (*  9  PRC_BLAKE2f    )
    ;; PRC_SUCCESS_WILL_REVERT
    ;; PRC_SUCCESS_WONT_REVERT
    ;; PRC_FAILURE_KNOWN_TO_HUB
    ;; PRC_FAILURE_KNOWN_TO_RAM
    ))

;;  PRC/failure
(defun (scenario-shorthand-PRC-failure)
  (+ 
    ;; PRC_ECRECOVER
    ;; PRC_SHA2-256
    ;; PRC_RIPEMD-160
    ;; PRC_IDENTITY
    ;; PRC_MODEXP
    ;; PRC_ECADD
    ;; PRC_ECMUL
    ;; PRC_ECPAIRING
    ;; PRC_BLAKE2f
    ;; PRC_SUCCESS_WILL_REVERT
    ;; PRC_SUCCESS_WONT_REVERT
    PRC_FAILURE_KNOWN_TO_HUB
    PRC_FAILURE_KNOWN_TO_RAM
    ))

;;  PRC/success
(defun (scenario-shorthand-PRC-success)
  (+ 
    ;; PRC_ECRECOVER
    ;; PRC_SHA2-256
    ;; PRC_RIPEMD-160
    ;; PRC_IDENTITY
    ;; PRC_MODEXP
    ;; PRC_ECADD
    ;; PRC_ECMUL
    ;; PRC_ECPAIRING
    ;; PRC_BLAKE2f
    PRC_SUCCESS_WILL_REVERT
    PRC_SUCCESS_WONT_REVERT
    ;; PRC_FAILURE_KNOWN_TO_HUB
    ;; PRC_FAILURE_KNOWN_TO_RAM
    ))

;;  PRC/scenario_sum
(defun (scenario-shorthand-PRC-scenario-sum)
  (+ 
    ;; PRC_ECRECOVER
    ;; PRC_SHA2-256
    ;; PRC_RIPEMD-160
    ;; PRC_IDENTITY
    ;; PRC_MODEXP
    ;; PRC_ECADD
    ;; PRC_ECMUL
    ;; PRC_ECPAIRING
    ;; PRC_BLAKE2f
    (scenario-shorthand-PRC-failure)
    (scenario-shorthand-PRC-success)
    ))

;; ;;  PRC/
;; (defun (scenario-shorthand-PRC-)
;;   (+ 
;;     PRC_ECRECOVER
;;     PRC_SHA2-256
;;     PRC_RIPEMD-160
;;     PRC_IDENTITY
;;     PRC_MODEXP
;;     PRC_ECADD
;;     PRC_ECMUL
;;     PRC_ECPAIRING
;;     PRC_BLAKE2f
;;     PRC_SUCCESS_WILL_REVERT
;;     PRC_SUCCESS_WONT_REVERT
;;     PRC_FAILURE_KNOWN_TO_HUB
;;     PRC_FAILURE_KNOWN_TO_RAM
;;     ))
