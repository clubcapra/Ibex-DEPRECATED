; Auto-generated. Do not edit!


(cl:in-package roboteq_msgs-msg)


;//! \htmlinclude Feedback.msg.html

(cl:defclass <Feedback> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (motor_current
    :reader motor_current
    :initarg :motor_current
    :type cl:float
    :initform 0.0)
   (motor_power
    :reader motor_power
    :initarg :motor_power
    :type cl:float
    :initform 0.0)
   (commanded_velocity
    :reader commanded_velocity
    :initarg :commanded_velocity
    :type cl:float
    :initform 0.0)
   (measured_velocity
    :reader measured_velocity
    :initarg :measured_velocity
    :type cl:float
    :initform 0.0)
   (measured_position
    :reader measured_position
    :initarg :measured_position
    :type cl:float
    :initform 0.0)
   (supply_voltage
    :reader supply_voltage
    :initarg :supply_voltage
    :type cl:float
    :initform 0.0)
   (supply_current
    :reader supply_current
    :initarg :supply_current
    :type cl:float
    :initform 0.0)
   (motor_temperature
    :reader motor_temperature
    :initarg :motor_temperature
    :type cl:float
    :initform 0.0)
   (channel_temperature
    :reader channel_temperature
    :initarg :channel_temperature
    :type cl:float
    :initform 0.0))
)

(cl:defclass Feedback (<Feedback>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Feedback>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Feedback)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name roboteq_msgs-msg:<Feedback> is deprecated: use roboteq_msgs-msg:Feedback instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:header-val is deprecated.  Use roboteq_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'motor_current-val :lambda-list '(m))
(cl:defmethod motor_current-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:motor_current-val is deprecated.  Use roboteq_msgs-msg:motor_current instead.")
  (motor_current m))

(cl:ensure-generic-function 'motor_power-val :lambda-list '(m))
(cl:defmethod motor_power-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:motor_power-val is deprecated.  Use roboteq_msgs-msg:motor_power instead.")
  (motor_power m))

(cl:ensure-generic-function 'commanded_velocity-val :lambda-list '(m))
(cl:defmethod commanded_velocity-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:commanded_velocity-val is deprecated.  Use roboteq_msgs-msg:commanded_velocity instead.")
  (commanded_velocity m))

(cl:ensure-generic-function 'measured_velocity-val :lambda-list '(m))
(cl:defmethod measured_velocity-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:measured_velocity-val is deprecated.  Use roboteq_msgs-msg:measured_velocity instead.")
  (measured_velocity m))

(cl:ensure-generic-function 'measured_position-val :lambda-list '(m))
(cl:defmethod measured_position-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:measured_position-val is deprecated.  Use roboteq_msgs-msg:measured_position instead.")
  (measured_position m))

(cl:ensure-generic-function 'supply_voltage-val :lambda-list '(m))
(cl:defmethod supply_voltage-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:supply_voltage-val is deprecated.  Use roboteq_msgs-msg:supply_voltage instead.")
  (supply_voltage m))

(cl:ensure-generic-function 'supply_current-val :lambda-list '(m))
(cl:defmethod supply_current-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:supply_current-val is deprecated.  Use roboteq_msgs-msg:supply_current instead.")
  (supply_current m))

(cl:ensure-generic-function 'motor_temperature-val :lambda-list '(m))
(cl:defmethod motor_temperature-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:motor_temperature-val is deprecated.  Use roboteq_msgs-msg:motor_temperature instead.")
  (motor_temperature m))

(cl:ensure-generic-function 'channel_temperature-val :lambda-list '(m))
(cl:defmethod channel_temperature-val ((m <Feedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:channel_temperature-val is deprecated.  Use roboteq_msgs-msg:channel_temperature instead.")
  (channel_temperature m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Feedback>) ostream)
  "Serializes a message object of type '<Feedback>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'motor_current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'motor_power))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'commanded_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'measured_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'measured_position))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'supply_voltage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'supply_current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'motor_temperature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'channel_temperature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Feedback>) istream)
  "Deserializes a message object of type '<Feedback>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'motor_current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'motor_power) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'commanded_velocity) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'measured_velocity) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'measured_position) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'supply_voltage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'supply_current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'motor_temperature) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'channel_temperature) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Feedback>)))
  "Returns string type for a message object of type '<Feedback>"
  "roboteq_msgs/Feedback")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Feedback)))
  "Returns string type for a message object of type 'Feedback"
  "roboteq_msgs/Feedback")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Feedback>)))
  "Returns md5sum for a message object of type '<Feedback>"
  "2b31653367731d6254182bb2f9dbb81a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Feedback)))
  "Returns md5sum for a message object of type 'Feedback"
  "2b31653367731d6254182bb2f9dbb81a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Feedback>)))
  "Returns full string definition for message of type '<Feedback>"
  (cl:format cl:nil "# 50Hz feedback message for controls purposes~%Header header~%~%# Current flowing in the motors (A)~%float32 motor_current~%~%# Output stage, as a proportion of full (-1..1)~%float32 motor_power~%~%# Commanded and measured speed of the motors (rad/s)~%# Position is reported in rads, and wraps around +-6M~%float32 commanded_velocity~%float32 measured_velocity~%float32 measured_position~%~%# Electrical power supply to the driver (V, A)~%float32 supply_voltage~%float32 supply_current~%~%# Measured temperatures (C)~%# Motor temp is processed from a thermal sensor connected to analog input 1.~%float32 motor_temperature~%# Channel temp is the temperature of the FETs. This is reported by the controller.~%float32 channel_temperature~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Feedback)))
  "Returns full string definition for message of type 'Feedback"
  (cl:format cl:nil "# 50Hz feedback message for controls purposes~%Header header~%~%# Current flowing in the motors (A)~%float32 motor_current~%~%# Output stage, as a proportion of full (-1..1)~%float32 motor_power~%~%# Commanded and measured speed of the motors (rad/s)~%# Position is reported in rads, and wraps around +-6M~%float32 commanded_velocity~%float32 measured_velocity~%float32 measured_position~%~%# Electrical power supply to the driver (V, A)~%float32 supply_voltage~%float32 supply_current~%~%# Measured temperatures (C)~%# Motor temp is processed from a thermal sensor connected to analog input 1.~%float32 motor_temperature~%# Channel temp is the temperature of the FETs. This is reported by the controller.~%float32 channel_temperature~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Feedback>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Feedback>))
  "Converts a ROS message object to a list"
  (cl:list 'Feedback
    (cl:cons ':header (header msg))
    (cl:cons ':motor_current (motor_current msg))
    (cl:cons ':motor_power (motor_power msg))
    (cl:cons ':commanded_velocity (commanded_velocity msg))
    (cl:cons ':measured_velocity (measured_velocity msg))
    (cl:cons ':measured_position (measured_position msg))
    (cl:cons ':supply_voltage (supply_voltage msg))
    (cl:cons ':supply_current (supply_current msg))
    (cl:cons ':motor_temperature (motor_temperature msg))
    (cl:cons ':channel_temperature (channel_temperature msg))
))
