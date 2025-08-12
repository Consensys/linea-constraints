(module txndata)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                ;;
;;    X.Y.Y CMPTN-view columns    ;;
;;                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defperspective computation

	;; selector
	CMPTN

	;; CMPTN view columns
	(
         ( EUC_FLAG :binary@prove )
         ( WCP_FLAG :binary@prove )
         ( ARG_1_LO :i128         )
         ( ARG_2_LO :i128         )
         ( RES      :i128         )
         ( INST     :i8           )
         ))

