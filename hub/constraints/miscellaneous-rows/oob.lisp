(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                       ;;
;;   9.4 MISC/OOB constraints: opcodes   ;;
;;                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun (set-oob-inst-jump
         kappa               ;; offset
         pc_new_hi           ;; high part of proposed new program counter
         pc_new_lo           ;; low  part of proposed new program counter
         code_size           ;; code size of byte code currently executing
         ) (begin
         (eq! (shift misc/OOB_INST             kappa) OOB_INST_jump )
         (eq! (shift [ misc/OOB_DATA 1 ]       kappa) pc_new_hi)
         (eq! (shift [ misc/OOB_DATA 2 ]       kappa) pc_new_lo)
         ;; (eq! (shift [ misc/OOB_DATA 3 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 4 ]    kappa) )
         (eq! (shift [ misc/OOB_DATA 5 ]       kappa) code_size)
         ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))

(defun (set-oob-inst-jumpi
         kappa               ;; offset
         pc_new_hi           ;; high part of proposed new program counter
         pc_new_lo           ;; low  part of proposed new program counter
         jump_condition_hi   ;; high part of jump condition
         jump_condition_lo   ;; low  part of jump condition
         code_size           ;; code size of byte code currently executing
         ) (begin
         (eq! (shift misc/OOB_INST             kappa) OOB_INST_jumpi)
         (eq! (shift [ misc/OOB_DATA 1 ]       kappa) pc_new_hi)
         (eq! (shift [ misc/OOB_DATA 2 ]       kappa) pc_new_lo)
         (eq! (shift [ misc/OOB_DATA 3 ]       kappa) jump_condition_hi)
         (eq! (shift [ misc/OOB_DATA 4 ]       kappa) jump_condition_lo)
         (eq! (shift [ misc/OOB_DATA 5 ]       kappa) code_size)
         ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))

(defun (set-oob-inst-sstore
         kappa               ;; offset
         gas_actual          ;; GAS_ACTUAL
         ) (begin
         (eq! (shift misc/OOB_INST          kappa) OOB_INST_sstore )
         ;; (eq! (shift [ misc/OOB_DATA 1 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 2 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 3 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 4 ]    kappa) )
         (eq! (shift [ misc/OOB_DATA 5 ]    kappa) gas_actual)
         ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                           ;;
;;   9.4 MISC/OOB constraints: precompiles   ;;
;;                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun (set-oob-inst-common
         kappa                            ;; offset
         common_precompile_oob_inst       ;; relevant OOB instruction
         call_gas                         ;; call gas i.e. gas provided to the precompile
         cds                              ;; call data size
         r@c                              ;; return at capacity, final argument of any CALL
         ) (begin
         (eq! (shift misc/OOB_INST            kappa) common_precompile_oob_inst )
         (eq! (shift [ misc/OOB_DATA 1 ]    kappa) call_gas )
         (eq! (shift [ misc/OOB_DATA 2 ]    kappa) cds      )
         (eq! (shift [ misc/OOB_DATA 3 ]    kappa) r@c      )
         ;; (eq! (shift [ misc/OOB_DATA 4 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 5 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))


(defun (set-oob-inst-modexp-cds
         kappa                            ;; offset
         cds                              ;; call data size
         ) (begin
         (eq! (shift misc/OOB_INST            kappa) OOB_INST_modexpCds )
         ;; (eq! (shift [ misc/OOB_DATA 1 ]    kappa) )
         (eq! (shift [ misc/OOB_DATA 2 ]    kappa) cds )
         ;; (eq! (shift [ misc/OOB_DATA 3 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 4 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 5 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))


(defun (set-oob-inst-modexp-xbs
         kappa                            ;; offset
         xbs_hi                           ;; high part of some {b,e,m}bs
         xbs_lo                           ;; low  part of some {b,e,m}bs
         ybs_lo                           ;; low  part of some {b,e,m}bs
         compute_max                      ;; bit indicating whether to compute max(xbs, ybs) or not
         ) (begin
         (eq! (shift misc/OOB_INST            kappa) OOB_INST_modexpXbs )
         (eq! (shift [ misc/OOB_DATA 1 ]    kappa) xbs_hi      )
         (eq! (shift [ misc/OOB_DATA 2 ]    kappa) xbs_lo      )
         (eq! (shift [ misc/OOB_DATA 3 ]    kappa) ybs_lo      )
         (eq! (shift [ misc/OOB_DATA 4 ]    kappa) compute_max )
         ;; (eq! (shift [ misc/OOB_DATA 5 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))


(defun (set-oob-inst-modexp-lead
         kappa                            ;; offset
         bbs_lo                           ;; low part of bbs (base     byte size)
         cds                              ;; call data size
         ebs_lo                           ;; low part of ebs (exponent byte size)
         ) (begin
         (eq! (shift misc/OOB_INST            kappa) OOB_INST_modexpLead )
         (eq! (shift [ misc/OOB_DATA 1 ]    kappa) bbs_lo )
         (eq! (shift [ misc/OOB_DATA 2 ]    kappa) cds    )
         (eq! (shift [ misc/OOB_DATA 3 ]    kappa) ebs_lo )
         ;; (eq! (shift [ misc/OOB_DATA 4 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 5 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))


(defun (set-oob-inst-modexp-pricing
         kappa                            ;; offset
         call_gas                         ;; call gas i.e. gas provided to the precompile
         r@c                              ;; return at capacity, final argument of any CALL
         exponent_log                     ;; leading (≤) word log of exponent
         max_mbs_bbs                      ;; call data size
         ) (begin
         (eq! (shift misc/OOB_INST            kappa) OOB_INST_modexpPricing )
         (eq! (shift [ misc/OOB_DATA 1 ]    kappa) call_gas )
         ;; (eq! (shift [ misc/OOB_DATA 2 ]    kappa) )
         (eq! (shift [ misc/OOB_DATA 3 ]    kappa) r@c )
         ;; (eq! (shift [ misc/OOB_DATA 4 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 5 ]    kappa) )
         (eq! (shift [ misc/OOB_DATA 6 ]    kappa) exponent_log )
         (eq! (shift [ misc/OOB_DATA 7 ]    kappa) max_mbs_bbs )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))


(defun (set-oob-inst-modexp-extract
         kappa                            ;; offset
         cds                              ;; call data size
         bbs_lo                           ;; low part of bbs (base     byte size)
         ebs_lo                           ;; low part of ebs (exponent byte size)
         mbs_lo                           ;; low part of mbs (modulus  byte size)
         ) (begin
         (eq! (shift misc/OOB_INST            kappa) OOB_INST_modexpExtract )
         ;; (eq! (shift [ misc/OOB_DATA 1 ]    kappa) )
         (eq! (shift [ misc/OOB_DATA 2 ]    kappa) cds    )
         (eq! (shift [ misc/OOB_DATA 3 ]    kappa) bbs_lo )
         (eq! (shift [ misc/OOB_DATA 4 ]    kappa) ebs_lo )
         (eq! (shift [ misc/OOB_DATA 5 ]    kappa) mbs_lo )
         ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))


(defun (set-oob-inst-blake-cds
         kappa                            ;; offset
         cds                              ;; call data size
         r@c                              ;; return at capacity, final argument of any CALL
         ) (begin
         (eq! (shift misc/OOB_INST            kappa) OOB_INST_blakeCds )
         ;; (eq! (shift [ misc/OOB_DATA 1 ]    kappa) )
         (eq! (shift [ misc/OOB_DATA 2 ]    kappa) cds )
         (eq! (shift [ misc/OOB_DATA 3 ]    kappa) r@c )
         ;; (eq! (shift [ misc/OOB_DATA 4 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 5 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))


(defun (set-oob-inst-blake
         kappa                            ;; offset
         call_gas                         ;; call gas i.e. gas provided to the precompile
         blake_r                          ;; rounds parameter of the call data of BLAKE2f
         blake_f                          ;; f      parameter of the call data of BLAKE2f ("final block indicator")
         ) (begin
         (eq! (shift misc/OOB_INST            kappa) OOB_INST_blakeParams )
         (eq! (shift [ misc/OOB_DATA 1 ]    kappa) call_gas )
         ;; (eq! (shift [ misc/OOB_DATA 2 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 3 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 4 ]    kappa) )
         ;; (eq! (shift [ misc/OOB_DATA 5 ]    kappa) )
         (eq! (shift [ misc/OOB_DATA 6 ]    kappa) blake_r )
         (eq! (shift [ misc/OOB_DATA 7 ]    kappa) blake_f )
         ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
         ))






;; (defun (set-oob-inst-Z
;;          kappa                            ;; offset
;;          ) (begin
;;          (eq! (shift misc/OOB_INST            kappa) OOB_INST_ )
;;          ;; (eq! (shift [ misc/OOB_DATA 1 ]    kappa) )
;;          ;; (eq! (shift [ misc/OOB_DATA 2 ]    kappa) )
;;          ;; (eq! (shift [ misc/OOB_DATA 3 ]    kappa) )
;;          ;; (eq! (shift [ misc/OOB_DATA 4 ]    kappa) )
;;          ;; (eq! (shift [ misc/OOB_DATA 5 ]    kappa) )
;;          ;; (eq! (shift [ misc/OOB_DATA 6 ]    kappa) )
;;          ;; (eq! (shift [ misc/OOB_DATA 7 ]    kappa) )
;;          ;; (eq! (shift [ misc/OOB_DATA 8 ]    kappa) )
;;          ))
