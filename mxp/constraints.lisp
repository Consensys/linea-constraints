(module mxp)

(defconst
  MEM_EXT_TYPE_0          10
  SHORTCYCLE              3
  LONGCYCLE               16)



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


