(module oob)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                             
;;                                    ;;                                                 
;;   For BLS_G1_MSM and BLS_G2_MSM    ;;
;;                                    ;;                                                 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (prc-g1msm-prc-g2msm---standard-precondition)     
                                                                    (+ IS_BLS_G1MSM 
                                                                       IS_BLS_G2MSM))
(defun (min-msm-size) 
                                                                    (+  (* PRC_BLS_G1MSM_SIZE_MIN             IS_BLS_G1MSM)                                                                
                                                                        (* PRC_BLS_G2MSM_SIZE_MIN             IS_BLS_G2MSM)))
(defun (max-discount) 
                                                                    (+  (* PRC_BLS_G1MSM_MAX_DISCOUNT         IS_BLS_G1MSM)                                                                
                                                                        (* PRC_BLS_G2MSM_MAX_DISCOUNT         IS_BLS_G2MSM)))
(defun (msm-multiplication-cost) 
                                                                    (+  (* PRC_BLS_G1MSM_MULTIPLICATION_COST  IS_BLS_G1MSM)                                                                
                                                                        (* PRC_BLS_G2MSM_MULTIPLICATION_COST  IS_BLS_G2MSM)))
(defun (prc-g1msm-prc-g2msm---remainder)                                               (shift OUTGOING_RES_LO 2))
(defun (prc-g1msm-prc-g2msm---cds-is-multiple-of-min-msm-size)                         (shift OUTGOING_RES_LO 3))
(defun (prc-g1msm-prc-g2msm---num-inputs_min-msm-size)                                 (prc---cds))
(defun (prc-g1msm-prc-g2msm---num-inputs-gt-128)                                       (shift OUTGOING_RES_LO 4))
(defun (prc-g1msm-prc-g2msm---num-inputs-leq-128)                                      (- 1 (prc-g1msm-prc-g2msm---num-inputs-gt-128)))
(defun (prc-g1msm-prc-g2msm---discount)                                                (shift OUTGOING_RES_LO 5))
(defun (prc-g1msm-prc-g2msm---insufficient-gas)                                        (shift OUTGOING_RES_LO 6))
(defun (prc-g1msm-prc-g2msm---sufficient-gas)                                          (- 1 (prc-g1msm-prc-g2msm---insufficient-gas)))
(defun (prc-g1msm-prc-g2msm---precompile-cost_min-msm-size_PRC_BLS_MULTIPLICATION_MULTIPLIER)       (* (prc-g1msm-prc-g2msm---num-inputs_min-msm-size) (msm-multiplication-cost) (prc-g1msm-prc-g2msm---discount)))                       



(defconstraint prc-g1msm-prc-g2msm---mod-cds-by-min-msm-size (:guard (* (assumption---fresh-new-stamp) (prc-g1msm-prc-g2msm---standard-precondition)))
  (call-to-MOD 2 0 (prc---cds) 0 (min-msm-size)))

(defconstraint prc-g1msm-prc-g2msm---check-remainder-is-zero (:guard (* (assumption---fresh-new-stamp) (prc-g1msm-prc-g2msm---standard-precondition)))
  (call-to-ISZERO 3 0 (prc-g1msm-prc-g2msm---remainder)))

(defconstraint prc-g1msm-prc-g2msm---compare-num-inputs-against-128 (:guard (* (assumption---fresh-new-stamp) (prc-g1msm-prc-g2msm---standard-precondition)))
  (if-zero (prc-g1msm-prc-g2msm---cds-is-multiple-of-min-msm-size)
           (noCall 4)
           (begin (vanishes! (shift ADD_FLAG 4))
                  (vanishes! (shift MOD_FLAG 4))
                  (eq! (shift WCP_FLAG 4) 1)
                  (vanishes! (shift BLS_REF_TABLE_FLAG 4))
                  (eq! (shift OUTGOING_INST 4) EVM_INST_GT)
                  (vanishes! (shift [OUTGOING_DATA 1] 4))
                  (eq! (* (shift [OUTGOING_DATA 2] 4) (min-msm-size)) (prc-g1msm-prc-g2msm---num-inputs_min-msm-size))
                  (vanishes! (shift [OUTGOING_DATA 3] 4))
                  (eq! (shift [OUTGOING_DATA 4] 4) 128))))

(defconstraint prc-g1-msm-prc-g2-msm---compute-discount (:guard (* (assumption---fresh-new-stamp) (prc-g1msm-prc-g2msm---standard-precondition)))
  (if-zero (prc-g1msm-prc-g2msm---cds-is-multiple-of-min-msm-size)
           (noCall 5)
           (if-not-zero (prc-g1msm-prc-g2msm---num-inputs-leq-128)
                    (begin (vanishes! (shift ADD_FLAG 5))
                           (vanishes! (shift MOD_FLAG 5))
                           (vanishes! (shift WCP_FLAG 5))
                           (eq!       (shift BLS_REF_TABLE_FLAG 5) 1)
                           (eq! (shift OUTGOING_INST 5) (wght-sum-prc-bls))
                           (eq! (* (shift [OUTGOING_DATA 1] 5) (min-msm-size)) (prc-g1msm-prc-g2msm---num-inputs_min-msm-size))
                           (vanishes! (shift [OUTGOING_DATA 2] 5))
                           (vanishes! (shift [OUTGOING_DATA 3] 5))
                           (vanishes! (shift [OUTGOING_DATA 4] 5)))
                    (begin (noCall 5)
                           (eq! (prc-g1msm-prc-g2msm---discount) (max-discount)))))) 
                             
(defconstraint prc-g1msm-prc-g2msm---compare-call-gas-against-precompile-cost (:guard (* (assumption---fresh-new-stamp) (prc-g1msm-prc-g2msm---standard-precondition)))
  (if-zero (prc-g1msm-prc-g2msm---cds-is-multiple-of-min-msm-size)
           (noCall 6)
           (begin (vanishes! (shift ADD_FLAG 6))
                  (vanishes! (shift MOD_FLAG 6))
                  (eq! (shift WCP_FLAG 6) 1)
                  (vanishes! (shift BLS_REF_TABLE_FLAG 6))
                  (eq! (shift OUTGOING_INST 6) EVM_INST_LT)
                  (vanishes! (shift [OUTGOING_DATA 1] 6))
                  (eq! (shift [OUTGOING_DATA 2] 6) (prc---callee-gas))
                  (vanishes! (shift [OUTGOING_DATA 3] 6))
                  (eq! (* (shift [OUTGOING_DATA 4] 6) (min-msm-size) PRC_BLS_MULTIPLICATION_MULTIPLIER)
                       (prc-g1msm-prc-g2msm---precompile-cost_min-msm-size_PRC_BLS_MULTIPLICATION_MULTIPLIER)))))

(defconstraint prc-g1msm-prc-g2msm---justify-hub-predictions (:guard (* (assumption---fresh-new-stamp) (prc-g1msm-prc-g2msm---standard-precondition)))
  (begin (eq! (prc---hub-success)
              (* (prc---cds-is-non-zero) (prc-g1msm-prc-g2msm---cds-is-multiple-of-min-msm-size) (prc-g1msm-prc-g2msm---sufficient-gas)))
         (if-zero (prc---hub-success)
                  (vanishes! (prc---return-gas))
                  (eq! (* (prc---return-gas) (min-msm-size) PRC_BLS_MULTIPLICATION_MULTIPLIER)
                       (- (* (prc---callee-gas) (min-msm-size) PRC_BLS_MULTIPLICATION_MULTIPLIER) (prc-g1msm-prc-g2msm---precompile-cost_min-msm-size_PRC_BLS_MULTIPLICATION_MULTIPLIER))))))
