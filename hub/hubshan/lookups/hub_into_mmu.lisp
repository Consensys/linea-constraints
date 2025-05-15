(defun (hub-into-mmu-trigger-shan)
  (* hubshan.PEEK_AT_MISCELLANEOUS hubshan.misc/MMU_FLAG))

(deflookup
  hub-into-mmu
  ;; target columns
  (
    mmushan.MACRO
    mmushan.STAMP
    mmushan.macro/INST
    mmushan.macro/SRC_ID
    mmushan.macro/TGT_ID
    mmushan.macro/AUX_ID
    mmushan.macro/SRC_OFFSET_LO
    mmushan.macro/SRC_OFFSET_HI
    mmushan.macro/TGT_OFFSET_LO
    mmushan.macro/SIZE
    mmushan.macro/REF_OFFSET
    mmushan.macro/REF_SIZE
    mmushan.macro/SUCCESS_BIT
    mmushan.macro/LIMB_1
    mmushan.macro/LIMB_2
    mmushan.macro/PHASE
    mmushan.macro/EXO_SUM
  )
  ;; source columns
  (
    (hub-into-mmu-trigger-shan)
    (* hubshan.MMU_STAMP (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_INST (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_SRC_ID (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_TGT_ID (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_AUX_ID (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_SRC_OFFSET_LO (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_SRC_OFFSET_HI (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_TGT_OFFSET_LO (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_SIZE (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_REF_OFFSET (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_REF_SIZE (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_SUCCESS_BIT (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_LIMB_1 (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_LIMB_2 (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_PHASE (hub-into-mmu-trigger-shan))
    (* hubshan.misc/MMU_EXO_SUM (hub-into-mmu-trigger-shan))
  ))


