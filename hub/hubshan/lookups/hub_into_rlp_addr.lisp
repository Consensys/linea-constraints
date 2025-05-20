(defun (hub-into-rlp-addr-trigger)
  (* hubshan.PEEK_AT_ACCOUNT
     hubshan.account/RLPADDR_FLAG))

;;
(deflookup hub-into-rlpaddr
           ;; target columns
	   (
	     rlpaddr.RECIPE
	     rlpaddr.ADDR_HI
	     rlpaddr.ADDR_LO
	     rlpaddr.NONCE
	     rlpaddr.DEP_ADDR_HI
	     rlpaddr.DEP_ADDR_LO
	     rlpaddr.SALT_HI
	     rlpaddr.SALT_LO
	     rlpaddr.KEC_HI
	     rlpaddr.KEC_LO
           )
           ;; source columns
	   (
	     (* hubshan.account/RLPADDR_RECIPE                         (hub-into-rlp-addr-trigger))
	     (* hubshan.account/ADDRESS_HI                             (hub-into-rlp-addr-trigger))
	     (* hubshan.account/ADDRESS_LO                             (hub-into-rlp-addr-trigger))
	     (* hubshan.account/NONCE                                  (hub-into-rlp-addr-trigger))
	     (* hubshan.account/RLPADDR_DEP_ADDR_HI                    (hub-into-rlp-addr-trigger))
	     (* hubshan.account/RLPADDR_DEP_ADDR_LO                    (hub-into-rlp-addr-trigger))
	     (* hubshan.account/RLPADDR_SALT_HI                        (hub-into-rlp-addr-trigger))
	     (* hubshan.account/RLPADDR_SALT_LO                        (hub-into-rlp-addr-trigger))
	     (* hubshan.account/RLPADDR_KEC_HI                         (hub-into-rlp-addr-trigger))
	     (* hubshan.account/RLPADDR_KEC_LO                         (hub-into-rlp-addr-trigger))
           )
)
