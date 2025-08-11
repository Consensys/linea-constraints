(module rlptxn)

(defun    (is-access-list-prefix)    (* (prev TXN)     IS_ACCESS_LIST))
(defun    (is-access-list-data)      (* (prev CMP) CMP IS_ACCESS_LIST))

(defun (AL-rlp-length-countdown)         cmp/AUX_1)
(defun (AL-item-rlp-length-countdown)    cmp/AUX_2)
(defun (AL-item-countdown)               cmp/AUX_CCC_1)
(defun (storage-key-countdown)           cmp/AUX_CCC_2)
(defun (storage-key-list-countdown)      cmp/AUX_CCC_3)
;;define outside of the module to be accessible by lookup files
;; (defun (rlptxn---AL-address-hi)          rlptxn.cmp/AUX_CCC_4)
;; (defun (rlptxn---AL-address-lo)          rlptxn.cmp/AUX_CCC_5)

(defun (storage-stuff)                   (force-bin (+ IS_PREFIX_OF_STORAGE_KEY_LIST IS_ACCESS_LIST_STORAGE_KEY)))
(defun (not-storage-stuff)               (force-bin (- 1 (storage-stuff))))
(defun (end-of-tuple-or-end-of-phase)    (* (storage-stuff) (next (not-storage-stuff))))
