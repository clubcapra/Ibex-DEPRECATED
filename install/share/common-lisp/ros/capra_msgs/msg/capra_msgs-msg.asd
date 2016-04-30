
(cl:in-package :asdf)

(defsystem "capra_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "AiStatus" :depends-on ("_package_AiStatus"))
    (:file "_package_AiStatus" :depends-on ("_package"))
    (:file "EStopStatus" :depends-on ("_package_EStopStatus"))
    (:file "_package_EStopStatus" :depends-on ("_package"))
    (:file "SensorsTelemetry" :depends-on ("_package_SensorsTelemetry"))
    (:file "_package_SensorsTelemetry" :depends-on ("_package"))
  ))