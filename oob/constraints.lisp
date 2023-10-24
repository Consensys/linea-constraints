(module oob)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3 counter constancy    ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint counter-constancy ()
  (begin (counter-constancy CT STAMP)
         (for i [2] (counter-constancy CT [OOB_EVENT i]))
         (for i [6] (counter-constancy CT [INCOMING_DATA i]))
         (counter-constancy CT INCOMING_INST)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.4 binary constraints   ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These constraints will be auto-generated due to the type of the columns
(defconstraint binary-constraints ()
  (begin (is-binary WCP)
         (is-binary ADD)
         (is-binary IS_JUMP)
         (is-binary IS_JUMPI)
         (is-binary IS_RDC)
         (is-binary IS_CDL)
         (is-binary IS_CALL)
         (is-binary IS_CREATE)
         (is-binary IS_SSTORE)
         (is-binary IS_RETURN)
         (for i [2] (is-binary [OOB_EVENT i]))))

(defconstraint wcp-add-are-exclusive ()
  (vanishes! (* WCP ADD)))

;; IS_CREATE = 0 => OOB_EVENT_2 = 0
(defconstraint is-create-oob-event ()
  (if-zero IS_CREATE
           (vanishes! OOB_EVENT_2)))


