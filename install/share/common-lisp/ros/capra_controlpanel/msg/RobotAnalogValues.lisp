; Auto-generated. Do not edit!


(cl:in-package capra_controlpanel-msg)


;//! \htmlinclude RobotAnalogValues.msg.html

(cl:defclass <RobotAnalogValues> (roslisp-msg-protocol:ros-message)
  ((tension
    :reader tension
    :initarg :tension
    :type cl:float
    :initform 0.0)
   (current
    :reader current
    :initarg :current
    :type cl:float
    :initform 0.0)
   (temperature
    :reader temperature
    :initarg :temperature
    :type cl:float
    :initform 0.0))
)

(cl:defclass RobotAnalogValues (<RobotAnalogValues>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RobotAnalogValues>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RobotAnalogValues)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_controlpanel-msg:<RobotAnalogValues> is deprecated: use capra_controlpanel-msg:RobotAnalogValues instead.")))

(cl:ensure-generic-function 'tension-val :lambda-list '(m))
(cl:defmethod tension-val ((m <RobotAnalogValues>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:tension-val is deprecated.  Use capra_controlpanel-msg:tension instead.")
  (tension m))

(cl:ensure-generic-function 'current-val :lambda-list '(m))
(cl:defmethod current-val ((m <RobotAnalogValues>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:current-val is deprecated.  Use capra_controlpanel-msg:current instead.")
  (current m))

(cl:ensure-generic-function 'temperature-val :lambda-list '(m))
(cl:defmethod temperature-val ((m <RobotAnalogValues>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:temperature-val is deprecated.  Use capra_controlpanel-msg:temperature instead.")
  (temperature m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RobotAnalogValues>) ostream)
  "Serializes a message object of type '<RobotAnalogValues>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tension))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'temperature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RobotAnalogValues>) istream)
  "Deserializes a message object of type '<RobotAnalogValues>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tension) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'temperature) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RobotAnalogValues>)))
  "Returns string type for a message object of type '<RobotAnalogValues>"
  "capra_controlpanel/RobotAnalogValues")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RobotAnalogValues)))
  "Returns string type for a message object of type 'RobotAnalogValues"
  "capra_controlpanel/RobotAnalogValues")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RobotAnalogValues>)))
  "Returns md5sum for a message object of type '<RobotAnalogValues>"
  "a782781ab0f86f59d9cf9598957bd56f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RobotAnalogValues)))
  "Returns md5sum for a message object of type 'RobotAnalogValues"
  "a782781ab0f86f59d9cf9598957bd56f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RobotAnalogValues>)))
  "Returns full string definition for message of type '<RobotAnalogValues>"
  (cl:format cl:nil "float32 tension~%float32 current~%float32 temperature~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RobotAnalogValues)))
  "Returns full string definition for message of type 'RobotAnalogValues"
  (cl:format cl:nil "float32 tension~%float32 current~%float32 temperature~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RobotAnalogValues>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RobotAnalogValues>))
  "Converts a ROS message object to a list"
  (cl:list 'RobotAnalogValues
    (cl:cons ':tension (tension msg))
    (cl:cons ':current (current msg))
    (cl:cons ':temperature (temperature msg))
))
