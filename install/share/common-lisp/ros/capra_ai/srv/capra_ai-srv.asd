
(cl:in-package :asdf)

(defsystem "capra_ai-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :capra_ai-msg
)
  :components ((:file "_package")
    (:file "ClearGoalList" :depends-on ("_package_ClearGoalList"))
    (:file "_package_ClearGoalList" :depends-on ("_package"))
    (:file "AddGoal" :depends-on ("_package_AddGoal"))
    (:file "_package_AddGoal" :depends-on ("_package"))
    (:file "CancelGoal" :depends-on ("_package_CancelGoal"))
    (:file "_package_CancelGoal" :depends-on ("_package"))
  ))