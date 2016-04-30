
(cl:in-package :asdf)

(defsystem "capra_controlpanel-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "RobotButtons" :depends-on ("_package_RobotButtons"))
    (:file "_package_RobotButtons" :depends-on ("_package"))
    (:file "RobotAnalogValues" :depends-on ("_package_RobotAnalogValues"))
    (:file "_package_RobotAnalogValues" :depends-on ("_package"))
  ))