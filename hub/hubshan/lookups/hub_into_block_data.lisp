(defun (hub-into-block-data-trigger) (* hubshan.PEEK_AT_STACK
                                        (- 1 hubshan.XAHOY)
                                        hubshan.stack/BTC_FLAG
                                        (- 1 [hubshan.stack/DEC_FLAG 1])))

(deflookup hub-into-blockdata
           ;; target columns
           (
             blockdata.REL_BLOCK
             blockdata.INST
             blockdata.DATA_HI
             blockdata.DATA_LO
             )
           ;; source columns
           (
            (* hubshan.RELATIVE_BLOCK_NUMBER          (hub-into-block-data-trigger))
            (* hubshan.stack/INSTRUCTION              (hub-into-block-data-trigger))
            (* [hubshan.stack/STACK_ITEM_VALUE_HI 4]  (hub-into-block-data-trigger))
            (* [hubshan.stack/STACK_ITEM_VALUE_LO 4]  (hub-into-block-data-trigger))
            )
           )
