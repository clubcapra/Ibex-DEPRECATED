
(cl:in-package :asdf)

(defsystem "capra_motor_calibrator-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "CalibrateMotor" :depends-on ("_package_CalibrateMotor"))
    (:file "_package_CalibrateMotor" :depends-on ("_package"))
  ))