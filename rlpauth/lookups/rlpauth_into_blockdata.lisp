(defun (rlp-auth-into-blockdata-activation-flag) rlpauth.xtern)

(defclookup
    (rlp-auth-into-blockdata :unchecked)
    blockdata.IS_CHAINID
    ;; target columns
    (
        blockdata.REL_BLOCK
        ;; blockdata.IS_CHAINID
        (:: blockdata.DATA_HI blockdata.DATA_LO)
    )
    ;; source selector
    (rlp-auth-into-blockdata-activation-flag)
    ;; source columns
    (
        rlpauth.blk_number
        ;; 1
        rlpauth.network_chain_id
    ))