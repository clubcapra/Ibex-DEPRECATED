
(cl:in-package :asdf)

(defsystem "roboteq_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Status" :depends-on ("_package_Status"))
    (:file "_package_Status" :depends-on ("_package"))
    (:file "Feedback" :depends-on ("_package_Feedback"))
    (:file "_package_Feedback" :depends-on ("_package"))
    (:file "Command" :depends-on ("_package_Command"))
    (:file "_package_Command" :depends-on ("_package"))
  ))