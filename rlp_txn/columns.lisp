(module rlpTxn)

(defcolumns
    ABS_TX_NUM
    LIMB
    (nBYTES :byte)
    (LIMB_CONSTRUCTED	:boolean)
    (LT	:boolean)
    (LX	:boolean)
    INDEX_LT
    INDEX_LX
    ABS_TX_NUM_INFINY
    DATA_HI
    DATA_LO
    CODE_FRAGMENT_INDEX
    (REQUIRES_EVM_EXECUTION :boolean)
    (PHASE	:boolean	:array[0:14])
    (end_phase	:boolean)
    (TYPE	:byte)
    (COUNTER	:byte)
    (DONE	:boolean)
    (number_step	:byte)
    (INPUT	:display :bytes :array[2])
    (BYTE :byte :array[2])
    (ACC :display :bytes :array[2])
    ACC_BYTESIZE
    (BIT	:boolean)
    (BIT_ACC	:byte)
    POWER
    RLP_LT_BYTESIZE
    RLP_LX_BYTESIZE
    (LC_CORRECTION	:boolean)
    (is_prefix	:boolean)
    PHASE_BYTESIZE
    INDEX_DATA
    DATAGASCOST
    (DEPTH	:boolean	:array[2])
    ADDR_HI
    ADDR_LO
    ACCESS_TUPLE_BYTESIZE
    nb_Addr
    nb_Sto
    nb_Sto_per_Addr)

;; aliases
(defalias
    CT			COUNTER
    LC          LIMB_CONSTRUCTED
    P           POWER
    CFI         CODE_FRAGMENT_INDEX)
