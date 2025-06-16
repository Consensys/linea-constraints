(module mxpcan)

(defconstraint    counter-constancies   ()
		  (begin
		    (counter-constancy  CT  CT_MAX                     )
		    (counter-constancy  CT  (mxp-perspective-wght-sum) )
		    ))
