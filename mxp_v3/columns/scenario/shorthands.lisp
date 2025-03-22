(module mxp_v3)


(defun  (mxp-scenario-shorthand---scenario-sum)
  (+    (mxp-scenario-shorthand---no-state-update)
	(mxp-scenario-shorthand---state-update)
	))

(defun  (mxp-scenario-shorthand---no-state-update)
  (+    MSIZE
	TRIVIAL
	MXPX
	;; STATE_UPDATE_WORD_PRICING
	;; STATE_UPDATE_BYTE_PRICING
	))

(defun  (mxp-scenario-shorthand---state-update)
  (+    ;; MSIZE
        ;; TRIVIAL
        ;; MXPX
        STATE_UPDATE_WORD_PRICING
        STATE_UPDATE_BYTE_PRICING
        ))

(defun  (mxp-scenario-shorthand---not-msize-nor-trivial)
  (+    (mxp-scenario-shorthand---state-update)
	MXPX
	))

(defun  (mxp-scenario-shorthand---not-msize)
  (+    (mxp-scenario-shorthand---not-msize-nor-trivial)
	  TRIVIAL
	  ))
