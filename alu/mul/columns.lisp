(module mul)

(defcolumns
    (MUL_STAMP :i3)
    (COUNTER :byte)
    (OLI :binary@prove)
    (TINY_BASE          :binary@prove)
    (TINY_EXPONENT      :binary@prove)
    (RESULT_VANISHES    :binary@prove)
    (INSTRUCTION :byte :display :opcode)
    (ARG_1_HI  :i16)
    (ARG_1_LO :i16)
    (ARG_2_HI :i16)
    (ARG_2_LO :i16)
    (RES_HI :i16)
    (RES_LO :i16)
    (BITS :binary@prove)
    ;==========================
    (BYTE_A_3 :byte@prove)    ACC_A_3
    (BYTE_A_2 :byte@prove)    ACC_A_2
    (BYTE_A_1 :byte@prove)    ACC_A_1
    (BYTE_A_0 :byte@prove)    ACC_A_0
    ;==========================
    (BYTE_B_3 :byte@prove)    ACC_B_3
    (BYTE_B_2 :byte@prove)    ACC_B_2
    (BYTE_B_1 :byte@prove)    ACC_B_1
    (BYTE_B_0 :byte@prove)    ACC_B_0
    ;==========================
    (BYTE_C_3 :byte@prove)    ACC_C_3
    (BYTE_C_2 :byte@prove)    ACC_C_2
    (BYTE_C_1 :byte@prove)    ACC_C_1
    (BYTE_C_0 :byte@prove)    ACC_C_0
    ;==========================
    (BYTE_H_3 :byte@prove)    ACC_H_3
    (BYTE_H_2 :byte@prove)    ACC_H_2
    (BYTE_H_1 :byte@prove)    ACC_H_1
    (BYTE_H_0 :byte@prove)    ACC_H_0
    ;==========================
    (EXPONENT_BIT               :binary@prove)
    EXPONENT_BIT_ACCUMULATOR
    (EXPONENT_BIT_SOURCE        :binary@prove)
    (SQUARE_AND_MULTIPLY        :binary@prove)
    (BIT_NUM :byte)
)

(defalias

    STAMP       MUL_STAMP
    CT          COUNTER
    INST        INSTRUCTION
    EBIT        EXPONENT_BIT
    EACC        EXPONENT_BIT_ACCUMULATOR
    ESRC        EXPONENT_BIT_SOURCE
    SNM         SQUARE_AND_MULTIPLY
    TINYB       TINY_BASE
    TINYE       TINY_EXPONENT
    RESV        RESULT_VANISHES)
