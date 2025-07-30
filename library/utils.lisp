(defpurefun (counter-constant col ct) 
    (if-not-zero ct
        (remained-constant! col)))
