(module oob)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;; 2.1 shorthands and  ;;
;;     constants       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst 
  C_JUMP        0x56
  C_JUMPI       0x57
  C_RDC         0x3E
  C_CDL         0x35
  C_CALL        0xCA
  C_CREATE      0xCE
  C_SSTORE      0x55
  C_RETURN      0xF3
  CT^INF_JUMP   0
  CT^INF_JUMPI  1
  CT^INF_RDC    2
  CT^INF_CDL    0
  CT^INF_CALL   1
  CT^INF_CREATE 2
  CT^INF_SSTORE 0
  CT^INF_RETURN 0)

(defun (flag_sum)
  (+ IS_JUMP IS_JUMPI IS_RDC IS_CDL IS_CALL IS_CREATE IS_SSTORE IS_RETURN))

(defun (wght_sum)
  (+ (* C_JUMP IS_JUMP)
     (* C_JUMPI IS_JUMPI)
     (* C_RDC IS_RDC)
     (* C_CDL IS_CDL)
     (* C_CALL IS_CALL)
     (* C_CREATE IS_CREATE)
     (* C_SSTORE IS_SSTORE)
     (* C_RETURN IS_RETURN)))

(defun (maxct_sum)
  (+ (* CT^INF_JUMP IS_JUMP)
     (* CT^INF_JUMPI IS_JUMPI)
     (* CT^INF_RDC IS_RDC)
     (* CT^INF_CDL IS_CDL)
     (* CT^INF_CALL IS_CALL)
     (* CT^INF_CREATE IS_CREATE)
     (* CT^INF_SSTORE IS_SSTORE)
     (* CT^INF_RETURN IS_RETURN)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.2 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint first-row (:domain {0})
  (vanishes! STAMP))

(defconstraint h2 ()
  (if-zero STAMP
           (all! (vanishes! CT)
                 (vanishes! CT_MAX)
                 (vanishes! (+ WCP ADD (flag_sum))))))

(defconstraint stamp-increments ()
  (any! (remained-constant! STAMP) (did-inc! STAMP 1)))

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


