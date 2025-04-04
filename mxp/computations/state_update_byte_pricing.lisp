(module mxp)


(defun  (mxp-shorthand---is-deploying)     (force-bin  (shift  macro/DEPLOYING    NEGATIVE_ROW_OFFSET___SCNRI_TO_MACRO)))
(defun  (mxp-shorthand---is-RETURN)        (force-bin  (shift  decoder/IS_RETURN  NEGATIVE_ROW_OFFSET___SCNRI_TO_DECDR)))
(defun  (mxp-shorthand---byte-price)       (shift               decoder/G_BYTE     NEGATIVE_ROW_OFFSET___SCNRI_TO_DECDR))
(defun  (mxp-shorthand---real-byte-price)  (if-zero     (mxp-shorthand---is-RETURN)
							;; IS_RETURN ≡ false i.e. macro/INST ≠ RETURN
							(mxp-shorthand---byte-price)
							;; IS_RETURN ≡ true i.e. macro/INST = RETURN
							(*  (mxp-shorthand---is-deploying)
							    (mxp-shorthand---byte-price))
							))
(defun  (mxp-shorthand---number-of-bytes)  (mxp-shorthand---size-1-lo))
(defun  (mxp-shorthand---extra-byte-cost)  (*   (mxp-shorthand---size-1-lo)
						(mxp-shorthand---real-byte-price)))


(defconstraint  computations---state-update---byte-pricing---justifying-the-memory-expansion-gas
		(:guard   (mxp-guard---state-update-word-pricing))
		(eq!      (shift  macro/GAS_MXP  NEGATIVE_ROW_OFFSET___SCNRI_TO_MACRO)
			  (+  (-  scenario/C_MEM_NEW  scenario/C_MEM)
			      (mxp-shorthand---extra-byte-cost))))
