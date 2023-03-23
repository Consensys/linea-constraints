(module mxp)

(defconst
  MEM_EXT_TYPE_0          10
  MEM_EXT_TYPE_1a         11
  MEM_EXT_TYPE_1b         12
  MEM_EXT_TYPE_2          13
  MEM_EXT_TYPE_3          14
  SHORTCYCLE              3
  LONGCYCLE               16)

(defunalias if-zero-else if-zero)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.1 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;; 2.1.1)
(defconstraint first-row (:domain {0}) (vanishes STAMP))

;; 2.1.2)
(defconstraint stamp-increments ()
  (vanishes (* (remains-constant STAMP)
               (inc STAMP 1))))

;; 2.1.3)
(defconstraint zeroRow (:guard (is-zero STAMP))
  (begin
   (vanishes ROOB)
   (vanishes NOOP)
   (vanishes MSIZE)
   (vanishes MSIZE_NEW)
   (vanishes MXC)
   (vanishes MXC_NEW)
   (vanishes COMP)
   (vanishes MAX_OFFSET)
   (vanishes MXE)))

;; 2.1.4)
(defconstraint counterReset ()
  (if-not-zero (remains-constant STAMP)
    (vanishes (next CT))))

;; 2.1.5
(defconstraint heartBeatOnMemExtType0 ()
  (if-not-zero STAMP
    (if-eq MXT MEM_EXT_TYPE_0
      (begin 
        (= ROOB 0)
        (= NOOP 1)
        (= MXX 0)
        (inc STAMP 1)
      ))))

;; 2.1.6
(defconstraint ridiculouslyOutOfBounds ()
  (if-not-zero STAMP
    (if-eq ROOB 1
      (begin 
        (= MXX 1)
        (inc STAMP 1)
      ))))

;; 2.1.7
(defconstraint noop ()
  (if-not-zero STAMP
    (if-zero ROOB
      (if-eq NOOP 1
        (begin 
          (= CT 0)
          (= MXX 0)
          (inc STAMP 1)
        )))))

(defun (loopBody maxCT)
      (if-eq-else CT maxCT
        (inc STAMP 1)
        (begin
          (inc CT 1)
          (remains-constant STAMP)
          (remains-constant MXX))))

;; 2.1.8
(defconstraint realInstruction ()
  (if-not-zero STAMP
    (if-zero ROOB
      (if-zero NOOP
        (if-not-zero (- MXT MEM_EXT_TYPE_0)
          (begin 
            (if-zero MXX 
              (loopBody SHORTCYCLE))
            (if-eq MXX 1 
              (loopBody LONGCYCLE))))))))

;; 2.1.9
(defconstraint dontTerminateMidInstruction (:domain {-1})
  (if-not-zero STAMP
    (if-zero ROOB
      (if-not-zero (- MXT MEM_EXT_TYPE_0)
      (if-zero MXX 
        (= CT SHORTCYCLE)
        (= CT LONGCYCLE))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.2 counter constancy    ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.2.1
(defconstraint counter-constancy ()
  (begin
   (counter-constancy CT COMP)
   (counter-constancy CT MXE)
   (counter-constancy CT MSIZE)
   (counter-constancy CT MSIZE_NEW)
   (counter-constancy CT MXC)
   (counter-constancy CT MXC_NEW)))


;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.3 ROOB flag    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;; 2.3.1
(defconstraint roob-initial-value (:domain {0}) (vanishes ROOB))


;; 2.3.2
(defconstraint roob-when-mem-ext-type0 ()
  (if-eq MXT MEM_EXT_TYPE_0
    (vanishes ROOB)))

;; 2.3.3
(defconstraint roob-when-mem-ext-type1 ()
  (if-zero (* (- MXT MEM_EXT_TYPE_1a) (- MXT MEM_EXT_TYPE_1b))
    (if-zero-else VAL_1_HI
      (= ROOB 0)
      (= ROOB 1))))

(defun (is-non-zero value) (if-zero value 1 0))

(defun (ridiculous-offset-size OFFSET_HI SIZE_LO SIZE_HI)
     (either 
      (is-non-zero SIZE_HI)
      (is-non-zero (* OFFSET_HI SIZE_LO))))

;; 2.3.4
(defconstraint roob-when-mem-ext-type2 ()
  (if-eq MXT MEM_EXT_TYPE_2
    (= ROOB (is-non-zero
      (ridiculous-offset-size VAL_1_HI VAL_3_LO VAL_3_HI)))))

;; 2.3.5
(defconstraint roob-when-mem-ext-type3 ()
  (if-eq MXT MEM_EXT_TYPE_3
    (= ROOB (is-non-zero (either 
        (ridiculous-offset-size VAL_1_HI VAL_3_LO VAL_3_HI)
        (ridiculous-offset-size VAL_2_HI VAL_4_LO VAL_4_HI))))))
