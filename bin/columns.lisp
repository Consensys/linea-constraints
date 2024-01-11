(module bin)

(defcolumns
    BINARY_STAMP
    (ONE_LINE_INSTRUCTION :binary)
    COUNTER
    INST
    ARGUMENT_1_HI
    ARGUMENT_1_LO
    ARGUMENT_2_HI
    ARGUMENT_2_LO
    RESULT_HI
    RESULT_LO
    (SMALL :binary)
    (BITS :binary)
    (BIT_B_4 :binary)
    (NEG :binary)
    LOW_4
    (BIT_1 :binary)
    PIVOT
    (BYTE_1 :BYTE)
    (BYTE_2 :BYTE)
    (BYTE_3 :BYTE)
    (BYTE_4 :BYTE)
    (BYTE_5 :BYTE)
    (BYTE_6 :BYTE)
    ACC_1
    ACC_2
    ACC_3
    ACC_4
    ACC_5
    ACC_6
    ;; decoded bytes:
    AND_BYTE_HI
    AND_BYTE_LO
    OR_BYTE_HI
    OR_BYTE_LO
    XOR_BYTE_HI
    XOR_BYTE_LO
    NOT_BYTE_HI
    NOT_BYTE_LO
    (IS_DATA :binary))

;; aliases
(defalias
    STAMP BINARY_STAMP
    OLI ONE_LINE_INSTRUCTION
    CT COUNTER
    ARG_1_HI ARGUMENT_1_HI
    ARG_1_LO ARGUMENT_1_LO
    ARG_2_HI ARGUMENT_2_HI
    ARG_2_LO ARGUMENT_2_LO
    RES_HI RESULT_HI
    RES_LO RESULT_LO)


    