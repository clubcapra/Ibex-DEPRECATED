; Auto-generated. Do not edit!


(cl:in-package capra_msgs-msg)


;//! \htmlinclude AiStatus.msg.html

(cl:defclass <AiStatus> (roslisp-msg-protocol:ros-message)
  ((isRunning
    :reader isRunning
    :initarg :isRunning
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass AiStatus (<AiStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AiStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AiStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-msg:<AiStatus> is deprecated: use capra_msgs-msg:AiStatus instead.")))

(cl:ensure-generic-function 'isRunning-val :lambda-list '(m))
(cl:defmethod isRunning-val ((m <AiStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:isRunning-val is deprecated.  Use capra_msgs-msg:isRunning instead.")
  (isRunning m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AiStatus>) ostream)
  "Serializes a message object of type '<AiStatus>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isRunning) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AiStatus>) istream)
  "Deserializes a message object of type '<AiStatus>"
    (cl:setf (cl:slot-value msg 'isRunning) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AiStatus>)))
  "Returns string type for a message object of type '<AiStatus>"
  "capra_msgs/AiStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AiStatus)))
  "Returns string type for a message object of type 'AiStatus"
  "capra_msgs/AiStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AiStatus>)))
  "Returns md5sum for a message object of type '<AiStatus>"
  "f2d5194b33b82502361bdb80f0070282")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AiStatus)))
  "Returns md5sum for a message object of type 'AiStatus"
  "f2d5194b33b82502361bdb80f0070282")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AiStatus>)))
  "Returns full string definition for message of type '<AiStatus>"
  (cl:format cl:nil "bool isRunning~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AiStatus)))
  "Returns full string definition for message of type 'AiStatus"
  (cl:format cl:nil "bool isRunning~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AiStatus>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AiStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'AiStatus
    (cl:cons ':isRunning (isRunning msg))
))
