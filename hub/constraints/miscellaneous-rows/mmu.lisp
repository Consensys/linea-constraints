(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;   9.3 MISC/MMU constraints   ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (set-MMU-inst-mload
         kappa               ;; offset
         src_id              ;; source ID
         ;; tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         src_offset_lo       ;; source offset low
         ;; tgt_offset_lo       ;; target offset low
         ;; size                ;; size
         ;; ref_offset          ;; reference offset
         ;; ref_size            ;; reference size
         ;; success_bit         ;; success bit
         limb_1              ;; limb 1
         limb_2              ;; limb 2
         ;; exo_sum             ;; weighted exogenous module flag sum
         ;; phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_MLOAD )
         (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         ;; (eq! (shift misc/MMU_TGT_ID          kappa) )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) )
         (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) )
         ;; (eq! (shift misc/MMU_SIZE            kappa) )
         ;; (eq! (shift misc/MMU_REF_OFFSET      kappa) )
         ;; (eq! (shift misc/MMU_REF_SIZE        kappa) )
         ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) )
         (eq! (shift misc/MMU_LIMB_1          kappa) limb_1)
         (eq! (shift misc/MMU_LIMB_2          kappa) limb_2)
         ;; (eq! (shift misc/MMU_EXO_SUM         kappa) )
         ;; (eq! (shift misc/MMU_PHASE           kappa) )
         ))


(defun (set-MMU-inst-mstore
         kappa               ;; offset
         ;; src_id              ;; source ID
         tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         ;; src_offset_lo       ;; source offset low
         tgt_offset_lo       ;; target offset low
         ;; size                ;; size
         ;; ref_offset          ;; reference offset
         ;; ref_size            ;; reference size
         ;; success_bit         ;; success bit
         limb_1              ;; limb 1
         limb_2              ;; limb 2
         ;; exo_sum             ;; weighted exogenous module flag sum
         ;; phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_MSTORE)
         ;; (eq! (shift misc/MMU_SRC_ID          kappa) )
         (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) )
         (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         ;; (eq! (shift misc/MMU_SIZE            kappa) )
         ;; (eq! (shift misc/MMU_REF_OFFSET      kappa) )
         ;; (eq! (shift misc/MMU_REF_SIZE        kappa) )
         ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) )
         (eq! (shift misc/MMU_LIMB_1          kappa) limb_1)
         (eq! (shift misc/MMU_LIMB_2          kappa) limb_2)
         ;; (eq! (shift misc/MMU_EXO_SUM         kappa) )
         ;; (eq! (shift misc/MMU_PHASE           kappa) )
         ))


(defun (set-MMU-inst-mstore8
         kappa               ;; offset
         ;; src_id              ;; source ID
         tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         ;; src_offset_lo       ;; source offset low
         tgt_offset_lo       ;; target offset low
         ;; size                ;; size
         ;; ref_offset          ;; reference offset
         ;; ref_size            ;; reference size
         ;; success_bit         ;; success bit
         limb_1              ;; limb 1
         limb_2              ;; limb 2
         ;; exo_sum             ;; weighted exogenous module flag sum
         ;; phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_MSTORE8)
         ;; (eq! (shift misc/MMU_SRC_ID          kappa) )
         (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) )
         (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         ;; (eq! (shift misc/MMU_SIZE            kappa) )
         ;; (eq! (shift misc/MMU_REF_OFFSET      kappa) )
         ;; (eq! (shift misc/MMU_REF_SIZE        kappa) )
         ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) )
         (eq! (shift misc/MMU_LIMB_1          kappa) limb_1)
         (eq! (shift misc/MMU_LIMB_2          kappa) limb_2)
         ;; (eq! (shift misc/MMU_EXO_SUM         kappa) )
         ;; (eq! (shift misc/MMU_PHASE           kappa) )
         ))


(defun (set-MMU-inst-invalid-code-prefix
         kappa               ;; offset
         src_id              ;; source ID
         ;; tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         src_offset_lo       ;; source offset low
         ;; tgt_offset_lo       ;; target offset low
         ;; size                ;; size
         ;; ref_offset          ;; reference offset
         ;; ref_size            ;; reference size
         success_bit         ;; success bit
         ;; limb_1              ;; limb 1
         ;; limb_2              ;; limb 2
         ;; exo_sum             ;; weighted exogenous module flag sum
         ;; phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_invalidCodePrefix )
         (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         ;; (eq! (shift misc/MMU_TGT_ID          kappa) )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) )
         (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) )
         ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) )
         ;; (eq! (shift misc/MMU_SIZE            kappa) )
         ;; (eq! (shift misc/MMU_REF_OFFSET      kappa) )
         ;; (eq! (shift misc/MMU_REF_SIZE        kappa) )
         (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
         ;; (eq! (shift misc/MMU_LIMB_1          kappa) )
         ;; (eq! (shift misc/MMU_LIMB_2          kappa) )
         ;; (eq! (shift misc/MMU_EXO_SUM         kappa) )
         ;; (eq! (shift misc/MMU_PHASE           kappa) )
         ))


(defun (set-MMU-inst-right-padded-word-extraction
         kappa               ;; offset
         src_id              ;; source ID
         ;; tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         src_offset_lo       ;; source offset low
         ;; tgt_offset_lo       ;; target offset low
         ;; size                ;; size
         ref_offset          ;; reference offset
         ref_size            ;; reference size
         ;; success_bit         ;; success bit
         limb_1              ;; limb 1
         limb_2              ;; limb 2
         ;; exo_sum             ;; weighted exogenous module flag sum
         ;; phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_RIGHT_PADDED_WORD_EXTRACTION)
         (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         ;; (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) aux_id )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) src_offset_hi )
         (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         ;; (eq! (shift misc/MMU_SIZE            kappa) size )
         (eq! (shift misc/MMU_REF_OFFSET      kappa) ref_offset )
         (eq! (shift misc/MMU_REF_SIZE        kappa) ref_size )
         ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
         (eq! (shift misc/MMU_LIMB_1          kappa) limb_1 )
         (eq! (shift misc/MMU_LIMB_2          kappa) limb_2 )
         ;; (eq! (shift misc/MMU_EXO_SUM         kappa) exo_sum )
         ;; (eq! (shift misc/MMU_PHASE           kappa) phase )
         ))


(defun (set-MMU-inst-ram-to-exo-with-padding
         kappa               ;; offset
         src_id              ;; source ID
         tgt_id              ;; target ID
         aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         src_offset_lo       ;; source offset low
         ;; tgt_offset_lo       ;; target offset low
         size                ;; size
         ;; ref_offset          ;; reference offset
         ref_size            ;; reference size
         success_bit         ;; success bit
         ;; limb_1              ;; limb 1
         ;; limb_2              ;; limb 2
         exo_sum             ;; weighted exogenous module flag sum
         phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_RAM_TO_EXO_WITH_PADDING)
         (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         (eq! (shift misc/MMU_AUX_ID          kappa) aux_id )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) src_offset_hi )
         (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         (eq! (shift misc/MMU_SIZE            kappa) size )
         ;; (eq! (shift misc/MMU_REF_OFFSET      kappa) ref_offset )
         (eq! (shift misc/MMU_REF_SIZE        kappa) ref_size )
         (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
         ;; (eq! (shift misc/MMU_LIMB_1          kappa) limb_1 )
         ;; (eq! (shift misc/MMU_LIMB_2          kappa) limb_2 )
         (eq! (shift misc/MMU_EXO_SUM         kappa) exo_sum )
         (eq! (shift misc/MMU_PHASE           kappa) phase )
         ))


(defun (set-MMU-inst-exo-to-ram-transplants
         kappa               ;; offset
         src_id              ;; source ID
         tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         ;; src_offset_lo       ;; source offset low
         ;; tgt_offset_lo       ;; target offset low
         size                ;; size
         ;; ref_offset          ;; reference offset
         ;; ref_size            ;; reference size
         ;; success_bit         ;; success bit
         ;; limb_1              ;; limb 1
         ;; limb_2              ;; limb 2
         exo_sum             ;; weighted exogenous module flag sum
         phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_EXO_TO_RAM_TRANSPLANTS)
         (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) aux_id )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) src_offset_hi )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         (eq! (shift misc/MMU_SIZE            kappa) size )
         ;; (eq! (shift misc/MMU_REF_OFFSET      kappa) ref_offset )
         ;; (eq! (shift misc/MMU_REF_SIZE        kappa) ref_size )
         ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
         ;; (eq! (shift misc/MMU_LIMB_1          kappa) limb_1 )
         ;; (eq! (shift misc/MMU_LIMB_2          kappa) limb_2 )
         (eq! (shift misc/MMU_EXO_SUM         kappa) exo_sum )
         (eq! (shift misc/MMU_PHASE           kappa) phase )
         ))


(defun (set-MMU-inst-ram-to-ram-sans-padding
         kappa               ;; offset
         src_id              ;; source ID
         tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         src_offset_lo       ;; source offset low
         ;; tgt_offset_lo       ;; target offset low
         size                ;; size
         ref_offset          ;; reference offset
         ref_size            ;; reference size
         ;; success_bit         ;; success bit
         ;; limb_1              ;; limb 1
         ;; limb_2              ;; limb 2
         ;; exo_sum             ;; weighted exogenous module flag sum
         ;; phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_RAM_TO_RAM_SANS_PADDING)
         (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) aux_id )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) src_offset_hi )
         (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         (eq! (shift misc/MMU_SIZE            kappa) size )
         (eq! (shift misc/MMU_REF_OFFSET      kappa) ref_offset )
         (eq! (shift misc/MMU_REF_SIZE        kappa) ref_size )
         ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
         ;; (eq! (shift misc/MMU_LIMB_1          kappa) limb_1 )
         ;; (eq! (shift misc/MMU_LIMB_2          kappa) limb_2 )
         ;; (eq! (shift misc/MMU_EXO_SUM         kappa) exo_sum )
         ;; (eq! (shift misc/MMU_PHASE           kappa) phase )
         ))


(defun (set-MMU-inst-any-to-ram-with-padding
         kappa               ;; offset
         src_id              ;; source ID
         tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         src_offset_hi       ;; source offset high
         src_offset_lo       ;; source offset low
         tgt_offset_lo       ;; target offset low
         size                ;; size
         ref_offset          ;; reference offset
         ref_size            ;; reference size
         ;; success_bit         ;; success bit
         ;; limb_1              ;; limb 1
         ;; limb_2              ;; limb 2
         exo_sum             ;; weighted exogenous module flag sum
         ;; phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_ANY_TO_RAM_WITH_PADDING)
         (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) aux_id )
         (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) src_offset_hi )
         (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         (eq! (shift misc/MMU_SIZE            kappa) size )
         (eq! (shift misc/MMU_REF_OFFSET      kappa) ref_offset )
         (eq! (shift misc/MMU_REF_SIZE        kappa) ref_size )
         ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
         ;; (eq! (shift misc/MMU_LIMB_1          kappa) limb_1 )
         ;; (eq! (shift misc/MMU_LIMB_2          kappa) limb_2 )
         (eq! (shift misc/MMU_EXO_SUM         kappa) exo_sum )
         ;; (eq! (shift misc/MMU_PHASE           kappa) phase )
         ))


(defun (set-MMU-inst-modexp-zero
         kappa               ;; offset
         ;; src_id              ;; source ID
         tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         ;; src_offset_lo       ;; source offset low
         ;; tgt_offset_lo       ;; target offset low
         ;; size                ;; size
         ;; ref_offset          ;; reference offset
         ;; ref_size            ;; reference size
         ;; success_bit         ;; success bit
         ;; limb_1              ;; limb 1
         ;; limb_2              ;; limb 2
         exo_sum             ;; weighted exogenous module flag sum
         phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_modexpZero )
         ;; (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) aux_id )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) src_offset_hi )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         ;; (eq! (shift misc/MMU_SIZE            kappa) size )
         ;; (eq! (shift misc/MMU_REF_OFFSET      kappa) ref_offset )
         ;; (eq! (shift misc/MMU_REF_SIZE        kappa) ref_size )
         ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
         ;; (eq! (shift misc/MMU_LIMB_1          kappa) limb_1 )
         ;; (eq! (shift misc/MMU_LIMB_2          kappa) limb_2 )
         (eq! (shift misc/MMU_EXO_SUM         kappa) exo_sum )
         (eq! (shift misc/MMU_PHASE           kappa) phase )
         ))


(defun (set-MMU-inst-modexp-data
         kappa               ;; offset
         src_id              ;; source ID
         tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         src_offset_lo       ;; source offset low
         ;; tgt_offset_lo       ;; target offset low
         size                ;; size
         ref_offset          ;; reference offset
         ref_size            ;; reference size
         ;; success_bit         ;; success bit
         ;; limb_1              ;; limb 1
         ;; limb_2              ;; limb 2
         exo_sum             ;; weighted exogenous module flag sum
         phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_modexpData )
         (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) aux_id )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) src_offset_hi )
         (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         (eq! (shift misc/MMU_SIZE            kappa) size )
         (eq! (shift misc/MMU_REF_OFFSET      kappa) ref_offset )
         (eq! (shift misc/MMU_REF_SIZE        kappa) ref_size )
         ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
         ;; (eq! (shift misc/MMU_LIMB_1          kappa) limb_1 )
         ;; (eq! (shift misc/MMU_LIMB_2          kappa) limb_2 )
         (eq! (shift misc/MMU_EXO_SUM         kappa) exo_sum )
         (eq! (shift misc/MMU_PHASE           kappa) phase )
         ))


(defun (set-MMU-inst-blake
         kappa               ;; offset
         src_id              ;; source ID
         ;; tgt_id              ;; target ID
         ;; aux_id              ;; auxiliary ID
         ;; src_offset_hi       ;; source offset high
         src_offset_lo       ;; source offset low
         ;; tgt_offset_lo       ;; target offset low
         ;; size                ;; size
         ;; ref_offset          ;; reference offset
         ;; ref_size            ;; reference size
         success_bit         ;; success bit
         limb_1              ;; limb 1
         limb_2              ;; limb 2
         exo_sum             ;; weighted exogenous module flag sum
         phase               ;; phase
         ) (begin
         (eq! (shift misc/MMU_INST            kappa) MMU_INST_blake )
         (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
         ;; (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
         ;; (eq! (shift misc/MMU_AUX_ID          kappa) aux_id )
         ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) src_offset_hi )
         (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
         ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
         ;; (eq! (shift misc/MMU_SIZE            kappa) size )
         ;; (eq! (shift misc/MMU_REF_OFFSET      kappa) ref_offset )
         ;; (eq! (shift misc/MMU_REF_SIZE        kappa) ref_size )
         (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
         (eq! (shift misc/MMU_LIMB_1          kappa) limb_1 )
         (eq! (shift misc/MMU_LIMB_2          kappa) limb_2 )
         (eq! (shift misc/MMU_EXO_SUM         kappa) exo_sum )
         (eq! (shift misc/MMU_PHASE           kappa) phase )
         ))


;; (defun (set-MMU-inst-Z
;;          kappa               ;; offset
;;          ;; src_id              ;; source ID
;;          ;; tgt_id              ;; target ID
;;          ;; aux_id              ;; auxiliary ID
;;          ;; src_offset_hi       ;; source offset high
;;          ;; src_offset_lo       ;; source offset low
;;          ;; tgt_offset_lo       ;; target offset low
;;          ;; size                ;; size
;;          ;; ref_offset          ;; reference offset
;;          ;; ref_size            ;; reference size
;;          ;; success_bit         ;; success bit
;;          ;; limb_1              ;; limb 1
;;          ;; limb_2              ;; limb 2
;;          ;; exo_sum             ;; weighted exogenous module flag sum
;;          ;; phase               ;; phase
;;          ) (begin
;;          (eq! (shift misc/MMU_INST            kappa) MMU_INST_)
;;          ;; (eq! (shift misc/MMU_SRC_ID          kappa) src_id )
;;          ;; (eq! (shift misc/MMU_TGT_ID          kappa) tgt_id )
;;          ;; (eq! (shift misc/MMU_AUX_ID          kappa) aux_id )
;;          ;; (eq! (shift misc/MMU_SRC_OFFSET_HI   kappa) src_offset_hi )
;;          ;; (eq! (shift misc/MMU_SRC_OFFSET_LO   kappa) src_offset_lo )
;;          ;; (eq! (shift misc/MMU_TGT_OFFSET_LO   kappa) tgt_offset_lo )
;;          ;; (eq! (shift misc/MMU_SIZE            kappa) size )
;;          ;; (eq! (shift misc/MMU_REF_OFFSET      kappa) ref_offset )
;;          ;; (eq! (shift misc/MMU_REF_SIZE        kappa) ref_size )
;;          ;; (eq! (shift misc/MMU_SUCCESS_BIT     kappa) success_bit )
;;          ;; (eq! (shift misc/MMU_LIMB_1          kappa) limb_1 )
;;          ;; (eq! (shift misc/MMU_LIMB_2          kappa) limb_2 )
;;          ;; (eq! (shift misc/MMU_EXO_SUM         kappa) exo_sum )
;;          ;; (eq! (shift misc/MMU_PHASE           kappa) phase )
;;          ))
