(module hub)

(defperspective storage

	;; selector
	PEEK_AT_STORAGE

	;; storage-row columns
	(
		( ADDRESS_HI                      :i32  )
		( ADDRESS_LO                      :i128 )
		( DEPLOYMENT_NUMBER               :i16  )
		( STORAGE_KEY_HI                  :i128 )
		( STORAGE_KEY_LO                  :i128 )
		( VALUE_ORIG_HI                   :i128 )
		( VALUE_ORIG_LO                   :i128 )
		( VALUE_CURR_HI                   :i128 )
		( VALUE_CURR_LO                   :i128 )
		( VALUE_NEXT_HI                   :i128 )
		( VALUE_NEXT_LO                   :i128 )

		( WARMTH                          :binary@prove )
		( WARMTH_NEW                      :binary@prove )

		( VALUE_ORIG_IS_ZERO              :binary ) ;; @prove not required, they are set manually
		( VALUE_CURR_IS_ORIG              :binary )
		( VALUE_CURR_IS_ZERO              :binary )
		( VALUE_NEXT_IS_CURR              :binary )
		( VALUE_NEXT_IS_ZERO              :binary )
		( VALUE_NEXT_IS_ORIG              :binary )
		( VALUE_CURR_CHANGES              :binary )

		( SLOAD_OPERATION                 :binary@prove )
		( SSTORE_OPERATION                :binary@prove )
	))
