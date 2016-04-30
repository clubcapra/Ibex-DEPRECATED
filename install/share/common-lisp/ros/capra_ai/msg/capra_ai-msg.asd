
(cl:in-package :asdf)

(defsystem "capra_ai-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :actionlib_msgs-msg
               :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "GoalWithPriority" :depends-on ("_package_GoalWithPriority"))
    (:file "_package_GoalWithPriority" :depends-on ("_package"))
  ))