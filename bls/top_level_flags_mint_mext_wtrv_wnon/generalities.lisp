(module bls)

(defun (malformed_data)
    (+ MINT MEXT))

(defun (wellformed_data)
    (+ WTRV WNON))

(defun (case_data_sum)
    (+ (malformed_data)
       (wellformed_data)))