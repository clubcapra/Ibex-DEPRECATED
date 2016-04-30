; Auto-generated. Do not edit!


(cl:in-package capra_msgs-msg)


;//! \htmlinclude SensorsTelemetry.msg.html

(cl:defclass <SensorsTelemetry> (roslisp-msg-protocol:ros-message)
  ((Fan
    :reader Fan
    :initarg :Fan
    :type cl:boolean
    :initform cl:nil)
   (IMU
    :reader IMU
    :initarg :IMU
    :type cl:boolean
    :initform cl:nil)
   (Camera
    :reader Camera
    :initarg :Camera
    :type cl:boolean
    :initform cl:nil)
   (GPS
    :reader GPS
    :initarg :GPS
    :type cl:boolean
    :initform cl:nil)
   (Switch
    :reader Switch
    :initarg :Switch
    :type cl:boolean
    :initform cl:nil)
   (Lights
    :reader Lights
    :initarg :Lights
    :type cl:boolean
    :initform cl:nil)
   (RangeFinder
    :reader RangeFinder
    :initarg :RangeFinder
    :type cl:boolean
    :initform cl:nil)
   (Tension
    :reader Tension
    :initarg :Tension
    :type cl:float
    :initform 0.0)
   (Current
    :reader Current
    :initarg :Current
    :type cl:float
    :initform 0.0)
   (Temperature
    :reader Temperature
    :initarg :Temperature
    :type cl:float
    :initform 0.0)
   (EstopManual
    :reader EstopManual
    :initarg :EstopManual
    :type cl:boolean
    :initform cl:nil)
   (EstopRemote
    :reader EstopRemote
    :initarg :EstopRemote
    :type cl:boolean
    :initform cl:nil)
   (Mode
    :reader Mode
    :initarg :Mode
    :type cl:string
    :initform ""))
)

(cl:defclass SensorsTelemetry (<SensorsTelemetry>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SensorsTelemetry>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SensorsTelemetry)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-msg:<SensorsTelemetry> is deprecated: use capra_msgs-msg:SensorsTelemetry instead.")))

(cl:ensure-generic-function 'Fan-val :lambda-list '(m))
(cl:defmethod Fan-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:Fan-val is deprecated.  Use capra_msgs-msg:Fan instead.")
  (Fan m))

(cl:ensure-generic-function 'IMU-val :lambda-list '(m))
(cl:defmethod IMU-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:IMU-val is deprecated.  Use capra_msgs-msg:IMU instead.")
  (IMU m))

(cl:ensure-generic-function 'Camera-val :lambda-list '(m))
(cl:defmethod Camera-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:Camera-val is deprecated.  Use capra_msgs-msg:Camera instead.")
  (Camera m))

(cl:ensure-generic-function 'GPS-val :lambda-list '(m))
(cl:defmethod GPS-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:GPS-val is deprecated.  Use capra_msgs-msg:GPS instead.")
  (GPS m))

(cl:ensure-generic-function 'Switch-val :lambda-list '(m))
(cl:defmethod Switch-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:Switch-val is deprecated.  Use capra_msgs-msg:Switch instead.")
  (Switch m))

(cl:ensure-generic-function 'Lights-val :lambda-list '(m))
(cl:defmethod Lights-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:Lights-val is deprecated.  Use capra_msgs-msg:Lights instead.")
  (Lights m))

(cl:ensure-generic-function 'RangeFinder-val :lambda-list '(m))
(cl:defmethod RangeFinder-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:RangeFinder-val is deprecated.  Use capra_msgs-msg:RangeFinder instead.")
  (RangeFinder m))

(cl:ensure-generic-function 'Tension-val :lambda-list '(m))
(cl:defmethod Tension-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:Tension-val is deprecated.  Use capra_msgs-msg:Tension instead.")
  (Tension m))

(cl:ensure-generic-function 'Current-val :lambda-list '(m))
(cl:defmethod Current-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:Current-val is deprecated.  Use capra_msgs-msg:Current instead.")
  (Current m))

(cl:ensure-generic-function 'Temperature-val :lambda-list '(m))
(cl:defmethod Temperature-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:Temperature-val is deprecated.  Use capra_msgs-msg:Temperature instead.")
  (Temperature m))

(cl:ensure-generic-function 'EstopManual-val :lambda-list '(m))
(cl:defmethod EstopManual-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:EstopManual-val is deprecated.  Use capra_msgs-msg:EstopManual instead.")
  (EstopManual m))

(cl:ensure-generic-function 'EstopRemote-val :lambda-list '(m))
(cl:defmethod EstopRemote-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:EstopRemote-val is deprecated.  Use capra_msgs-msg:EstopRemote instead.")
  (EstopRemote m))

(cl:ensure-generic-function 'Mode-val :lambda-list '(m))
(cl:defmethod Mode-val ((m <SensorsTelemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-msg:Mode-val is deprecated.  Use capra_msgs-msg:Mode instead.")
  (Mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SensorsTelemetry>) ostream)
  "Serializes a message object of type '<SensorsTelemetry>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Fan) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'IMU) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Camera) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'GPS) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Switch) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'Lights) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'RangeFinder) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Tension))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Temperature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'EstopManual) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'EstopRemote) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'Mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'Mode))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SensorsTelemetry>) istream)
  "Deserializes a message object of type '<SensorsTelemetry>"
    (cl:setf (cl:slot-value msg 'Fan) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'IMU) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'Camera) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'GPS) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'Switch) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'Lights) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'RangeFinder) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Tension) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Temperature) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'EstopManual) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'EstopRemote) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'Mode) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'Mode) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SensorsTelemetry>)))
  "Returns string type for a message object of type '<SensorsTelemetry>"
  "capra_msgs/SensorsTelemetry")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SensorsTelemetry)))
  "Returns string type for a message object of type 'SensorsTelemetry"
  "capra_msgs/SensorsTelemetry")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SensorsTelemetry>)))
  "Returns md5sum for a message object of type '<SensorsTelemetry>"
  "4f34973b0129c8ca57e159449b5e31bb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SensorsTelemetry)))
  "Returns md5sum for a message object of type 'SensorsTelemetry"
  "4f34973b0129c8ca57e159449b5e31bb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SensorsTelemetry>)))
  "Returns full string definition for message of type '<SensorsTelemetry>"
  (cl:format cl:nil "bool Fan~%bool IMU~%bool Camera~%bool GPS~%bool Switch~%bool Lights~%bool RangeFinder~%~%float32 Tension~%float32 Current~%float32 Temperature~%~%bool EstopManual~%bool EstopRemote~%~%string Mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SensorsTelemetry)))
  "Returns full string definition for message of type 'SensorsTelemetry"
  (cl:format cl:nil "bool Fan~%bool IMU~%bool Camera~%bool GPS~%bool Switch~%bool Lights~%bool RangeFinder~%~%float32 Tension~%float32 Current~%float32 Temperature~%~%bool EstopManual~%bool EstopRemote~%~%string Mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SensorsTelemetry>))
  (cl:+ 0
     1
     1
     1
     1
     1
     1
     1
     4
     4
     4
     1
     1
     4 (cl:length (cl:slot-value msg 'Mode))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SensorsTelemetry>))
  "Converts a ROS message object to a list"
  (cl:list 'SensorsTelemetry
    (cl:cons ':Fan (Fan msg))
    (cl:cons ':IMU (IMU msg))
    (cl:cons ':Camera (Camera msg))
    (cl:cons ':GPS (GPS msg))
    (cl:cons ':Switch (Switch msg))
    (cl:cons ':Lights (Lights msg))
    (cl:cons ':RangeFinder (RangeFinder msg))
    (cl:cons ':Tension (Tension msg))
    (cl:cons ':Current (Current msg))
    (cl:cons ':Temperature (Temperature msg))
    (cl:cons ':EstopManual (EstopManual msg))
    (cl:cons ':EstopRemote (EstopRemote msg))
    (cl:cons ':Mode (Mode msg))
))
