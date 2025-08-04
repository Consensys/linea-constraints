(module rlptxn)

(defun (limb-unconditionally-partakes-in-lx) 
(force-bin (+
        ;; IS_RLP_PREFIX              
        IS_CHAIN_ID                
        IS_NONCE                   
        IS_GAS_PRICE               
        IS_MAX_PRIORITY_FEE_PER_GAS
        IS_MAX_FEE_PER_GAS         
        IS_GAS_LIMIT               
        IS_TO                      
        IS_VALUE                   
        IS_DATA                    
        IS_ACCESS_LIST             
        ;; IS_BETA                    
        ;; IS_Y                       
        ;; IS_R                       
        ;; IS_S                       
    )))

(defun (limb-unconditionally-partakes-in-lt) 
(force-bin (+
        (limb-unconditionally-partakes-in-lx)            
        IS_Y                       
        IS_R                       
        IS_S                       
    )))

(defproperty lc-lt-lx-binaries 
    (begin  
    (is-binary LC)
    (is-binary LX)
    (is-binary LT)))

(defconstraint ct-constancies-for-lt-lx ()
    (begin
    (counter-constant LT            CT)
    (counter-constant LX            CT)))

(defconstraint setting-lt-lx-for-most-phases ()
    (if-not-zero (limb-unconditionally-partakes-in-lt)
        (begin
        (eq! LT (limb-unconditionally-partakes-in-lt))
        (eq! LX (limb-unconditionally-partakes-in-lx)))))

(defconstraint no-lc-outside-cmp () 
    (if-zero CMP (vanishes! LC)))

(defproperty no-lt-lx-in-padding 
    (if-zero (phase-flag-sum) 
        (begin 
        (vanishes! LT)
        (vanishes! LX))))