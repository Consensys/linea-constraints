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
;;    2.2 ROOB flag    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;; 2.2.1
(defconstraint roob-when-type-1 (:guard (= [TYPE 1] 1))
    (vanishes ROOB))

;; 2.2.2
(defconstraint roob-when-type-2-3 (:guard (is-not-zero (+ [TYPE 2] [TYPE 3])))
  (if-zero OFFSET_1_HI
    (vanishes ROOB)
    (is-not-zero ROOB)))

(defun (ridiculous-offset-size OFFSET_HI SIZE_LO SIZE_HI)
     (either 
      (is-not-zero SIZE_HI)
      (is-not-zero (either OFFSET_HI SIZE_LO))))

;; 2.2.3
(defconstraint roob-when-mem-4 (:guard (= [TYPE 4] 1))
    (= ROOB (is-not-zero
      (ridiculous-offset-size OFFSET_1_HI SIZE_1_LO SIZE_1_HI))))

;; 2.2.4
(defconstraint roob-when-mem-5 (:guard (= [TYPE 5] 1))
    (= ROOB (is-not-zero (either 
        (ridiculous-offset-size OFFSET_1_HI SIZE_1_LO SIZE_1_HI)
        (ridiculous-offset-size OFFSET_2_HI SIZE_2_LO SIZE_2_HI)))))


;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.3 NOOP flag    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;; 2.3.1
(defconstraint noop-and-types (:guard (vanishes ROOB)) 
  (begin 
    (if-not-zero (+ (+ [TYPE 1] [TYPE 2]) [TYPE 3])
      (= NOOP [TYPE 1]))
    (if-eq [TYPE 4] 1
      (= NOOP (is-zero SIZE_1_LO)))
    (if-eq [TYPE 5] 1
      (= NOOP (is-zero (+ SIZE_1_LO SIZE_2_LO))))))


;; 2.3.2
(defconstraint noop-consequences (:guard (= NOOP 1))
  (begin 
    (vanishes DELTA_MXPC)
    (= WORDS_NEW WORDS)
    (= MXPC_NEW MXPC)))


;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.4 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;; 2.4.1)
(defconstraint first-row (:domain {0}) (vanishes STAMP))

;; 2.4.2)
(defconstraint stamp-increments ()
  (vanishes (* (remains-constant STAMP)
               (inc STAMP 1))))

;; 2.4.3)
(defconstraint stamp-is-zero (:guard (is-zero STAMP))
  (begin
   (vanishes (+ (+ ROOB NOOP) MXPX))
   (vanishes CT)
   (vanishes INST)))

;; 2.4.4)
(defconstraint only-one-type ()
  (= 1 (+ (+ (+ (+ [TYPE 1] [TYPE 2]) [TYPE 3]) [TYPE 4]) [TYPE 5])))

;; 2.4.5)
(defconstraint counter-reset ()
  (if-not-zero (remains-constant STAMP)
    (vanishes (next CT))))

;; 2.4.6)
(defconstraint roob-or-noop (:guard (is-not-zero (+ ROOB NOOP)))
  (begin
    (inc STAMP 1)
    (= MXPX ROOB)))

;; 2.4.7
(defconstraint real-instructions ()
  (if-not-zero STAMP
    (if-zero ROOB
      (if-zero NOOP
        (if-zero MXPX
          (if-eq-else CT SHORTCYCLE
            (inc STAMP 1)
            (inc CT 1))
          (if-eq-else CT LONGCYCLE
            (inc STAMP 1)
            (inc CT 1)))))))

;; 2.4.8
(defconstraint dont-terminate-mid-instructions (:domain {-1})
  (if-not-zero STAMP
    (if-zero ROOB
      (if-zero NOOP
        (if-zero MXPX 
          (= CT SHORTCYCLE)
          (= CT LONGCYCLE))))))



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


