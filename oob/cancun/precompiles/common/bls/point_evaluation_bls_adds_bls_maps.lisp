(module oob)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                             
;;                                                                                     ;;
;;   For POINT_EVALUATION, BLS_G1ADD, BLS_G2ADD, BLS_MAP_FP_TO_G1, BLS_MAP_FP2_TO_G2   ;;
;;                                                                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---standard-precondition)     
                                                                    (+ IS_POINT_EVALUATION 
                                                                       IS_BLS_G1ADD 
                                                                       IS_BLS_G2ADD 
                                                                       IS_BLS_MAP_FP_TO_G1 
                                                                       IS_BLS_MAP_FP2_TO_G2))
(defun (fixed-cds) 
                                                                    (+  (* PRC_POINT_EVALUATION_SIZE  IS_POINT_EVALUATION)
                                                                        (* PRC_BLS_G1ADD_SIZE         IS_BLS_G1ADD)                                                                
                                                                        (* PRC_BLS_G2ADD_SIZE         IS_BLS_G2ADD)                                                       
                                                                        (* PRC_BLS_MAP_FP_TO_G1_SIZE  IS_BLS_MAP_FP_TO_G1)
                                                                        (* PRC_BLS_MAP_FP2_TO_G2_SIZE IS_BLS_MAP_FP2_TO_G2)))
(defun (fixed-gast-cost)
                                                                    (+  (* GAS_CONST_POINT_EVALUATION  IS_POINT_EVALUATION)
                                                                        (* GAS_CONST_BLS_G1ADD         IS_BLS_G1ADD)                                                                
                                                                        (* GAS_CONST_BLS_G2ADD         IS_BLS_G2ADD)                                                       
                                                                        (* GAS_CONST_BLS_MAP_FP_TO_G1  IS_BLS_MAP_FP_TO_G1)
                                                                        (* GAS_CONST_BLS_MAP_FP2_TO_G2 IS_BLS_MAP_FP2_TO_G2)))
(defun (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---precompile-cost)          (fixed-gast-cost))     
(defun (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---valid-cds)                (shift OUTGOING_RES_LO 2))
(defun (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---sufficient-gas)           (- 1 (shift OUTGOING_RES_LO 3)))

(defconstraint prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---check-cds-validity (:guard (* (assumption---fresh-new-stamp) (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---standard-precondition)))
  (call-to-EQ 2 0 (prc---cds) 0 (fixed-cds)))

(defconstraint prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---compare-call-gas-against-precompile-cost (:guard (* (assumption---fresh-new-stamp) (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---standard-precondition)))
  (call-to-LT 3 0 (prc---callee-gas) 0 (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---precompile-cost)))

(defconstraint prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---justify-hub-predictions (:guard (* (assumption---fresh-new-stamp) (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---standard-precondition)))
  (begin (eq! (prc---hub-success) (* (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---valid-cds) (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---sufficient-gas)))
         (if-zero (prc---hub-success)
                  (vanishes! (prc---return-gas))
                  (eq! (prc---return-gas)
                       (- (prc---callee-gas) (prc-pointevaluation-prc-blsg1add-prc-blsg2add-prc-blsmapfptog1-prc-blsmapfp2tog2---precompile-cost))))))
