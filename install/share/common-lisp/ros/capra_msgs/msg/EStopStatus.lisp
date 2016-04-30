; Auto-generated. Do not edit!


(cl:in-package capra_msgs-msg)


;//! \htmlinclude EStopStatus.msg.html

(cl:defclass <EStopStatus> (roslisp-msg-protocol:ros-message)
  ((stopped
    :reader stopped
    :initarg :stopped
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass EStopStatus (<EStopStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EStopStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EStopStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-msg:<EStopStatus> is deprecated: use capra_msgs-msg:EStopStatus instead.")))

(cl:ensure-generic-function 'stopped-val :lambda-list '(m))
(cl:defmethod stopped-val ((m <EStopStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:stopped-val is deprecated.  Use capra_msgs-msg:stopped instead.")
  (stopped m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EStopStatus>) ostream)
  "Serializes a message object of type '<EStopStatus>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'stopped) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EStopStatus>) istream)
  "Deserializes a message object of type '<EStopStatus>"
    (cl:setf (cl:slot-value msg 'stopped) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EStopStatus>)))
  "Returns string type for a message object of type '<EStopStatus>"
  "capra_msgs/EStopStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EStopStatus)))
  "Returns string type for a message object of type 'EStopStatus"
  "capra_msgs/EStopStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EStopStatus>)))
  "Returns md5sum for a message object of type '<EStopStatus>"
  "caab21a24341159709db962b47b01ad1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EStopStatus)))
  "Returns md5sum for a message object of type 'EStopStatus"
  "caab21a24341159709db962b47b01ad1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EStopStatus>)))
  "Returns full string definition for message of type '<EStopStatus>"
  (cl:format cl:nil "bool stopped~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EStopStatus)))
  "Returns full string definition for message of type 'EStopStatus"
  (cl:format cl:nil "bool stopped~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EStopStatus>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EStopStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'EStopStatus
    (cl:cons ':stopped (stopped msg))
))
