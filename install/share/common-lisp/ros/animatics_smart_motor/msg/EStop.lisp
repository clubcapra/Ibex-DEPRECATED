; Auto-generated. Do not edit!


(cl:in-package animatics_smart_motor-msg)


;//! \htmlinclude EStop.msg.html

(cl:defclass <EStop> (roslisp-msg-protocol:ros-message)
  ((enabled
    :reader enabled
    :initarg :enabled
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass EStop (<EStop>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EStop>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EStop)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name animatics_smart_motor-msg:<EStop> is deprecated: use animatics_smart_motor-msg:EStop instead.")))

(cl:ensure-generic-function 'enabled-val :lambda-list '(m))
(cl:defmethod enabled-val ((m <EStop>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader animatics_smart_motor-msg:enabled-val is deprecated.  Use animatics_smart_motor-msg:enabled instead.")
  (enabled m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EStop>) ostream)
  "Serializes a message object of type '<EStop>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enabled) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EStop>) istream)
  "Deserializes a message object of type '<EStop>"
    (cl:setf (cl:slot-value msg 'enabled) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EStop>)))
  "Returns string type for a message object of type '<EStop>"
  "animatics_smart_motor/EStop")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EStop)))
  "Returns string type for a message object of type 'EStop"
  "animatics_smart_motor/EStop")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EStop>)))
  "Returns md5sum for a message object of type '<EStop>"
  "2815464f55ab63684cc1bc38072d0b9b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EStop)))
  "Returns md5sum for a message object of type 'EStop"
  "2815464f55ab63684cc1bc38072d0b9b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EStop>)))
  "Returns full string definition for message of type '<EStop>"
  (cl:format cl:nil "bool enabled~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EStop)))
  "Returns full string definition for message of type 'EStop"
  (cl:format cl:nil "bool enabled~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EStop>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EStop>))
  "Converts a ROS message object to a list"
  (cl:list 'EStop
    (cl:cons ':enabled (enabled msg))
))
