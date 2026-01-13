(defun (rlp-auth-into-hub-activation-flag) rlpauth.xtern * rlpauth.authority_ecrecover_success)

(defclookup
    (rlp-auth-into-hub :unchecked)
    ;; target columns
    (
        ;; TODO: substitute with actual columns
        hub.TX_AUTH
        hub.PEEK_AT_AUTH
        (:: hub.AUTHORITY_HI hub.AUTHORITY_LO)
        (:: hub.ADDRESS_HI hub.ADDRESS_LO)
        hub.ADDRESS_IS_ZERO_ADDRESS
        hub.AUTHORITY_NONCE
        hub.SENDER_IS_AUTHORITY
        (:: hub.CODEHASH_HI hub.CODEHASH_LO)
        hub.CODE_OF_AUTHORITY_IS_EMPTY_OR_DELEGATED
    )
    ;; source selector
    (rlp-auth-into-hub-activation-flag)
    ;; source columns
    (
        1
        1
        rlpauth.authority
        rlpauth.address
        rlpauth.address_is_zero_address
        rlpauth.authority_nonce
        rlpauth.sender_is_authority
        rlpauth.codehash
        rlpauth.code_of_authority_is_empty_or_delegated
    ))