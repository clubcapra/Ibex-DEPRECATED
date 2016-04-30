
(cl:in-package :asdf)

(defsystem "juvav_recovery-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Run" :depends-on ("_package_Run"))
    (:file "_package_Run" :depends-on ("_package"))
  ))