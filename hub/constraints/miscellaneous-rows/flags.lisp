(module hub)

(defconst
  MISC_EXP_WEIGHT 1
  MISC_MMU_WEIGHT 2
  MISC_MXP_WEIGHT 4
  MISC_OOB_WEIGHT 8
  MISC_STP_WEIGHT 16
  )

(defun (weighted-misc-flag-sum) (+ (*  MISC_EXP_WEIGHT  misc/EXP_FLAG)
                                   (*  MISC_MMU_WEIGHT  misc/MMU_FLAG)
                                   (*  MISC_MXP_WEIGHT  misc/MXP_FLAG)
                                   (*  MISC_OOB_WEIGHT  misc/OOB_FLAG)
                                   (*  MISC_STP_WEIGHT  misc/STP_FLAG)))
