
(cl:in-package :asdf)

(defsystem "capra_gps-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :nav_msgs-msg
               :sensor_msgs-msg
)
  :components ((:file "_package")
    (:file "Rotate" :depends-on ("_package_Rotate"))
    (:file "_package_Rotate" :depends-on ("_package"))
    (:file "AddLatlongGoal" :depends-on ("_package_AddLatlongGoal"))
    (:file "_package_AddLatlongGoal" :depends-on ("_package"))
  ))