; Auto-generated. Do not edit!


(cl:in-package roboteq_msgs-msg)


;//! \htmlinclude Command.msg.html

(cl:defclass <Command> (roslisp-msg-protocol:ros-message)
  ((mode
    :reader mode
    :initarg :mode
    :type cl:fixnum
    :initform 0)
   (setpoint
    :reader setpoint
    :initarg :setpoint
    :type cl:float
    :initform 0.0))
)

(cl:defclass Command (<Command>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Command>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Command)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name roboteq_msgs-msg:<Command> is deprecated: use roboteq_msgs-msg:Command instead.")))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <Command>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:mode-val is deprecated.  Use roboteq_msgs-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'setpoint-val :lambda-list '(m))
(cl:defmethod setpoint-val ((m <Command>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:setpoint-val is deprecated.  Use roboteq_msgs-msg:setpoint instead.")
  (setpoint m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Command>)))
    "Constants for message type '<Command>"
  '((:MODE_STOPPED . -1)
    (:MODE_VELOCITY . 0)
    (:MODE_POSITION . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Command)))
    "Constants for message type 'Command"
  '((:MODE_STOPPED . -1)
    (:MODE_VELOCITY . 0)
    (:MODE_POSITION . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Command>) ostream)
  "Serializes a message object of type '<Command>"
  (cl:let* ((signed (cl:slot-value msg 'mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'setpoint))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Command>) istream)
  "Deserializes a message object of type '<Command>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'setpoint) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Command>)))
  "Returns string type for a message object of type '<Command>"
  "roboteq_msgs/Command")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Command)))
  "Returns string type for a message object of type 'Command"
  "roboteq_msgs/Command")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Command>)))
  "Returns md5sum for a message object of type '<Command>"
  "9f57e6568807eb250db6d5bd382ee299")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Command)))
  "Returns md5sum for a message object of type 'Command"
  "9f57e6568807eb250db6d5bd382ee299")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Command>)))
  "Returns full string definition for message of type '<Command>"
  (cl:format cl:nil "~%# Control whether the setpoint represents a velocity or position command.~%# Velocity is the default, but position may be used for fine-grained movements,~%# or active braking on an incline. Stopped is high-z (coasting).~%int8 MODE_STOPPED=-1~%int8 MODE_VELOCITY=0~%int8 MODE_POSITION=1~%int8 mode~%~%# Commanded velocity (rad/s) or position (rad) for the motor. Position uses~%# the same scale as measured_position in the Feedback message.~%float32 setpoint~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Command)))
  "Returns full string definition for message of type 'Command"
  (cl:format cl:nil "~%# Control whether the setpoint represents a velocity or position command.~%# Velocity is the default, but position may be used for fine-grained movements,~%# or active braking on an incline. Stopped is high-z (coasting).~%int8 MODE_STOPPED=-1~%int8 MODE_VELOCITY=0~%int8 MODE_POSITION=1~%int8 mode~%~%# Commanded velocity (rad/s) or position (rad) for the motor. Position uses~%# the same scale as measured_position in the Feedback message.~%float32 setpoint~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Command>))
  (cl:+ 0
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Command>))
  "Converts a ROS message object to a list"
  (cl:list 'Command
    (cl:cons ':mode (mode msg))
    (cl:cons ':setpoint (setpoint msg))
))
