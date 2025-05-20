(module hubshan)


(defun (set-OOB-instruction---xcreate    kappa              ;; offset
                                         init_code_size_hi  ;; high part of initialization code size argument of CREATE(2)
                                         init_code_size_lo  ;; low  part of initialization code size argument of CREATE(2)
                                         ) (begin
                                         (eq! (shift     misc/OOB_INST       kappa)   OOB_INST_XCREATE        )
                                         (eq! (shift    (misc_oob_data_1)    kappa)   init_code_size_hi       )
                                         (eq! (shift    (misc_oob_data_2)    kappa)   init_code_size_lo       )
                                         ;; (eq! (shift    (misc_oob_data_3)    kappa) )
                                         ;; (eq! (shift    (misc_oob_data_4)    kappa) )
                                         ;; (eq! (shift    (misc_oob_data_5)    kappa) )
                                         ;; (eq! (shift    (misc_oob_data_6)    kappa) )
                                         ;; (eq! (shift    (misc_oob_data_7)    kappa) )    ;; value_is_nonzero
                                         ;; (eq! (shift    (misc_oob_data_8)    kappa) )    ;; value_is_zero    ... I don't remember why I ask for both ...
                                         ;; (eq! (shift    (misc_oob_data_9)    kappa) )
                                         ;; (eq! (shift    (misc_oob_data_10)   kappa) )
                                         ))
