(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                        ;;
;;    X.2 Execution environment consistency constraints   ;;
;;                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpermutation
  ;; permuted columns
  (
   perm_exec_env_CN
   perm_exec_env_HUB_STAMP
   perm_exec_env_CFI
   perm_exec_env_CALLER_CN
   perm_exec_env_CN_WILL_REV
   perm_exec_env_CN_GETS_REV
   perm_exec_env_CN_SELF_REV
   perm_exec_env_CN_REV_STAMP
   perm_exec_env_PC
   perm_exec_env_PC_NEW
   perm_exec_env_HEIGHT
   perm_exec_env_HEIGHT_NEW
   perm_exec_env_GAS_EXPECTED
   perm_exec_env_GAS_NEXT
   )
  ;; original columns
  (
   (+ CN )
   (+ HUB_STAMP )
   CFI
   CALLER_CN
   CN_WILL_REV
   CN_GETS_REV
   CN_SELF_REV
   CN_REV_STAMP
   PC
   PC_NEW
   HEIGHT
   HEIGHT_NEW
   GAS_EXPECTED
   GAS_NEXT
   )
  )

(defconstraint consistency-exec-env-constancies ()
               (if-not-zero perm_exec_env_CN
                            (if-eq (next perm_exec_env_CN) perm_exec_env_CN
                                   (begin
                                     (will-eq! perm_exec_env_CFI          perm_exec_env_CFI)
                                     (will-eq! perm_exec_env_CALLER_CN    perm_exec_env_CALLER_CN)
                                     (will-eq! perm_exec_env_CN_WILL_REV  perm_exec_env_CN_WILL_REV)
                                     (will-eq! perm_exec_env_CN_GETS_REV  perm_exec_env_CN_GETS_REV)
                                     (will-eq! perm_exec_env_CN_SELF_REV  perm_exec_env_CN_SELF_REV)
                                     (will-eq! perm_exec_env_CN_REV_STAMP perm_exec_env_CN_REV_STAMP)))))

(defconstraint consistency-exec-env-linking ()
               (if-not-zero perm_exec_env_CN
                            (if-eq (next perm_exec_env_CN) perm_exec_env_CN
                                   (if-not-zero (will-remain-constant! perm_exec_env_HUB_STAMP)
                                                (begin
                                                  (will-eq! perm_exec_env_PC           perm_exec_env_PC_NEW)
                                                  (will-eq! perm_exec_env_HEIGHT       perm_exec_env_HEIGHT_NEW)
                                                  (will-eq! perm_exec_env_GAS_EXPECTED perm_exec_env_GAS_NEXT))))))
                                                                       
(defconstraint consistency-exec-env-initialization ()
               (if-not-zero (will-remain-constant! perm_exec_env_HUB_STAMP)
                            (begin
                              (vanishes! (next perm_exec_env_PC))
                              (vanishes! (next perm_exec_env_HEIGHT)))))
