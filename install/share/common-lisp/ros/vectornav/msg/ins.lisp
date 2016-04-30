; Auto-generated. Do not edit!


(cl:in-package vectornav-msg)


;//! \htmlinclude ins.msg.html

(cl:defclass <ins> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (Time
    :reader Time
    :initarg :Time
    :type cl:float
    :initform 0.0)
   (Week
    :reader Week
    :initarg :Week
    :type cl:fixnum
    :initform 0)
   (Status
    :reader Status
    :initarg :Status
    :type cl:fixnum
    :initform 0)
   (RPY
    :reader RPY
    :initarg :RPY
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (LLA
    :reader LLA
    :initarg :LLA
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (NedVel
    :reader NedVel
    :initarg :NedVel
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (AttUncerainty
    :reader AttUncerainty
    :initarg :AttUncerainty
    :type cl:float
    :initform 0.0)
   (PosUncerainty
    :reader PosUncerainty
    :initarg :PosUncerainty
    :type cl:float
    :initform 0.0)
   (VelUncerainty
    :reader VelUncerainty
    :initarg :VelUncerainty
    :type cl:float
    :initform 0.0))
)

(cl:defclass ins (<ins>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ins>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ins)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name vectornav-msg:<ins> is deprecated: use vectornav-msg:ins instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:header-val is deprecated.  Use vectornav-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'Time-val :lambda-list '(m))
(cl:defmethod Time-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Time-val is deprecated.  Use vectornav-msg:Time instead.")
  (Time m))

(cl:ensure-generic-function 'Week-val :lambda-list '(m))
(cl:defmethod Week-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Week-val is deprecated.  Use vectornav-msg:Week instead.")
  (Week m))

(cl:ensure-generic-function 'Status-val :lambda-list '(m))
(cl:defmethod Status-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Status-val is deprecated.  Use vectornav-msg:Status instead.")
  (Status m))

(cl:ensure-generic-function 'RPY-val :lambda-list '(m))
(cl:defmethod RPY-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:RPY-val is deprecated.  Use vectornav-msg:RPY instead.")
  (RPY m))

(cl:ensure-generic-function 'LLA-val :lambda-list '(m))
(cl:defmethod LLA-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:LLA-val is deprecated.  Use vectornav-msg:LLA instead.")
  (LLA m))

(cl:ensure-generic-function 'NedVel-val :lambda-list '(m))
(cl:defmethod NedVel-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:NedVel-val is deprecated.  Use vectornav-msg:NedVel instead.")
  (NedVel m))

(cl:ensure-generic-function 'AttUncerainty-val :lambda-list '(m))
(cl:defmethod AttUncerainty-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:AttUncerainty-val is deprecated.  Use vectornav-msg:AttUncerainty instead.")
  (AttUncerainty m))

(cl:ensure-generic-function 'PosUncerainty-val :lambda-list '(m))
(cl:defmethod PosUncerainty-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:PosUncerainty-val is deprecated.  Use vectornav-msg:PosUncerainty instead.")
  (PosUncerainty m))

(cl:ensure-generic-function 'VelUncerainty-val :lambda-list '(m))
(cl:defmethod VelUncerainty-val ((m <ins>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:VelUncerainty-val is deprecated.  Use vectornav-msg:VelUncerainty instead.")
  (VelUncerainty m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ins>)))
    "Constants for message type '<ins>"
  '((:STATUS_INSUFFICIENT_MOTION . 1)
    (:STATUS_INS_OK . 2)
    (:STATUS_GPS_FIX_OK . 4)
    (:STATUS_SENSOR_ERROR_TIME . 8)
    (:STATUS_SENSOR_ERROR_IMU . 16)
    (:STATUS_SENSOR_ERROR_MAG . 32)
    (:STATUS_SENSOR_ERROR_GPS . 64))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ins)))
    "Constants for message type 'ins"
  '((:STATUS_INSUFFICIENT_MOTION . 1)
    (:STATUS_INS_OK . 2)
    (:STATUS_GPS_FIX_OK . 4)
    (:STATUS_SENSOR_ERROR_TIME . 8)
    (:STATUS_SENSOR_ERROR_IMU . 16)
    (:STATUS_SENSOR_ERROR_MAG . 32)
    (:STATUS_SENSOR_ERROR_GPS . 64))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ins>) ostream)
  "Serializes a message object of type '<ins>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'Time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Week)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Week)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Status)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'RPY) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'LLA) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'NedVel) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'AttUncerainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'PosUncerainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'VelUncerainty))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ins>) istream)
  "Deserializes a message object of type '<ins>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Time) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Week)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Week)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'Status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'Status)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'RPY) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'LLA) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'NedVel) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'AttUncerainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'PosUncerainty) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'VelUncerainty) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ins>)))
  "Returns string type for a message object of type '<ins>"
  "vectornav/ins")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ins)))
  "Returns string type for a message object of type 'ins"
  "vectornav/ins")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ins>)))
  "Returns md5sum for a message object of type '<ins>"
  "ac6f3c29ebbc55e6d11838d54bc5749b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ins)))
  "Returns md5sum for a message object of type 'ins"
  "ac6f3c29ebbc55e6d11838d54bc5749b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ins>)))
  "Returns full string definition for message of type '<ins>"
  (cl:format cl:nil "std_msgs/Header       header~%float64               Time~%uint16                Week~%uint16                Status~%geometry_msgs/Vector3 RPY~%geometry_msgs/Vector3 LLA~%geometry_msgs/Vector3 NedVel~%float32               AttUncerainty~%float32               PosUncerainty~%float32               VelUncerainty~%~%~%uint16 STATUS_INSUFFICIENT_MOTION=1~%uint16 STATUS_INS_OK=2~%uint16 STATUS_GPS_FIX_OK=4~%uint16 STATUS_SENSOR_ERROR_TIME=8~%uint16 STATUS_SENSOR_ERROR_IMU=16~%uint16 STATUS_SENSOR_ERROR_MAG=32~%uint16 STATUS_SENSOR_ERROR_GPS=64~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ins)))
  "Returns full string definition for message of type 'ins"
  (cl:format cl:nil "std_msgs/Header       header~%float64               Time~%uint16                Week~%uint16                Status~%geometry_msgs/Vector3 RPY~%geometry_msgs/Vector3 LLA~%geometry_msgs/Vector3 NedVel~%float32               AttUncerainty~%float32               PosUncerainty~%float32               VelUncerainty~%~%~%uint16 STATUS_INSUFFICIENT_MOTION=1~%uint16 STATUS_INS_OK=2~%uint16 STATUS_GPS_FIX_OK=4~%uint16 STATUS_SENSOR_ERROR_TIME=8~%uint16 STATUS_SENSOR_ERROR_IMU=16~%uint16 STATUS_SENSOR_ERROR_MAG=32~%uint16 STATUS_SENSOR_ERROR_GPS=64~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ins>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     2
     2
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'RPY))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'LLA))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'NedVel))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ins>))
  "Converts a ROS message object to a list"
  (cl:list 'ins
    (cl:cons ':header (header msg))
    (cl:cons ':Time (Time msg))
    (cl:cons ':Week (Week msg))
    (cl:cons ':Status (Status msg))
    (cl:cons ':RPY (RPY msg))
    (cl:cons ':LLA (LLA msg))
    (cl:cons ':NedVel (NedVel msg))
    (cl:cons ':AttUncerainty (AttUncerainty msg))
    (cl:cons ':PosUncerainty (PosUncerainty msg))
    (cl:cons ':VelUncerainty (VelUncerainty msg))
))
