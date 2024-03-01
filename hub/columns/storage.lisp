(module hub)

(defperspective storage
	
	;; selector
	PEEK_AT_STORAGE
	
	;; storage-row columns
	(
		( ADDRESS_HI                    :i32          )
		( ADDRESS_LO                    :i128         )
		( DEPLOYMENT_NUMBER             :i16          ) ;; likely still overkill, deployments cost a minimum of 32k gas ...
		( DEPLOYMENT_NUMBER_INFTY       :i16          ) ;; likely still overkill, deployments cost a minimum of 32k gas ...
		( STORAGE_KEY_HI                :i128         )
		( STORAGE_KEY_LO                :i128         )
		( VAL_ORIG_HI                   :i128         )
		( VAL_ORIG_LO                   :i128         )
		( VAL_CURR_HI                   :i128         )
		( VAL_CURR_LO                   :i128         )
		( VAL_NEXT_HI                   :i128         )
		( VAL_NEXT_LO                   :i128         )
		( WARM                          :binary@prove )
		( WARM_NEW                      :binary@prove )
		( VAL_ORIG_IS_ZERO              :binary@prove ) ;; likely unnecessary to prove (set by hand)
		( VAL_NEXT_IS_ZERO              :binary@prove ) ;; likely unnecessary to prove (set by hand)
		( VAL_NEXT_IS_CURR              :binary@prove ) ;; likely unnecessary to prove (set by hand)
		( VAL_NEXT_IS_ORIG              :binary@prove ) ;; likely unnecessary to prove (set by hand)
		( VAL_CURR_IS_ZERO              :binary@prove ) ;; likely unnecessary to prove (set by hand)
		( VAL_CURR_IS_ORIG              :binary@prove ) ;; likely unnecessary to prove (set by hand)
		( VAL_CURR_CHANGES              :binary@prove ) ;; likely unnecessary to prove (set by hand)
	))
