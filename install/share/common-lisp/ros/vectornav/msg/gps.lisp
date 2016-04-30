; Auto-generated. Do not edit!


(cl:in-package vectornav-msg)


;//! \htmlinclude gps.msg.html

(cl:defclass <gps> (roslisp-msg-protocol:ros-message)
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
   (GpsFix
    :reader GpsFix
    :initarg :GpsFix
    :type cl:fixnum
    :initform 0)
   (NumSats
    :reader NumSats
    :initarg :NumSats
    :type cl:fixnum
    :initform 0)
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
   (NedAcc
    :reader NedAcc
    :initarg :NedAcc
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (SpeedAcc
    :reader SpeedAcc
    :initarg :SpeedAcc
    :type cl:float
    :initform 0.0)
   (TimeAcc
    :reader TimeAcc
    :initarg :TimeAcc
    :type cl:float
    :initform 0.0))
)

(cl:defclass gps (<gps>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gps>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gps)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name vectornav-msg:<gps> is deprecated: use vectornav-msg:gps instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:header-val is deprecated.  Use vectornav-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'Time-val :lambda-list '(m))
(cl:defmethod Time-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Time-val is deprecated.  Use vectornav-msg:Time instead.")
  (Time m))

(cl:ensure-generic-function 'Week-val :lambda-list '(m))
(cl:defmethod Week-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:Week-val is deprecated.  Use vectornav-msg:Week instead.")
  (Week m))

(cl:ensure-generic-function 'GpsFix-val :lambda-list '(m))
(cl:defmethod GpsFix-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:GpsFix-val is deprecated.  Use vectornav-msg:GpsFix instead.")
  (GpsFix m))

(cl:ensure-generic-function 'NumSats-val :lambda-list '(m))
(cl:defmethod NumSats-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:NumSats-val is deprecated.  Use vectornav-msg:NumSats instead.")
  (NumSats m))

(cl:ensure-generic-function 'LLA-val :lambda-list '(m))
(cl:defmethod LLA-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:LLA-val is deprecated.  Use vectornav-msg:LLA instead.")
  (LLA m))

(cl:ensure-generic-function 'NedVel-val :lambda-list '(m))
(cl:defmethod NedVel-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:NedVel-val is deprecated.  Use vectornav-msg:NedVel instead.")
  (NedVel m))

(cl:ensure-generic-function 'NedAcc-val :lambda-list '(m))
(cl:defmethod NedAcc-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:NedAcc-val is deprecated.  Use vectornav-msg:NedAcc instead.")
  (NedAcc m))

(cl:ensure-generic-function 'SpeedAcc-val :lambda-list '(m))
(cl:defmethod SpeedAcc-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:SpeedAcc-val is deprecated.  Use vectornav-msg:SpeedAcc instead.")
  (SpeedAcc m))

(cl:ensure-generic-function 'TimeAcc-val :lambda-list '(m))
(cl:defmethod TimeAcc-val ((m <gps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader vectornav-msg:TimeAcc-val is deprecated.  Use vectornav-msg:TimeAcc instead.")
  (TimeAcc m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<gps>)))
    "Constants for message type '<gps>"
  '((:GPSFIX_NO_FIX . 0)
    (:GPSFIX_TIME_ONLY . 1)
    (:GPSFIX_2D_FIX . 3)
    (:GPSFIX_3D_FIX . 4))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'gps)))
    "Constants for message type 'gps"
  '((:GPSFIX_NO_FIX . 0)
    (:GPSFIX_TIME_ONLY . 1)
    (:GPSFIX_2D_FIX . 3)
    (:GPSFIX_3D_FIX . 4))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gps>) ostream)
  "Serializes a message object of type '<gps>"
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
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'GpsFix)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'NumSats)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'LLA) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'NedVel) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'NedAcc) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'SpeedAcc))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'TimeAcc))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gps>) istream)
  "Deserializes a message object of type '<gps>"
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
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'GpsFix)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'NumSats)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'LLA) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'NedVel) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'NedAcc) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'SpeedAcc) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'TimeAcc) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gps>)))
  "Returns string type for a message object of type '<gps>"
  "vectornav/gps")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gps)))
  "Returns string type for a message object of type 'gps"
  "vectornav/gps")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gps>)))
  "Returns md5sum for a message object of type '<gps>"
  "31fb486026a7554448f3ce4a0e767b5c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gps)))
  "Returns md5sum for a message object of type 'gps"
  "31fb486026a7554448f3ce4a0e767b5c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gps>)))
  "Returns full string definition for message of type '<gps>"
  (cl:format cl:nil "std_msgs/Header       header~%float64               Time~%uint16                Week~%uint8                 GpsFix~%uint8                 NumSats~%geometry_msgs/Vector3 LLA~%geometry_msgs/Vector3 NedVel~%geometry_msgs/Vector3 NedAcc~%float32               SpeedAcc~%float32               TimeAcc~%~%~%uint8 GPSFIX_NO_FIX=0~%uint8 GPSFIX_TIME_ONLY=1~%uint8 GPSFIX_2D_FIX=3~%uint8 GPSFIX_3D_FIX=4~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gps)))
  "Returns full string definition for message of type 'gps"
  (cl:format cl:nil "std_msgs/Header       header~%float64               Time~%uint16                Week~%uint8                 GpsFix~%uint8                 NumSats~%geometry_msgs/Vector3 LLA~%geometry_msgs/Vector3 NedVel~%geometry_msgs/Vector3 NedAcc~%float32               SpeedAcc~%float32               TimeAcc~%~%~%uint8 GPSFIX_NO_FIX=0~%uint8 GPSFIX_TIME_ONLY=1~%uint8 GPSFIX_2D_FIX=3~%uint8 GPSFIX_3D_FIX=4~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gps>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     2
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'LLA))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'NedVel))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'NedAcc))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gps>))
  "Converts a ROS message object to a list"
  (cl:list 'gps
    (cl:cons ':header (header msg))
    (cl:cons ':Time (Time msg))
    (cl:cons ':Week (Week msg))
    (cl:cons ':GpsFix (GpsFix msg))
    (cl:cons ':NumSats (NumSats msg))
    (cl:cons ':LLA (LLA msg))
    (cl:cons ':NedVel (NedVel msg))
    (cl:cons ':NedAcc (NedAcc msg))
    (cl:cons ':SpeedAcc (SpeedAcc msg))
    (cl:cons ':TimeAcc (TimeAcc msg))
))
