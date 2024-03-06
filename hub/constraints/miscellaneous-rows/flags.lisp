(module hub)


(defun (weighted-MISC-flag-sum kappa) (+ (*  MISC_EXP_WEIGHT  (shift misc/EXP_FLAG kappa))
                                         (*  MISC_MMU_WEIGHT  (shift misc/MMU_FLAG kappa))
                                         (*  MISC_MXP_WEIGHT  (shift misc/MXP_FLAG kappa))
                                         (*  MISC_OOB_WEIGHT  (shift misc/OOB_FLAG kappa))
                                         (*  MISC_STP_WEIGHT  (shift misc/STP_FLAG kappa))))
