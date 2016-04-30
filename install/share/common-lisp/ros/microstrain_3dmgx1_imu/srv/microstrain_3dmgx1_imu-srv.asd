
(cl:in-package :asdf)

(defsystem "microstrain_3dmgx1_imu-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Calibrate" :depends-on ("_package_Calibrate"))
    (:file "_package_Calibrate" :depends-on ("_package"))
  ))