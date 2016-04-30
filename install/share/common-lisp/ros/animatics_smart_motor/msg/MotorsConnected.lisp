; Auto-generated. Do not edit!


(cl:in-package animatics_smart_motor-msg)


;//! \htmlinclude MotorsConnected.msg.html

(cl:defclass <MotorsConnected> (roslisp-msg-protocol:ros-message)
  ((connected
    :reader connected
    :initarg :connected
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass MotorsConnected (<MotorsConnected>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MotorsConnected>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MotorsConnected)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name animatics_smart_motor-msg:<MotorsConnected> is deprecated: use animatics_smart_motor-msg:MotorsConnected instead.")))

(cl:ensure-generic-function 'connected-val :lambda-list '(m))
(cl:defmethod connected-val ((m <MotorsConnected>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader animatics_smart_motor-msg:connected-val is deprecated.  Use animatics_smart_motor-msg:connected instead.")
  (connected m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MotorsConnected>) ostream)
  "Serializes a message object of type '<MotorsConnected>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'connected) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MotorsConnected>) istream)
  "Deserializes a message object of type '<MotorsConnected>"
    (cl:setf (cl:slot-value msg 'connected) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MotorsConnected>)))
  "Returns string type for a message object of type '<MotorsConnected>"
  "animatics_smart_motor/MotorsConnected")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MotorsConnected)))
  "Returns string type for a message object of type 'MotorsConnected"
  "animatics_smart_motor/MotorsConnected")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MotorsConnected>)))
  "Returns md5sum for a message object of type '<MotorsConnected>"
  "e0cdaf65159c7f3563426650fb8d3f64")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MotorsConnected)))
  "Returns md5sum for a message object of type 'MotorsConnected"
  "e0cdaf65159c7f3563426650fb8d3f64")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MotorsConnected>)))
  "Returns full string definition for message of type '<MotorsConnected>"
  (cl:format cl:nil "bool connected~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MotorsConnected)))
  "Returns full string definition for message of type 'MotorsConnected"
  (cl:format cl:nil "bool connected~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MotorsConnected>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MotorsConnected>))
  "Converts a ROS message object to a list"
  (cl:list 'MotorsConnected
    (cl:cons ':connected (connected msg))
))
