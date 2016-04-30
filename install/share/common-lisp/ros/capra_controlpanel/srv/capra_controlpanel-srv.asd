
(cl:in-package :asdf)

(defsystem "capra_controlpanel-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Set" :depends-on ("_package_Set"))
    (:file "_package_Set" :depends-on ("_package"))
    (:file "Flash" :depends-on ("_package_Flash"))
    (:file "_package_Flash" :depends-on ("_package"))
  ))