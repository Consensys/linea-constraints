(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        ;;
;;    X.4 Stack consistency constraints   ;;
;;                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun (first-context-occurrence)  (first-occurrence-of  stkcp_PEEK_AT_STACK_POW_4 stkcp_CN_POW_4))
(defun (first-height-occurrence)   (first-occurrence-of  stkcp_PEEK_AT_STACK_POW_4 stkcp_HEIGHT_1234))
(defun (first-spot-occurrence)     (- (+ (first-context-occurrence)   (first-height-occurrence))
                                      (* (first-context-occurrence)   (first-height-occurrence))))
(defun (repeat-context-occurrence) (repeat-occurrence-of stkcp_PEEK_AT_STACK_POW_4 stkcp_CN_POW_4))
(defun (repeat-height-occurrence)  (repeat-occurrence-of stkcp_PEEK_AT_STACK_POW_4 stkcp_HEIGHT_1234))
(defun (repeat-spot-occurrence)    (*    (repeat-context-occurrence)  (repeat-height-occurrence)))

(defconstraint stack-consistency---only-nontrivial-contexts ()
               (if-not-zero stkcp_PEEK_AT_STACK_POW_4
                            (is-not-zero! stkcp_CN_POW_4)))

;; (defconstraint stack-consistency---sanity-checks ()
;;                (begin
;;                  (debug (is-binary (repeat-context-occurrence)))
;;                  (debug (is-binary (first-context-occurrence)))
;;                  (debug (is-binary (repeat-height-occurrence)))
;;                  (debug (is-binary (first-height-occurrence)))))

(defconstraint stack-consistency---first-context-occurrence-constraints ()
               (begin
                 (if-not-zero (first-context-occurrence)
                              (vanishes! stkcp_HEIGHT_1234))
                 (if-not-zero (repeat-context-occurrence)
                              (any! (will-remain-constant! stkcp_HEIGHT_1234)
                                    (will-inc! stkcp_HEIGHT_1234 1)))))

;; ;; TODO: finish!
;; (defconstraint stack-consistency---first-spot-occurrence-constraints ()
;;                (begin
;;                  (if-not-zero (first-spot-occurrence)
;;                               (vanishes! stkcp_POP_1234))))
;;                  (if-not-zero (repeat-spot-occurrence)
;;                               (if-not-zero stkcp_HEIGHT_1234
;;                                            (begin
;;                                              (eq! (+ stkcp_POP_1234 (prev stkcp_POP_1234)) 1)
;;                                              (if-not-zero stkcp_POP_1234
;;                                                           (begin
;;                                                             (remained-constant! stkcp_VALUE_HI_1234)
;;                                                             (remained-constant! stkcp_VALUE_LO_1234))))))))
