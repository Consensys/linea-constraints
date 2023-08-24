(module rlpAddr)

(defconst
  create2_shift 0xff ;; create2 first byte
  list_short         0xc0      ;; RLP prefix for a short list
  int_short       0x80)      ;; RLP prefix for a number > 127

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    3 Heartbeat    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint first-row (:domain {0})
 (vanishes! STAMP))

(defconstraint stamp-increments ()
 (vanishes! (* (~ (- STAMP (prev STAMP)))
               (~ (- STAMP (+ (prev STAMP) 1))))))

(defconstraint ct-reset ()
 (if-not-zero (remained-constant! STAMP)
  (vanishes! ct)))

(defconstraint ct-increment ()
 (if-zero STAMP
  (vanishes! ct)
  (if-zero create2
    (if-eq-else ct 7
      (will-inc! STAMP 1)
      (will-inc! ct 1))
    (if-eq-else ct 5
      (will-inc! STAMP 1)
      (will-inc! ct 1)))))

(defconstraint last-row (:domain {-1})
  (if-zero create2
    (eq! ct 7)
    (eq! ct 5)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    4 Constancies    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint stamp-constancies ()
  (begin
   (stamp-constancy STAMP create2)
   (stamp-constancy STAMP ADDR_HI)
   (stamp-constancy STAMP ADDR_LO)
   (stamp-constancy STAMP NONCE)
   (stamp-constancy STAMP SALT_HI)
   (stamp-constancy STAMP SALT_LO)
   (stamp-constancy STAMP KEC_HI)
   (stamp-constancy STAMP KEC_LO)
   (stamp-constancy STAMP not_little)))

(defpurefun (ct-incrementing ct X)
 (if-not-zero ct 
  (vanishes! (* (~ (remained-constant! X))
               (~ (did-inc! X 1))))))
            
(defconstraint ct-incrementings ()
 (begin 
  (ct-incrementing ct INDEX)
  (ct-incrementing ct LC)))

(defconstraint binarity ()
 (begin
  (is-binary create2)
  (is-binary not_little)
  (is-binary BIT1)
  (is-binary LC)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    5 CREATE constraints      ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint create-byte-decomposition (:guard (- 1 create2))
 (if-zero ct
  (begin
    (eq! ACC BYTE1)
    (if-zero ACC
      (begin
        (vanishes! ACC_BYTESIZE)
        (eq! POWER (^ 256 8)))
      (begin 
        (eq! ACC_BYTESIZE 1)
        (eq! POWER (^ 256 7))))
    (eq! BIT_ACC BIT1))
  (begin
    (eq! ACC (+ (* 256 (prev ACC)
                   BYTE1)))
    (if-zero ACC
      (begin
        (remained-constant! ACC)
        (eq! POWER (* (prev POWER) 256)))
      (begin
        (did-inc! ACC 1)
        (remained-constant! POWER)))
    (eq! BIT_ACC (+ (* 2 BIT_ACC) BIT1)))))

(defconstraint create-last-row (:guard (- 1 create2))
 (if-eq ct 7
  (begin
    (eq! ACC NONCE)
    (eq! BIT_ACC BYTE1)
    (if-zero (+ (~ (eq! ACC_BYTESIZE 1))
                (shift BIT1 -7))
      (vanishes! not_little)
      (eq! not_little 1))
    (eq! (+ (shift LC -4) (shift LC -3)) 1)
    (eq! (shift LIMB -3)
         (* (+ list_short 21 ACC_BYTESIZE not_little)
            (^ 256 15)))
    (eq! (shift nBYTES -3) 1)
    (vanishes! (shift INDEX -3))
    (eq! (shift LIMB -2)
         (+ (* (+ int_short 20)
               (^ 256 15))
            (* ADDR_HI
               (^ 256 11))))
    (eq! (shift nBYTES -2) 5)
    (eq! (prev LIMB) ADDR_LO)
    (eq! (prev nBYTES) 16)
    (if-zero NONCE
      (eq! LIMB (* int_short (^ 256 15)))
      (if-zero not_little
        (eq! LIMB (* NONCE (^ 256 15)))
        (eq! LIMB
             (+ (* (+ int_short ACC_BYTESIZE)
                   (^ 256 15))
                (* NONCE POWER)))))
    (eq! nBYTES (+ ACC_BYTESIZE not_little))
    (vanishes! (shift INDEX -3))
    (eq! INDEX 3))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    6 CREATE2 constraints      ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint index-create2 (:guard create2)
 (eq! INDEX ct))

(defconstraint create2-last-row (:guard create2)
  (if-eq ct 5 
    (begin
      (eq! (shift LC -5) 1)
      (eq! (shift LIMB -5)
           (+ (* create2_shift (^ 256 15))
              (* ADDR_HI (^ 256 11))))
      (eq! (shift nBYTES -5) 5)
      (eq! (shift LIMB -4) ADDR_LO)
      (eq! (shift nBYTES -4) 16)
      (eq! (shift LIMB -3) SALT_HI)
      (eq! (shift nBYTES -3) 16)
      (eq! (shift LIMB -2) SALT_LO)
      (eq! (shift nBYTES -2) 16)
      (eq! (prev LIMB) KEC_HI)
      (eq! (prev nBYTES) 16)
      (eq! LIMB KEC_LO)
      (eq! nBYTES 16))))