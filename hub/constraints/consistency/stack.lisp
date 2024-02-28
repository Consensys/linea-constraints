(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        ;;
;;    X.4 Stack consistency constraints   ;;
;;                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(definterleaved PEEK_AT_STACK_POW_4   (PEEK_AT_STACK                 PEEK_AT_STACK                 PEEK_AT_STACK                 PEEK_AT_STACK       ))
(definterleaved CN_POW_4              (CONTEXT_NUMBER                CONTEXT_NUMBER                CONTEXT_NUMBER                CONTEXT_NUMBER      ))
(definterleaved STACK_STAMP_1234      ([stack/STACK_ITEM_STAMP    1] [stack/STACK_ITEM_STAMP    2] [stack/STACK_ITEM_STAMP    3] [stack/STACK_ITEM_STAMP    4]))
(definterleaved HEIGHT_1234           ([stack/STACK_ITEM_HEIGHT   1] [stack/STACK_ITEM_HEIGHT   2] [stack/STACK_ITEM_HEIGHT   3] [stack/STACK_ITEM_HEIGHT   4]))
(definterleaved POP_1234              ([stack/STACK_ITEM_POP      1] [stack/STACK_ITEM_POP      2] [stack/STACK_ITEM_POP      3] [stack/STACK_ITEM_POP      4]))
(definterleaved VALUE_HI_1234         ([stack/STACK_ITEM_VALUE_HI 1] [stack/STACK_ITEM_VALUE_HI 2] [stack/STACK_ITEM_VALUE_HI 3] [stack/STACK_ITEM_VALUE_HI 4]))
(definterleaved VALUE_LO_1234         ([stack/STACK_ITEM_VALUE_LO 1] [stack/STACK_ITEM_VALUE_LO 2] [stack/STACK_ITEM_VALUE_LO 3] [stack/STACK_ITEM_VALUE_LO 4]))

(defpermutation
  ;; row-permuted columns
  (
   perm_stack_PEEK_AT_STACK_POW_4
   perm_stack_CN_POW_4
   perm_stack_HEIGHT_1234
   perm_stack_STACK_STAMP_1234
   perm_stack_POP_1234
   perm_stack_VALUE_HI_1234
   perm_stack_VALUE_LO_1234
   )
  ;; underlying columns
  (
	(↓ PEEK_AT_STACK_POW_4) 
        (↓ CN_POW_4) 
        (↓ HEIGHT_1234) 
        (↓ STACK_STAMP_1234) 
        POP_1234
        VALUE_HI_1234
        VALUE_LO_1234) 
  )

(defconstraint stack-consistency-only-nontrivial-contexts ()
               (if-not-zero perm_stack_PEEK_AT_STACK_POW_4
                            (is-not-zero! perm_stack_CN_POW_4)))

(defconstraint setting-perm-stack-context-first-again ()
               (begin
                 (debug (is-binary perm_stack_CONTEXT_FIRST))
                 (debug (is-binary perm_stack_CONTEXT_AGAIN))
                 (eq! (+ perm_stack_CONTEXT_FIRST
                         perm_stack_CONTEXT_AGAIN)
                      perm_stack_PEEK_AT_STACK_POW_4)
                 (if-zero (force-bool perm_stack_PEEK_AT_STACK_POW_4)
                          (eq! (next perm_stack_CONTEXT_FIRST)
                               (next perm_stack_PEEK_AT_STACK_POW_4))
                          (begin
                            (if-not-zero (next perm_stack_CONTEXT_FIRST)
                                         (is-not-zero! (will-eq! perm_stack_CN_POW_4
                                                                 perm_stack_CN_POW_4)))
                            (if-not-zero (next perm_stack_CONTEXT_AGAIN)
                                         (will-eq! perm_stack_CN_POW_4
                                                   perm_stack_CN_POW_4))))))

(defconstraint setting-perm-stack-height-first-again ()
               (begin
                 (debug (is-binary perm_stack_HEIGHT_FIRST))
                 (debug (is-binary perm_stack_HEIGHT_AGAIN))
                 (eq! (+ perm_stack_HEIGHT_FIRST
                         perm_stack_HEIGHT_AGAIN)
                      perm_stack_PEEK_AT_STACK_POW_4)
                 (if-zero (force-bool perm_stack_PEEK_AT_STACK_POW_4)
                          (eq! (next perm_stack_HEIGHT_FIRST)
                               (next perm_stack_PEEK_AT_STACK_POW_4))
                          (begin
                            (if-not-zero (next perm_stack_HEIGHT_FIRST)
                                         (is-not-zero! (will-eq! perm_stack_HEIGHT_1234
                                                                 perm_stack_HEIGHT_1234)))
                            (if-not-zero (next perm_stack_HEIGHT_AGAIN)
                                         (will-eq! perm_stack_HEIGHT_1234
                                                   perm_stack_HEIGHT_1234))))))

(defconstraint setting-perm-stack-same-spot-first-again ()
               (begin
                 (debug (is-binary perm_stack_SAME_SPOT_FIRST))
                 (debug (is-binary perm_stack_SAME_SPOT_AGAIN))
                 (eq! perm_stack_SAME_SPOT_AGAIN (* perm_stack_CONTEXT_AGAIN
                                                    perm_stack_HEIGHT_AGAIN))))

(defconstraint first-context-encounter ()
               (begin
                 (if-not-zero perm_stack_CONTEXT_FIRST
                              (vanishes! perm_stack_HEIGHT_1234))
                 (if-not-zero perm_stack_CONTEXT_AGAIN
                              (any! (will-remain-constant! perm_stack_HEIGHT_1234)
                                    (will-inc! perm_stack_HEIGHT_1234 1)))))

(defconstraint first-sport-encounter ()
               (begin
                 (if-not-zero perm_stack_SAME_SPOT_FIRST
                              (vanishes! perm_stack_POP_1234))
                 (if-not-zero perm_stack_SAME_SPOT_AGAIN
                              (if-not-zero perm_stack_HEIGHT_1234
                                           (begin
                                             (eq! (+ perm_stack_POP_1234 (prev perm_stack_POP_1234)) 1)
                                             (if-not-zero perm_stack_POP_1234
                                                          (begin
                                                            (remained-constant! perm_stack_VALUE_HI_1234)
                                                            (remained-constant! perm_stack_VALUE_LO_1234))))))))
