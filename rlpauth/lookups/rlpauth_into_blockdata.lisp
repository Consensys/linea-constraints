;; temporary dummy selector
(defun (rlp-auth-into-blockdata-activation-flag) 1)

(defclookup
    (rlp-auth-into-blockdata :unchecked)
    ;; target columns
    (
        blockdata.REL_BLOCK
        blockdata.IS_CHAINID
        (:: blockdata.DATA_HI blockdata.DATA_LO)
    )
    ;; source selector
    (rlp-auth-into-blockdata-activation-flag)
    ;; source columns
    (
        rlpauth.blk_number
        1
        rlpauth.network_chain_id
    ))