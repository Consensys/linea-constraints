(module blockdata)

(defconstraint first-row (:domain {0})
  (vanishes! REL_BLOCK))

(defconstraint padding-is-padding ()
  (if-zero REL_BLOCK
           (begin (vanishes! FIRST_BLOCK_NUMBER)
                  (vanishes! INST))))

(defconstraint rel-block-increment ()
  (or! (will-remain-constant! REL_BLOCK) (will-inc! REL_BLOCK 1)))

(defconstraint new-block-reset-ct ()
  (if-not-zero (remained-constant! REL_BLOCK)
               (vanishes! CT)))

(defconstraint heartbeat (:guard REL_BLOCK)
  (begin (will-remain-constant! FIRST_BLOCK_NUMBER)
         (if-eq-else CT MAX_CT (will-inc! REL_BLOCK 1) (will-inc! CT 1))))

(defconstraint counter-constancies ()
  (begin (counter-constancy CT REL_TX_NUM_MAX)
         (counter-constancy CT COINBASE_HI)
         (counter-constancy CT COINBASE_LO)
         (counter-constancy CT BLOCK_GAS_LIMIT)
         (counter-constancy CT BASEFEE)))

(defconstraint horizontal-byte-dec ()
  (begin (eq! DATA_HI
              (+ (for i
                      [0 : LLARGEMO]
                      (* (^ 256 i) [BYTE_HI i]))))
         (eq! DATA_LO
              (+ (for i
                      [0 : LLARGEMO]
                      (* (^ 256 i) [BYTE_LO i]))))))

(defconstraint value-constraints (:guard (- REL_BLOCK (prev REL_BLOCK)))
  (begin  ; Coinbase
         (eq! (shift INST ROW_SHIFT_COINBASE) EVM_INST_COINBASE)
         (vanishes! (+ (for i
                            [4 : LLARGEMO]
                            (* (^ 256 i) (shift [BYTE_HI i] ROW_SHIFT_COINBASE)))))
         (eq! (shift DATA_HI ROW_SHIFT_COINBASE) COINBASE_HI)
         (eq! (shift DATA_LO ROW_SHIFT_COINBASE) COINBASE_LO)
         ; TIMESTAMP
         (eq! (shift INST ROW_SHIFT_TIMESTAMP) EVM_INST_TIMESTAMP)
         (if-not-zero (- REL_BLOCK 1)
                      (eq! (shift WCP_FLAG ROW_SHIFT_TIMESTAMP) 1))
         (vanishes! (shift DATA_HI ROW_SHIFT_TIMESTAMP))
         (vanishes! (+ (for i
                            [6 : LLARGEMO]
                            (* (^ 256 i) (shift [BYTE_LO i] ROW_SHIFT_TIMESTAMP)))))
         ; NUMBER
         (eq! (shift INST ROW_SHIFT_NUMBER) EVM_INST_NUMBER)
         (vanishes! (shift DATA_HI ROW_SHIFT_NUMBER))
         (vanishes! (+ (for i
                            [6 : LLARGEMO]
                            (* (^ 256 i) (shift [BYTE_LO i] ROW_SHIFT_NUMBER)))))
         (eq! (shift DATA_LO ROW_SHIFT_NUMBER)
              (+ FIRST_BLOCK_NUMBER (- REL_BLOCK 1)))
         ; DIIFICULTY
         (eq! (shift INST ROW_SHIFT_DIFFICULTY) EVM_INST_DIFFICULTY)
         (vanishes! (shift DATA_HI ROW_SHIFT_DIFFICULTY))
         ; GASLIMIT
         (eq! (shift INST ROW_SHIFT_GASLIMIT) EVM_INST_GASLIMIT)
         (vanishes! (shift DATA_HI ROW_SHIFT_GASLIMIT))
         (eq! (shift DATA_LO ROW_SHIFT_GASLIMIT) LINEA_BLOCK_GAS_LIMIT)
         (eq! BLOCK_GAS_LIMIT (shift DATA_LO ROW_SHIFT_GASLIMIT))
         ; CHAINID
         (eq! (shift INST ROW_SHIFT_CHAINID) EVM_INST_CHAINID)
         (vanishes! (shift DATA_HI ROW_SHIFT_CHAINID))
         (eq! (shift DATA_LO ROW_SHIFT_CHAINID) LINEA_CHAIN_ID)
         ; BASEFEE
         (eq! (shift INST ROW_SHIFT_BASEFEE) EVM_INST_BASEFEE)
         (vanishes! (shift DATA_HI ROW_SHIFT_BASEFEE))
         (eq! (shift DATA_LO ROW_SHIFT_BASEFEE) LINEA_BASE_FEE)
         (eq! BASEFEE (shift DATA_LO ROW_SHIFT_BASEFEE))))


