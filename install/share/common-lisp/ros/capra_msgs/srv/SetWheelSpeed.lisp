; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude SetWheelSpeed-request.msg.html

(cl:defclass <SetWheelSpeed-request> (roslisp-msg-protocol:ros-message)
  ((wheel
    :reader wheel
    :initarg :wheel
    :type cl:fixnum
    :initform 0)
   (speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0))
)

(cl:defclass SetWheelSpeed-request (<SetWheelSpeed-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetWheelSpeed-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetWheelSpeed-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<SetWheelSpeed-request> is deprecated: use capra_msgs-srv:SetWheelSpeed-request instead.")))

(cl:ensure-generic-function 'wheel-val :lambda-list '(m))
(cl:defmethod wheel-val ((m <SetWheelSpeed-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:wheel-val is deprecated.  Use capra_msgs-srv:wheel instead.")
  (wheel m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <SetWheelSpeed-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:speed-val is deprecated.  Use capra_msgs-srv:speed instead.")
  (speed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetWheelSpeed-request>) ostream)
  "Serializes a message object of type '<SetWheelSpeed-request>"
  (cl:let* ((signed (cl:slot-value msg 'wheel)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetWheelSpeed-request>) istream)
  "Deserializes a message object of type '<SetWheelSpeed-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'wheel) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetWheelSpeed-request>)))
  "Returns string type for a service object of type '<SetWheelSpeed-request>"
  "capra_msgs/SetWheelSpeedRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetWheelSpeed-request)))
  "Returns string type for a service object of type 'SetWheelSpeed-request"
  "capra_msgs/SetWheelSpeedRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetWheelSpeed-request>)))
  "Returns md5sum for a message object of type '<SetWheelSpeed-request>"
  "812356feddcdc2f447f0699a2c1e2105")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetWheelSpeed-request)))
  "Returns md5sum for a message object of type 'SetWheelSpeed-request"
  "812356feddcdc2f447f0699a2c1e2105")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetWheelSpeed-request>)))
  "Returns full string definition for message of type '<SetWheelSpeed-request>"
  (cl:format cl:nil "int8 wheel~%float32 speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetWheelSpeed-request)))
  "Returns full string definition for message of type 'SetWheelSpeed-request"
  (cl:format cl:nil "int8 wheel~%float32 speed~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetWheelSpeed-request>))
  (cl:+ 0
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetWheelSpeed-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetWheelSpeed-request
    (cl:cons ':wheel (wheel msg))
    (cl:cons ':speed (speed msg))
))
;//! \htmlinclude SetWheelSpeed-response.msg.html

(cl:defclass <SetWheelSpeed-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SetWheelSpeed-response (<SetWheelSpeed-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetWheelSpeed-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetWheelSpeed-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<SetWheelSpeed-response> is deprecated: use capra_msgs-srv:SetWheelSpeed-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetWheelSpeed-response>) ostream)
  "Serializes a message object of type '<SetWheelSpeed-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetWheelSpeed-response>) istream)
  "Deserializes a message object of type '<SetWheelSpeed-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetWheelSpeed-response>)))
  "Returns string type for a service object of type '<SetWheelSpeed-response>"
  "capra_msgs/SetWheelSpeedResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetWheelSpeed-response)))
  "Returns string type for a service object of type 'SetWheelSpeed-response"
  "capra_msgs/SetWheelSpeedResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetWheelSpeed-response>)))
  "Returns md5sum for a message object of type '<SetWheelSpeed-response>"
  "812356feddcdc2f447f0699a2c1e2105")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetWheelSpeed-response)))
  "Returns md5sum for a message object of type 'SetWheelSpeed-response"
  "812356feddcdc2f447f0699a2c1e2105")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetWheelSpeed-response>)))
  "Returns full string definition for message of type '<SetWheelSpeed-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetWheelSpeed-response)))
  "Returns full string definition for message of type 'SetWheelSpeed-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetWheelSpeed-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetWheelSpeed-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetWheelSpeed-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetWheelSpeed)))
  'SetWheelSpeed-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetWheelSpeed)))
  'SetWheelSpeed-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetWheelSpeed)))
  "Returns string type for a service object of type '<SetWheelSpeed>"
  "capra_msgs/SetWheelSpeed")