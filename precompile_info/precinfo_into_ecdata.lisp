(defun (requires-ec-data)
  (* precompile_info.TOUCHES_RAM
     (+ precompile_info.EC_RECOVER precompile_info.EC_ADD precompile_info.EC_MUL precompile_info.EC_PAIRING)))

(defplookup 
  precinfo-into-ecdata
  (
    ;target columns
    ec_data.STAMP
    ec_data.TOTAL_PAIRINGS
  )
  (
    ;source columns
    (* precompile_info.STAMP (requires-ec-data))
    (* precompile_info.PAIRING_COUNT (requires-ec-data))
  ))

