(module hub)

(defun (dup-no-stack-exceptions)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (* PEEK_AT_STACK
     stack/DUP_FLAG
     (- 1 stack/SUX stack/SOX)))
