(module mxp)

(defconst
  MEM_EXT_TYPE_0          10)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.1 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.1.1)
(defconstraint forst-row (:domain {0}) (vanishes STAMP))

;; 2.1.2)
(defconstraint stampIncrements ()
  (vanishes (* (inc STAMP 0)
               (inc STAMP 1))))

;; 2.1.3)
(defconstraint zeroRow (:guard (is-zero STAMP))
  (begin
   (vanishes ROOB)
   (vanishes NOOP)
   (vanishes MSIZE)
   (vanishes MSIZE_NU)
   (vanishes MXC)
   (vanishes MXC_NU)
   (vanishes COMP)
   (vanishes MAX_OFFSET)
   (vanishes MXE)))

;; 2.1.4)
(defconstraint counterReset ()
  (if-not-zero (remains-constant STAMP)
    (vanishes (next CT))))

;; 2.1.5
(defconstraint memExtType0 ()
  (if-not-zero STAMP
    (if-eq MXT MEM_EXT_TYPE_0
      (begin 
        (= ROOB 0)
        (= NOOP 1)
        (= MXX 0)
        (= (next STAMP) (+ STAMP 1))
      ))))

;; 2.1.6
(defconstraint ridiculouslyOutOfBounds ()
  (if-not-zero STAMP
    (if-eq ROOB 1
      (begin 
        (= MXX 1)
        (= (next STAMP) (+ STAMP 1))
      ))))

;; 2.1.7
(defconstraint noop ()
  (if-not-zero STAMP
    (if-zero ROOB
      (if-eq NOOP 1
        (begin 
          (= CT 0)
          (= MXX 0)
          (= (next STAMP) (+ STAMP 1))
        )))))

