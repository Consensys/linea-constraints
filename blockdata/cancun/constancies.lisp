(module blockdata)

;;;;;;;;;;;;;;;;;;;;;;
;;                  ;;
;;  2.4 Contancies  ;;
;;                  ;;
;;;;;;;;;;;;;;;;;;;;;;

(defun   (conflation-constancy   COL)   (if-not-zero   IOMF
                                                       (will-remain-constant!   COL)))
(defun   (block-constancy        COL)   (if-not-zero   (-   (next   REL_BLOCK)   REL_BLOCK)
                                                       (will-remain-constant!   COL)))

(defconstraint   first-block-number-is-conflation-constant ()
                 (conflation-constancy   FIRST_BLOCK_NUMBER))

(defconstraint   block-constancies ()
                 (begin
                   (block-constancy COINBASE_HI     )
                   (block-constancy COINBASE_LO     )
                   (block-constancy BLOCK_GAS_LIMIT )
                   (block-constancy BASEFEE         )
                   (block-constancy TIMESTAMP       )
                   (block-constancy NUMBER          )
                   ))

(defconstraint   counter-constancies ()
                 (begin (counter-constancy CT DATA_HI)
                        (counter-constancy CT DATA_LO)
                        (counter-constancy CT (wght-sum))
                        ))

