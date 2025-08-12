(module rlptxn)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                  ;;
;;    X.Y.Z.T AL_RLP_length_coundown constraints    ;;
;;                                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint    rlptxn---access-list---AL-rlp-length-countdown---update ()
                  (if-not-zero    (is-access-list-data)
                                  (did-dec!   (rlptxn---access-list---AL-rlp-length-countdown)
                                              (* LC cmp/LIMB_SIZE))))
