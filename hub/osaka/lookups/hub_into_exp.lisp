(defun (hub-into-exp-trigger)
  (* hub.PEEK_AT_MISCELLANEOUS
     hub.misc/EXP_FLAG))

(defclookup hub-into-exp
  ;; target columns
  (
   exp.INST
   exp.ARG
   exp.CDS
   exp.EBS
   exp.RES
  )
  ;; source selector
  (hub-into-exp-trigger)
  ;; source columns
  (
   ;; pseudo instruction
   hub.misc/EXP_INST
   ;; primary argument
   (:: [hub.misc/EXP_DATA 1] [hub.misc/EXP_DATA 2])
   ;; precondition: 1 <= CDS <= 32
   (i6 [hub.misc/EXP_DATA 3])
   ;; precondition: 1 <= EBS <= 32
   (i6 [hub.misc/EXP_DATA 4])
   ;; result
   [hub.misc/EXP_DATA 5]
  )
)
