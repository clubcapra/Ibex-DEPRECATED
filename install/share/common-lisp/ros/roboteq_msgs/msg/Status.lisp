; Auto-generated. Do not edit!


(cl:in-package roboteq_msgs-msg)


;//! \htmlinclude Status.msg.html

(cl:defclass <Status> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (fault
    :reader fault
    :initarg :fault
    :type cl:fixnum
    :initform 0)
   (status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0)
   (ic_temperature
    :reader ic_temperature
    :initarg :ic_temperature
    :type cl:float
    :initform 0.0)
   (internal_voltage
    :reader internal_voltage
    :initarg :internal_voltage
    :type cl:float
    :initform 0.0)
   (adc_voltage
    :reader adc_voltage
    :initarg :adc_voltage
    :type cl:float
    :initform 0.0))
)

(cl:defclass Status (<Status>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Status>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Status)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name roboteq_msgs-msg:<Status> is deprecated: use roboteq_msgs-msg:Status instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:header-val is deprecated.  Use roboteq_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'fault-val :lambda-list '(m))
(cl:defmethod fault-val ((m <Status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:fault-val is deprecated.  Use roboteq_msgs-msg:fault instead.")
  (fault m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <Status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:status-val is deprecated.  Use roboteq_msgs-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'ic_temperature-val :lambda-list '(m))
(cl:defmethod ic_temperature-val ((m <Status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:ic_temperature-val is deprecated.  Use roboteq_msgs-msg:ic_temperature instead.")
  (ic_temperature m))

(cl:ensure-generic-function 'internal_voltage-val :lambda-list '(m))
(cl:defmethod internal_voltage-val ((m <Status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:internal_voltage-val is deprecated.  Use roboteq_msgs-msg:internal_voltage instead.")
  (internal_voltage m))

(cl:ensure-generic-function 'adc_voltage-val :lambda-list '(m))
(cl:defmethod adc_voltage-val ((m <Status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader roboteq_msgs-msg:adc_voltage-val is deprecated.  Use roboteq_msgs-msg:adc_voltage instead.")
  (adc_voltage m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Status>)))
    "Constants for message type '<Status>"
  '((:FAULT_OVERHEAT . 1)
    (:FAULT_OVERVOLTAGE . 2)
    (:FAULT_UNDERVOLTAGE . 4)
    (:FAULT_SHORT_CIRCUIT . 8)
    (:FAULT_EMERGENCY_STOP . 16)
    (:FAULT_SEPEX_EXCITATION_FAULT . 32)
    (:FAULT_MOSFET_FAILURE . 64)
    (:FAULT_STARTUP_CONFIG_FAULT . 128)
    (:STATUS_SERIAL_MODE . 1)
    (:STATUS_PULSE_MODE . 2)
    (:STATUS_ANALOG_MODE . 4)
    (:STATUS_POWER_STAGE_OFF . 8)
    (:STATUS_STALL_DETECTED . 16)
    (:STATUS_AT_LIMIT . 32)
    (:STATUS_MICROBASIC_SCRIPT_RUNNING . 128))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Status)))
    "Constants for message type 'Status"
  '((:FAULT_OVERHEAT . 1)
    (:FAULT_OVERVOLTAGE . 2)
    (:FAULT_UNDERVOLTAGE . 4)
    (:FAULT_SHORT_CIRCUIT . 8)
    (:FAULT_EMERGENCY_STOP . 16)
    (:FAULT_SEPEX_EXCITATION_FAULT . 32)
    (:FAULT_MOSFET_FAILURE . 64)
    (:FAULT_STARTUP_CONFIG_FAULT . 128)
    (:STATUS_SERIAL_MODE . 1)
    (:STATUS_PULSE_MODE . 2)
    (:STATUS_ANALOG_MODE . 4)
    (:STATUS_POWER_STAGE_OFF . 8)
    (:STATUS_STALL_DETECTED . 16)
    (:STATUS_AT_LIMIT . 32)
    (:STATUS_MICROBASIC_SCRIPT_RUNNING . 128))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Status>) ostream)
  "Serializes a message object of type '<Status>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fault)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ic_temperature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'internal_voltage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'adc_voltage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Status>) istream)
  "Deserializes a message object of type '<Status>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fault)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ic_temperature) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'internal_voltage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'adc_voltage) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Status>)))
  "Returns string type for a message object of type '<Status>"
  "roboteq_msgs/Status")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Status)))
  "Returns string type for a message object of type 'Status"
  "roboteq_msgs/Status")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Status>)))
  "Returns md5sum for a message object of type '<Status>"
  "d3a9b223fdfb0968255e25e5a859ac29")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Status)))
  "Returns md5sum for a message object of type 'Status"
  "d3a9b223fdfb0968255e25e5a859ac29")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Status>)))
  "Returns full string definition for message of type '<Status>"
  (cl:format cl:nil "# 10Hz status message for informational/diagnostics purposes~%Header header~%~%uint8 FAULT_OVERHEAT=1~%uint8 FAULT_OVERVOLTAGE=2~%uint8 FAULT_UNDERVOLTAGE=4~%uint8 FAULT_SHORT_CIRCUIT=8~%uint8 FAULT_EMERGENCY_STOP=16~%uint8 FAULT_SEPEX_EXCITATION_FAULT=32~%uint8 FAULT_MOSFET_FAILURE=64~%uint8 FAULT_STARTUP_CONFIG_FAULT=128~%uint8 fault~%~%uint8 STATUS_SERIAL_MODE=1~%uint8 STATUS_PULSE_MODE=2~%uint8 STATUS_ANALOG_MODE=4~%uint8 STATUS_POWER_STAGE_OFF=8~%uint8 STATUS_STALL_DETECTED=16~%uint8 STATUS_AT_LIMIT=32~%uint8 STATUS_MICROBASIC_SCRIPT_RUNNING=128~%uint8 status~%~%# Temperature of main logic chip (C)~%float32 ic_temperature~%~%# Internal supply and reference voltage (V)~%float32 internal_voltage~%float32 adc_voltage~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Status)))
  "Returns full string definition for message of type 'Status"
  (cl:format cl:nil "# 10Hz status message for informational/diagnostics purposes~%Header header~%~%uint8 FAULT_OVERHEAT=1~%uint8 FAULT_OVERVOLTAGE=2~%uint8 FAULT_UNDERVOLTAGE=4~%uint8 FAULT_SHORT_CIRCUIT=8~%uint8 FAULT_EMERGENCY_STOP=16~%uint8 FAULT_SEPEX_EXCITATION_FAULT=32~%uint8 FAULT_MOSFET_FAILURE=64~%uint8 FAULT_STARTUP_CONFIG_FAULT=128~%uint8 fault~%~%uint8 STATUS_SERIAL_MODE=1~%uint8 STATUS_PULSE_MODE=2~%uint8 STATUS_ANALOG_MODE=4~%uint8 STATUS_POWER_STAGE_OFF=8~%uint8 STATUS_STALL_DETECTED=16~%uint8 STATUS_AT_LIMIT=32~%uint8 STATUS_MICROBASIC_SCRIPT_RUNNING=128~%uint8 status~%~%# Temperature of main logic chip (C)~%float32 ic_temperature~%~%# Internal supply and reference voltage (V)~%float32 internal_voltage~%float32 adc_voltage~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Status>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Status>))
  "Converts a ROS message object to a list"
  (cl:list 'Status
    (cl:cons ':header (header msg))
    (cl:cons ':fault (fault msg))
    (cl:cons ':status (status msg))
    (cl:cons ':ic_temperature (ic_temperature msg))
    (cl:cons ':internal_voltage (internal_voltage msg))
    (cl:cons ':adc_voltage (adc_voltage msg))
))
