
(cl:in-package :asdf)

(defsystem "seagoatvision_ros-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ShowGui" :depends-on ("_package_ShowGui"))
    (:file "_package_ShowGui" :depends-on ("_package"))
  ))