(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;   X.Y MISC/MXP constraints   ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (set-MXP-instruction---fixed-size   kappa        ;; row offset kappa
                                           instruction  ;; instruction
                                           offset_hi    ;; offset hi
                                           offset_lo    ;; offset lo
                                           fixed_size   ;; fixed size
                                           )
  (begin
    (eq! (shift misc/MXP_INST        kappa) instruction )
    (eq! (shift misc/MXP_OFFSET_1_HI kappa) offset_hi   )
    (eq! (shift misc/MXP_OFFSET_1_LO kappa) offset_lo   )
    (eq! (shift misc/MXP_SIZE_1_HI   kappa) 0           )
    (eq! (shift misc/MXP_SIZE_1_LO   kappa) fixed_size  )
    ))
