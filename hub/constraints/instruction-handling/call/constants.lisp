(module hub)

(defconst

  ;; CALL specific row offset constants
  CALL_1st_stack___row_offset                                          -2
  CALL_2nd_stack___row_offset                                          -1
  CALL_1st_scenario___row_offset                                        0
  CALL_1st_context___row_offset                                         1
  CALL_misc___row_offset                                                2
  CALL_1st_caller_account___row_offset                                  3
  CALL_1st_callee_account___row_offset                                  4
  CALL_2nd_caller_account___row_offset                                  5
  CALL_2nd_callee_account___row_offset                                  6
  CALL_3rd_callee_account___row_offset                                  7
  ;;
  CALL_staticx_update_parent_context___row_offset                       3
  CALL_mxpx_update_parent_context___row_offset                          3
  CALL_oogx_update_parent_context___row_offset                          5
  CALL_abort_update_current_context___row_offset                        5
  CALL_EOA_will_revert_caller_context___row_offset                      7
  CALL_EOA_wont_revert_caller_context___row_offset                      5
  CALL_SMC_failure_will_revert_initialize_callee_context___row_offset   8
  CALL_SMC_failure_wont_revert_initialize_callee_context___row_offset   7
  CALL_SMC_success_will_revert_initialize_callee_context___row_offset   7
  CALL_SMC_success_wont_revert_initialize_callee_context___row_offset   5
  ;;
  CALL_PRC_failure_2nd_scenario___row_offset                            5
  CALL_PRC_success_will_revert_2nd_scenario___row_offset                7
  CALL_PRC_success_wont_revert_2nd_scenario___row_offset                5
  )
