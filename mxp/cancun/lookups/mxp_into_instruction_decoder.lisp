(defun (mxp-into-instruction-decoder-selector) mxp.DECODER) ;; ""

(deflookup hub-into-instdecoder
           ;;
           ;; target columns
           ;;
	   (
	     instdecoder_cancun.MXP_FLAG
	     instdecoder_cancun.OPCODE
	     instdecoder_cancun.IS_MSIZE
	     instdecoder_cancun.IS_RETURN
	     instdecoder_cancun.IS_MCOPY
	     instdecoder_cancun.IS_FIXED_SIZE_32
	     instdecoder_cancun.IS_FIXED_SIZE_1
	     instdecoder_cancun.IS_SINGLE_MAX_OFFSET
	     instdecoder_cancun.IS_DOUBLE_MAX_OFFSET
	     instdecoder_cancun.IS_WORD_PRICING
	     instdecoder_cancun.IS_BYTE_PRICING
	     instdecoder_cancun.BILLING_PER_WORD
	     instdecoder_cancun.BILLING_PER_BYTE
           )
           ;;
           ;; source columns
           ;;
	   (
	     (* 1                                   (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/INST                 (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/IS_MSIZE             (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/IS_RETURN            (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/IS_MCOPY             (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/IS_FIXED_SIZE_32     (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/IS_FIXED_SIZE_1      (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/IS_SINGLE_MAX_OFFSET (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/IS_DOUBLE_MAX_OFFSET (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/IS_WORD_PRICING      (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/IS_BYTE_PRICING      (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/G_WORD               (mxp-into-instruction-decoder-selector))
	     (* mxp.decoder/G_BYTE               (mxp-into-instruction-decoder-selector))
	     ;;
           )
)
