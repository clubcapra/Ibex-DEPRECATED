
(cl:in-package :asdf)

(defsystem "animatics_smart_motor-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "MotorsConnected" :depends-on ("_package_MotorsConnected"))
    (:file "_package_MotorsConnected" :depends-on ("_package"))
  ))