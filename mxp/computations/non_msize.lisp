(module mxp)


(defconstraint  computations---non-msize---ISZERO-test-for-SIZE_1
		(:guard   (mxp-guard---not-msize))
		(wcp-call-to-ISZERO   ROW_OFFSET___1ST_SIZE___ZERONESS_TEST
				      (mxp-shorthand---size-1-hi)
				      (mxp-shorthand---size-1-lo)
				      ))

(defconstraint  computations---non-msize---ISZERO-test-for-SIZE_2
		(:guard   (mxp-guard---not-msize))
		(wcp-call-to-ISZERO   ROW_OFFSET___2ND_SIZE___ZERONESS_TEST
				      (mxp-shorthand---size-2-hi)
				      (mxp-shorthand---size-2-lo)
				      ))

(defun   (mxp-shorthand---size-1-is-zero)      (shift computation/RES_A ROW_OFFSET___1ST_SIZE___ZERONESS_TEST))
(defun   (mxp-shorthand---size-2-is-zero)      (shift computation/RES_A ROW_OFFSET___2ND_SIZE___ZERONESS_TEST))
(defun   (mxp-shorthand---size-1-is-nonzero)   (-  1  (mxp-shorthand---size-1-is-zero)))
(defun   (mxp-shorthand---size-2-is-nonzero)   (-  1  (mxp-shorthand---size-2-is-zero)))

(defconstraint  computations---non-msize---setting-the-TRIVIAL-scenario-flag
		(:guard   (mxp-guard---not-msize))
		(eq!   scenario/TRIVIAL   (*   (mxp-shorthand---size-1-is-zero)
					       (mxp-shorthand---size-2-is-zero))))

(defconstraint  computations---non-msize---justifying-HUB-predictions---S1NZNOMXPX-and-S2NZNOMXPX
		(:guard   (mxp-guard---not-msize))
		(begin
		  (eq! (shift macro/MAY_TRIGGER_MMU NEGATIVE_ROW_OFFSET___SCNRI_TO_MACRO) (* (mxp-shorthand---size-1-is-nonzero) (- 1 scenario/MXPX)))
		  (eq! (shift macro/S1NZNOMXPX      NEGATIVE_ROW_OFFSET___SCNRI_TO_MACRO) (* (mxp-shorthand---size-1-is-nonzero) (- 1 scenario/MXPX)))
		  (eq! (shift macro/S2NZNOMXPX      NEGATIVE_ROW_OFFSET___SCNRI_TO_MACRO) (* (mxp-shorthand---size-2-is-nonzero) (- 1 scenario/MXPX)))
		  ))

