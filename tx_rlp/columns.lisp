(module txRlp)

(defcolumns
    ABS_TX_NUM
    LIMB
    (nBYTES :byte)
    (LIMB_CONSTRUCTED	:binary)
    (LT	:binary)
    (LX	:binary)
    INDEX_LT
    INDEX_LX
    (PHASE	:binary	:array[0:14])
    (end_phase	:binary)
    (TYPE	:byte)
    (OLI	:binary)
    (COUNTER	:byte)
    (DONE	:binary)
    (number_step	:byte)
    (INPUT	:display :bytes :array[2])
    (BYTE :byte :array[2])
    (ACC :display :bytes :array[2])
    ACC_BYTESIZE
    (BIT	:binary)
    (BIT_ACC	:byte)
    POWER
    (is_bytesize	:binary)
    (is_list	:binary)
    (COMP	:binary)
    RLP_LT_BYTESIZE
    RLP_LX_BYTESIZE
    (is_padding	:binary)
    (is_prefix	:binary)
    PHASE_BYTESIZE
    INDEX_DATA
    DATAGASCOST
    (DEPTH	:binary	:array[2])
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
    P           POWER)
