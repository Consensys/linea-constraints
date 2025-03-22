(module mxp_v3)

(defconstraint  generalies---perspectives---computation---lookup-flag-exclusivity   (:guard COMPUTATION)
		(vanishes!   (*   computation/WCP_FLAG   computation/EUC_FLAG)))
