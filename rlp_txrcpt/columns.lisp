(module rlpTxRcpt)

(defcolumns
    ABS_TX_NUM
    ABS_TX_NUM_MAX
    LOG_NUM
    LOG_NUM_MAX
    LIMB
    (nBYTES :byte)
    (LIMB_CONSTRUCTED	:boolean)
    INDEX
    INDEX_LOCAL
    (PHASE	:boolean	:array[0:4])
    (PHASE_END	:boolean)
    (COUNTER	:byte)
    (nSTEP	:byte)
    (DONE	:boolean)
    TXRCPT_SIZE
    (INPUT	:display :bytes :array[4])
    (BYTE :byte :array[4])
    (ACC :display :bytes :array[4])
    ACC_SIZE
    (BIT	:boolean)
    (BIT_ACC	:byte)
    POWER
    (IS_PREFIX	:boolean)
    (LC_CORRECTION	:boolean)
    PHASE_SIZE
    (DEPTH_1	:boolean)
    (IS_TOPIC :boolean)
    (IS_DATA :boolean)
    LOG_ENTRY_SIZE
    LOCAL_SIZE)

;; aliases
(defalias
    CT			COUNTER
    LC          LIMB_CONSTRUCTED
    P           POWER)
