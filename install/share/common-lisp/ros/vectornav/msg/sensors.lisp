; Auto-generated. Do not edit!


(cl:in-package vectornav-msg)


;//! \htmlinclude sensors.msg.html

(cl:defclass <sensors> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (Mag
    :reader Mag
    :initarg :Mag
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (Accel
    :reader Accel
    :initarg :Accel
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (Gyro
    :reader Gyro
    :initarg :Gyro
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (Temp
    :reader Temp
    :initarg :Temp
    :type cl:float
    :initform 0.0)
   (Pressure
    :reader Pressure
    :initarg :Pressure
    :type cl:float
    :initform 0.0))
)

(cl:defclass sensors (<sensors>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <sensors>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'sensors)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name vectornav-msg:<sensors> is deprecated: use vectornav-msg:sensors instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <sensors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:header-val is deprecated.  Use vectornav-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'Mag-val :lambda-list '(m))
(cl:defmethod Mag-val ((m <sensors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Mag-val is deprecated.  Use vectornav-msg:Mag instead.")
  (Mag m))

(cl:ensure-generic-function 'Accel-val :lambda-list '(m))
(cl:defmethod Accel-val ((m <sensors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Accel-val is deprecated.  Use vectornav-msg:Accel instead.")
  (Accel m))

(cl:ensure-generic-function 'Gyro-val :lambda-list '(m))
(cl:defmethod Gyro-val ((m <sensors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Gyro-val is deprecated.  Use vectornav-msg:Gyro instead.")
  (Gyro m))

(cl:ensure-generic-function 'Temp-val :lambda-list '(m))
(cl:defmethod Temp-val ((m <sensors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Temp-val is deprecated.  Use vectornav-msg:Temp instead.")
  (Temp m))

(cl:ensure-generic-function 'Pressure-val :lambda-list '(m))
(cl:defmethod Pressure-val ((m <sensors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Pressure-val is deprecated.  Use vectornav-msg:Pressure instead.")
  (Pressure m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <sensors>) ostream)
  "Serializes a message object of type '<sensors>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Mag) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Accel) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'Gyro) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Temp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Pressure))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <sensors>) istream)
  "Deserializes a message object of type '<sensors>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Mag) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Accel) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'Gyro) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Temp) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Pressure) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<sensors>)))
  "Returns string type for a message object of type '<sensors>"
  "vectornav/sensors")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'sensors)))
  "Returns string type for a message object of type 'sensors"
  "vectornav/sensors")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<sensors>)))
  "Returns md5sum for a message object of type '<sensors>"
  "c5215e6ec84aeaa8f38adc4380e155e4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'sensors)))
  "Returns md5sum for a message object of type 'sensors"
  "c5215e6ec84aeaa8f38adc4380e155e4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<sensors>)))
  "Returns full string definition for message of type '<sensors>"
  (cl:format cl:nil "std_msgs/Header       header~%geometry_msgs/Vector3 Mag ~%geometry_msgs/Vector3 Accel~%geometry_msgs/Vector3 Gyro~%float32               Temp~%float32               Pressure~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'sensors)))
  "Returns full string definition for message of type 'sensors"
  (cl:format cl:nil "std_msgs/Header       header~%geometry_msgs/Vector3 Mag ~%geometry_msgs/Vector3 Accel~%geometry_msgs/Vector3 Gyro~%float32               Temp~%float32               Pressure~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <sensors>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Mag))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Accel))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'Gyro))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <sensors>))
  "Converts a ROS message object to a list"
  (cl:list 'sensors
    (cl:cons ':header (header msg))
    (cl:cons ':Mag (Mag msg))
    (cl:cons ':Accel (Accel msg))
    (cl:cons ':Gyro (Gyro msg))
    (cl:cons ':Temp (Temp msg))
    (cl:cons ':Pressure (Pressure msg))
))
