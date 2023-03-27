(module mxp)

(defconst
  SHORTCYCLE              3
  LONGCYCLE               16)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.1 counter constancy    ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2.2.1
(defconstraint counter-constancy ()
  (begin
   (counter-constancy CT OFFSET_1_LO)
   (counter-constancy CT OFFSET_1_HI)
   (counter-constancy CT OFFSET_2_LO)
   (counter-constancy CT OFFSET_2_HI)
   (counter-constancy CT SIZE_1_LO)
   (counter-constancy CT SIZE_1_HI)
   (counter-constancy CT SIZE_2_LO)
   (counter-constancy CT SIZE_2_HI)
   (counter-constancy CT WORDS)
   (counter-constancy CT WORDS_NEW)
   (counter-constancy CT MXPC)
   (counter-constancy CT MXPC_NEW)
   (counter-constancy CT INST)
   (counter-constancy CT COMP)
   (counter-constancy CT MXPX)
   (counter-constancy CT MXPE)))




;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.3 ROOB flag    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;; 2.3.1
(defconstraint roob-when-type-1 (:guard (= [TYPE 1] 1))
    (vanishes ROOB))

;; 2.3.2
(defconstraint roob-when-type-2-3 (:guard (is-not-zero (+ [TYPE 2] [TYPE 3])))
  (if-zero OFFSET_1_HI
    (vanishes ROOB)
    (is-not-zero ROOB)))

(defun (ridiculous-offset-size OFFSET_HI SIZE_LO SIZE_HI)
     (either 
      (is-not-zero SIZE_HI)
      (is-not-zero (either OFFSET_HI SIZE_LO))))

;; 2.3.4
(defconstraint roob-when-mem-4 (:guard (= [TYPE 4] 1))
    (= ROOB (is-not-zero
      (ridiculous-offset-size OFFSET_1_HI SIZE_1_LO SIZE_1_HI))))

;; 2.3.5
(defconstraint roob-when-mem-4 (:guard (= [TYPE 5] 1))
    (= ROOB (is-not-zero (either 
        (ridiculous-offset-size OFFSET_1_HI SIZE_1_LO SIZE_1_HI)
        (ridiculous-offset-size OFFSET_2_HI SIZE_2_LO SIZE_2_HI)))))




;; ;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                     ;;
;; ;;    2.4 NOOP flag    ;;
;; ;;                     ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; 2.4.1
;; (defconstraint noop-initial-value (:domain {0}) (vanishes NOOP))

;; ;; 2.4.2
;; (defconstraint noop-when-roob () (if-eq ROOB 1 (= NOOP 1)))

;; ;; 2.4.3
;; (defconstraint noop-when-no-roob () 
;;   (if-zero ROOB
;;     (begin 
;;       (if-eq MXT MEM_EXT_TYPE_0
;;         (= NOOP 1))
;;       (if-eq MXT MEM_EXT_TYPE_1a
;;         (vanishes NOOP))
;;       (if-eq MXT MEM_EXT_TYPE_1b
;;         (vanishes NOOP))
;;       (if-eq MXT MEM_EXT_TYPE_2
;;         (if-zero VAL_3_LO
;;           (= NOOP 1)
;;           (vanishes 0)))
;;       (if-eq MXT MEM_EXT_TYPE_3
;;         (begin
;;           (if-zero VAL_3_LO (if-zero VAL_4_LO (= NOOP 1)))
;;           (if-zero (either (is-not-zero VAL_3_LO)
;;                       (is-not-zero VAL_4_LO))
;;             (vanishes NOOP))))
;; )))

;; ;; 2.4.4
;; (defconstraint behaviour-when-noop () 
;;   (if-eq NOOP 1
;;     (begin
;;       (vanishes DELTA_MXC)
;;       (= MSIZE MSIZE_NEW)
;;       (= MXC MXC_NEW)
;;       (if-eq MXT MEM_EXT_TYPE_0 
;;         (begin
;;           (vanishes VAL_4_HI)
;;           (= VAL_4_LO MSIZE))))))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.1 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; 2.1.1)
;; (defconstraint first-row (:domain {0}) (vanishes STAMP))

;; ;; 2.1.2)
;; (defconstraint stamp-increments ()
;;   (vanishes (* (remains-constant STAMP)
;;                (inc STAMP 1))))

;; ;; 2.1.3)
;; (defconstraint zeroRow (:guard (is-zero STAMP))
;;   (begin
;;    (vanishes ROOB)
;;    (vanishes NOOP)
;;    (vanishes MSIZE)
;;    (vanishes MSIZE_NEW)
;;    (vanishes MXC)
;;    (vanishes MXC_NEW)
;;    (vanishes COMP)
;;    (vanishes MAX_OFFSET)
;;    (vanishes MXE)))

;; ;; 2.1.4)
;; (defconstraint counterReset ()
;;   (if-not-zero (remains-constant STAMP)
;;     (vanishes (next CT))))

;; ;; 2.1.5
;; (defconstraint heartBeatOnMemExtType0 ()
;;   (if-not-zero STAMP
;;     (if-eq MXT MEM_EXT_TYPE_0
;;       (begin 
;;         (= ROOB 0)
;;         (= NOOP 1)
;;         (= MXPX 0)
;;         (inc STAMP 1)
;;       ))))

;; ;; 2.1.6
;; (defconstraint ridiculouslyOutOfBounds ()
;;   (if-not-zero STAMP
;;     (if-eq ROOB 1
;;       (begin 
;;         (= MXPX 1)
;;         (inc STAMP 1)
;;       ))))

;; ;; 2.1.7
;; (defconstraint noop ()
;;   (if-not-zero STAMP
;;     (if-zero ROOB
;;       (if-eq NOOP 1
;;         (begin 
;;           (= CT 0)
;;           (= MXPX 0)
;;           (inc STAMP 1)
;;         )))))

;; (defun (loopBody maxCT)
;;       (if-eq-else CT maxCT
;;         (inc STAMP 1)
;;         (begin
;;           (inc CT 1)
;;           (remains-constant STAMP)
;;           (remains-constant MXPX))))

;; ;; 2.1.8
;; (defconstraint realInstruction ()
;;   (if-not-zero STAMP
;;     (if-zero ROOB
;;       (if-zero NOOP
;;         (if-not-zero (- MXT MEM_EXT_TYPE_0)
;;           (begin 
;;             (if-zero MXPX 
;;               (loopBody SHORTCYCLE))
;;             (if-eq MXPX 1 
;;               (loopBody LONGCYCLE))))))))

;; ;; 2.1.9
;; (defconstraint dontTerminateMidInstruction (:domain {-1})
;;   (if-not-zero STAMP
;;     (if-zero ROOB
;;       (if-not-zero (- MXT MEM_EXT_TYPE_0)
;;       (if-zero MXPX 
;;         (= CT SHORTCYCLE)
;;         (= CT LONGCYCLE))))))




;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                               ;;
;; ;;    2.5 Byte decompositions    ;;
;; ;;                               ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; 2.5.1
;; (defconstraint byte-decompositions ()
;;   (for k [0:6] 
;;     (begin 
;;       (if-zero CT
;;         (= [ACC k] [BYTE k])
;;         (= [ACC k] (+ (* 256 (prev [ACC k])) [BYTE k]))))))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                               ;;
;; ;;    Specialized constraints    ;;
;; ;;                               ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (defun (standard-regime)
;;   (begin
;;     (is-not-zero STAMP)
;;     (vanishes NOOP)
;;     (vanishes ROOB)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;;    2.6 Max offsets    ;;
;; ;;                       ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; 2.6.1
;; (defconstraint max-offset-type-1a (:guard (standard-regime))
;;   (if-eq MXT MEM_EXT_TYPE_1a
;;     (begin
;;       (= LAST_OFFSET_1 (+ VAL_1_LO 31))
;;       (vanishes LAST_OFFSET_2))))

;; ;; 2.6.2
;; (defconstraint max-offset-type-1b (:guard (standard-regime))
;;   (if-eq MXT MEM_EXT_TYPE_1a
;;     (begin
;;       (= LAST_OFFSET_1 VAL_1_LO)
;;       (vanishes LAST_OFFSET_2))))

;; ;; 2.6.3
;; (defconstraint max-offset-type-2 (:guard (standard-regime))
;;   (if-eq MXT MEM_EXT_TYPE_1a
;;     (begin
;;       (= LAST_OFFSET_1 (+ VAL_1_LO (- VAL_3_LO 1)))
;;       (vanishes LAST_OFFSET_2))))
  
;; ;; 2.6.4
;; (defconstraint max-offset-type-3 (:guard (standard-regime))
;;   (if-eq MXT MEM_EXT_TYPE_1a
;;     (begin
;;       (if-zero VAL_3_LO
;;         (vanishes LAST_OFFSET_1)
;;         (= LAST_OFFSET_1 (+ VAL_1_LO (- VAL_3_LO 1))))
;;       (if-zero VAL_4_LO
;;         (vanishes LAST_OFFSET_2)
;;         (= LAST_OFFSET_2 (+ VAL_2_LO (- VAL_4_LO 1)))))))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                                    ;;
;; ;;    2.7 Offsets are out of bonds    ;;
;; ;;                                    ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;; 2.7.1
;; (defconstraint offsets-out-of-bonds (:guard (standard-regime))
;;   (if-eq MXPX 1
;;     (if-eq CT LONGCYCLE
;;       (vanishes (*
;;         (- (- LAST_OFFSET_1 256) [ACC 1])
;;         (- (- LAST_OFFSET_2 256) [ACC 2]))))))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                                   ;;
;; ;;    2.8 Offsets are in of bonds    ;;
;; ;;                                   ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (defun (offsets-are-in-bounds)
;;   (begin
;;     (vanishes MXPX)
;;     (= CT SHORTCYCLE)))

;; ;; 2.8.1
;; (defconstraint number-of-evm-words (:guard (and (standard-regime) (offsets-are-in-bounds)))
;;   (if-eq MXT MEM_EXT_TYPE_2
;;    (begin
;;      (= VAL_3_LO (- (* 32 [ACC 0]) (shift [BYTE 7] -2)))
;;      (= (shift [BYTE 7] -3) (+ 224 (shift [BYTE 7] -2)))))) ; 224 == 256 - 32

;; ;; 2.8.2
;; (defconstraint offsets-are-small (:guard (and (standard-regime) (offsets-are-in-bounds)))
;;   (begin 
;;     (= [ACC 1] LAST_OFFSET_1)
;;     (= [ACC 2] LAST_OFFSET_2)
;;   ))

;; ;; 2.8.3
;; (defconstraint comp-offsets (:guard (and (standard-regime) (offsets-are-in-bounds)))
;;   (= [ACC 3] (
;;     + (*  (- LAST_OFFSET_1 LAST_OFFSET_2)
;;           (- (* 2 COMP) 1))
;;       (- COMP 1))))

;; ;; 2.8.4
;; (defconstraint define-max-offset (:guard (and (standard-regime) (offsets-are-in-bounds)))
;;   (= MAX_OFFSET 
;;     (+  (* COMP LAST_OFFSET_1)
;;         (* (- 1 COMP) LAST_OFFSET_2))))

;; ;; 2.8.5
;; (defconstraint mem-expansion-took-place (:guard (and (standard-regime) (offsets-are-in-bounds)))
;;   (= [ACC 4]
;;     (-  (*  (- (+ MAX_OFFSET 1)
;;                MSIZE)
;;             (- (* 2 MXE)
;;                1)
;;         MXE))))

;; ;; 2.8.6
;; (defconstraint expansion-simple (:guard (and (standard-regime) (offsets-are-in-bounds)))
;;   (if-zero MXE
;;     (begin
;;       (= MSIZE_NEW MSIZE)
;;       (vanishes MXC))
;;     (= MSIZE_NEW (+ MAX_OFFSET 1))))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;;    2.9 Cost update    ;;
;; ;;                       ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (defun (expansion-happened)
;;   (begin
;;     (offsets-are-in-bounds)
;;     (= MXE 1)))

;; ;; 2.9.1
;; (defconstraint euclidean-div-msize (:guard (and (standard-regime) (expansion-happened)))
;;   (begin
;;     (= MSIZE_NEW (- (* 32 [ACC 5]) [BYTE 7]))
;;     (= (prev [BYTE 7]) (+ [BYTE 7] 224) ))) ; 224 == 256 - 32


