(module hub)

(defperspective storage
	
	;; selector
	PEEK_AT_STORAGE
	
	;; storage-row columns
	(
		ADDRESS_HI
		ADDRESS_LO
		DEPLOYMENT_NUMBER
		DEPLOYMENT_NUMBER_INFTY
		STORAGE_KEY_HI
		STORAGE_KEY_LO
		VAL_ORIG_HI
		VAL_ORIG_LO
		VAL_CURR_HI
		VAL_CURR_LO
		VAL_NEXT_HI
		VAL_NEXT_LO

		( WARMTH                        :binary@prove )
		( WARMTH_NEW                    :binary@prove )

		( VAL_ORIG_IS_ZERO              :binary ) ;; @prove not required for any of these since set by hand
		( VAL_CURR_IS_ORIG              :binary )
		( VAL_CURR_IS_ZERO              :binary )
		( VAL_NEXT_IS_CURR              :binary )
		( VAL_NEXT_IS_ZERO              :binary )
		( VAL_NEXT_IS_ORIG              :binary )
		( VAL_CURR_CHANGES              :binary )
	))
