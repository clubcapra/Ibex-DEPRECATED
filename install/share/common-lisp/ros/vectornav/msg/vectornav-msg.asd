
(cl:in-package :asdf)

(defsystem "vectornav-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "sensors" :depends-on ("_package_sensors"))
    (:file "_package_sensors" :depends-on ("_package"))
    (:file "ins" :depends-on ("_package_ins"))
    (:file "_package_ins" :depends-on ("_package"))
    (:file "gps" :depends-on ("_package_gps"))
    (:file "_package_gps" :depends-on ("_package"))
  ))