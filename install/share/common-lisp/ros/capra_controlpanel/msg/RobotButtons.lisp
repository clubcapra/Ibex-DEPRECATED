; Auto-generated. Do not edit!


(cl:in-package capra_controlpanel-msg)


;//! \htmlinclude RobotButtons.msg.html

(cl:defclass <RobotButtons> (roslisp-msg-protocol:ros-message)
  ((fan
    :reader fan
    :initarg :fan
    :type cl:boolean
    :initform cl:nil)
   (imu
    :reader imu
    :initarg :imu
    :type cl:boolean
    :initform cl:nil)
   (camera
    :reader camera
    :initarg :camera
    :type cl:boolean
    :initform cl:nil)
   (gps
    :reader gps
    :initarg :gps
    :type cl:boolean
    :initform cl:nil)
   (switch
    :reader switch
    :initarg :switch
    :type cl:boolean
    :initform cl:nil)
   (lights
    :reader lights
    :initarg :lights
    :type cl:boolean
    :initform cl:nil)
   (rangefinder
    :reader rangefinder
    :initarg :rangefinder
    :type cl:boolean
    :initform cl:nil)
   (estopmanual
    :reader estopmanual
    :initarg :estopmanual
    :type cl:boolean
    :initform cl:nil)
   (estopremote
    :reader estopremote
    :initarg :estopremote
    :type cl:boolean
    :initform cl:nil)
   (mode
    :reader mode
    :initarg :mode
    :type cl:string
    :initform ""))
)

(cl:defclass RobotButtons (<RobotButtons>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RobotButtons>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RobotButtons)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_controlpanel-msg:<RobotButtons> is deprecated: use capra_controlpanel-msg:RobotButtons instead.")))

(cl:ensure-generic-function 'fan-val :lambda-list '(m))
(cl:defmethod fan-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:fan-val is deprecated.  Use capra_controlpanel-msg:fan instead.")
  (fan m))

(cl:ensure-generic-function 'imu-val :lambda-list '(m))
(cl:defmethod imu-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:imu-val is deprecated.  Use capra_controlpanel-msg:imu instead.")
  (imu m))

(cl:ensure-generic-function 'camera-val :lambda-list '(m))
(cl:defmethod camera-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:camera-val is deprecated.  Use capra_controlpanel-msg:camera instead.")
  (camera m))

(cl:ensure-generic-function 'gps-val :lambda-list '(m))
(cl:defmethod gps-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:gps-val is deprecated.  Use capra_controlpanel-msg:gps instead.")
  (gps m))

(cl:ensure-generic-function 'switch-val :lambda-list '(m))
(cl:defmethod switch-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:switch-val is deprecated.  Use capra_controlpanel-msg:switch instead.")
  (switch m))

(cl:ensure-generic-function 'lights-val :lambda-list '(m))
(cl:defmethod lights-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:lights-val is deprecated.  Use capra_controlpanel-msg:lights instead.")
  (lights m))

(cl:ensure-generic-function 'rangefinder-val :lambda-list '(m))
(cl:defmethod rangefinder-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:rangefinder-val is deprecated.  Use capra_controlpanel-msg:rangefinder instead.")
  (rangefinder m))

(cl:ensure-generic-function 'estopmanual-val :lambda-list '(m))
(cl:defmethod estopmanual-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:estopmanual-val is deprecated.  Use capra_controlpanel-msg:estopmanual instead.")
  (estopmanual m))

(cl:ensure-generic-function 'estopremote-val :lambda-list '(m))
(cl:defmethod estopremote-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:estopremote-val is deprecated.  Use capra_controlpanel-msg:estopremote instead.")
  (estopremote m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <RobotButtons>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-msg:mode-val is deprecated.  Use capra_controlpanel-msg:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RobotButtons>) ostream)
  "Serializes a message object of type '<RobotButtons>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fan) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'imu) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'camera) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gps) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'switch) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'lights) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rangefinder) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'estopmanual) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'estopremote) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mode))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RobotButtons>) istream)
  "Deserializes a message object of type '<RobotButtons>"
    (cl:setf (cl:slot-value msg 'fan) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'imu) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'camera) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gps) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'switch) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'lights) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rangefinder) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'estopmanual) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'estopremote) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mode) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RobotButtons>)))
  "Returns string type for a message object of type '<RobotButtons>"
  "capra_controlpanel/RobotButtons")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RobotButtons)))
  "Returns string type for a message object of type 'RobotButtons"
  "capra_controlpanel/RobotButtons")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RobotButtons>)))
  "Returns md5sum for a message object of type '<RobotButtons>"
  "6bdaf8cf1ba24dbdb8192b744a7ad390")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RobotButtons)))
  "Returns md5sum for a message object of type 'RobotButtons"
  "6bdaf8cf1ba24dbdb8192b744a7ad390")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RobotButtons>)))
  "Returns full string definition for message of type '<RobotButtons>"
  (cl:format cl:nil "bool fan~%bool imu~%bool camera~%bool gps~%bool switch~%bool lights~%bool rangefinder~%bool estopmanual~%bool estopremote~%string mode~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RobotButtons)))
  "Returns full string definition for message of type 'RobotButtons"
  (cl:format cl:nil "bool fan~%bool imu~%bool camera~%bool gps~%bool switch~%bool lights~%bool rangefinder~%bool estopmanual~%bool estopremote~%string mode~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RobotButtons>))
  (cl:+ 0
     1
     1
     1
     1
     1
     1
     1
     1
     1
     4 (cl:length (cl:slot-value msg 'mode))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RobotButtons>))
  "Converts a ROS message object to a list"
  (cl:list 'RobotButtons
    (cl:cons ':fan (fan msg))
    (cl:cons ':imu (imu msg))
    (cl:cons ':camera (camera msg))
    (cl:cons ':gps (gps msg))
    (cl:cons ':switch (switch msg))
    (cl:cons ':lights (lights msg))
    (cl:cons ':rangefinder (rangefinder msg))
    (cl:cons ':estopmanual (estopmanual msg))
    (cl:cons ':estopremote (estopremote msg))
    (cl:cons ':mode (mode msg))
))
