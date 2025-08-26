(module blockdata)

(defconstraint    generalities---CT-and-CT_MAX---setting-CT_MAX ()
                  (eq!   CT_MAX   (ct-max-sum)))

(defconstraint    generalities---CT-and-CT_MAX---automatic-vanishing-during-padding ()
                  (vanishes!   CT)
                  )

(defproperty      generalities---CT-and-CT_MAX---automatic-vanishing-during-padding ()
                  (begin
                    (vanishes!   (next CT))
                    (vanishes!   CT_MAX)
                    ))

(defconstraint    generalities---CT-and-CT_MAX---update-constraints ()
                  (if-not-zero IOMF
                               (if-eq-else   CT   CT_MAX
                                             (eq!         (next CT)   (+ 1 CT))
                                             (begin
                                               (eq!   (next CT) 0)
                                               (eq!   (upcoming-legal-phase-transition)   1)
                                               ))))

(defproperty    generalities---CT-and-CT_MAX---update-properties
                (if-not-zero IOMF
                             (if-eq-else   CT   CT_MAX
                                           (begin
                                             (vanishes!   (upcoming-legal-phase-transition))
                                             (vanishes!   (upcoming-phase-entry))
                                             (vanishes!   (upcoming-same-phase))
                                             )
                                           (begin
                                             (vanishes!   (upcoming-phase-entry))
                                             (vanishes!   (upcoming-same-phase))
                                             ))))

