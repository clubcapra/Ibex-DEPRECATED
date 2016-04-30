; Auto-generated. Do not edit!


(cl:in-package microstrain_3dmgx1_imu-srv)


;//! \htmlinclude Calibrate-request.msg.html

(cl:defclass <Calibrate-request> (roslisp-msg-protocol:ros-message)
  ((is_2d
    :reader is_2d
    :initarg :is_2d
    :type cl:boolean
    :initform cl:nil)
   (magnitude_z
    :reader magnitude_z
    :initarg :magnitude_z
    :type cl:fixnum
    :initform 0)
   (calibration_time
    :reader calibration_time
    :initarg :calibration_time
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Calibrate-request (<Calibrate-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Calibrate-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Calibrate-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name microstrain_3dmgx1_imu-srv:<Calibrate-request> is deprecated: use microstrain_3dmgx1_imu-srv:Calibrate-request instead.")))

(cl:ensure-generic-function 'is_2d-val :lambda-list '(m))
(cl:defmethod is_2d-val ((m <Calibrate-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader microstrain_3dmgx1_imu-srv:is_2d-val is deprecated.  Use microstrain_3dmgx1_imu-srv:is_2d instead.")
  (is_2d m))

(cl:ensure-generic-function 'magnitude_z-val :lambda-list '(m))
(cl:defmethod magnitude_z-val ((m <Calibrate-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader microstrain_3dmgx1_imu-srv:magnitude_z-val is deprecated.  Use microstrain_3dmgx1_imu-srv:magnitude_z instead.")
  (magnitude_z m))

(cl:ensure-generic-function 'calibration_time-val :lambda-list '(m))
(cl:defmethod calibration_time-val ((m <Calibrate-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader microstrain_3dmgx1_imu-srv:calibration_time-val is deprecated.  Use microstrain_3dmgx1_imu-srv:calibration_time instead.")
  (calibration_time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Calibrate-request>) ostream)
  "Serializes a message object of type '<Calibrate-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_2d) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'magnitude_z)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'calibration_time)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Calibrate-request>) istream)
  "Deserializes a message object of type '<Calibrate-request>"
    (cl:setf (cl:slot-value msg 'is_2d) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'magnitude_z) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'calibration_time) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Calibrate-request>)))
  "Returns string type for a service object of type '<Calibrate-request>"
  "microstrain_3dmgx1_imu/CalibrateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Calibrate-request)))
  "Returns string type for a service object of type 'Calibrate-request"
  "microstrain_3dmgx1_imu/CalibrateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Calibrate-request>)))
  "Returns md5sum for a message object of type '<Calibrate-request>"
  "4c715151b405532ed910c498c3183c86")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Calibrate-request)))
  "Returns md5sum for a message object of type 'Calibrate-request"
  "4c715151b405532ed910c498c3183c86")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Calibrate-request>)))
  "Returns full string definition for message of type '<Calibrate-request>"
  (cl:format cl:nil "bool is_2d~%int16 magnitude_z~%int8 calibration_time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Calibrate-request)))
  "Returns full string definition for message of type 'Calibrate-request"
  (cl:format cl:nil "bool is_2d~%int16 magnitude_z~%int8 calibration_time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Calibrate-request>))
  (cl:+ 0
     1
     2
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Calibrate-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Calibrate-request
    (cl:cons ':is_2d (is_2d msg))
    (cl:cons ':magnitude_z (magnitude_z msg))
    (cl:cons ':calibration_time (calibration_time msg))
))
;//! \htmlinclude Calibrate-response.msg.html

(cl:defclass <Calibrate-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Calibrate-response (<Calibrate-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Calibrate-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Calibrate-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name microstrain_3dmgx1_imu-srv:<Calibrate-response> is deprecated: use microstrain_3dmgx1_imu-srv:Calibrate-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Calibrate-response>) ostream)
  "Serializes a message object of type '<Calibrate-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Calibrate-response>) istream)
  "Deserializes a message object of type '<Calibrate-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Calibrate-response>)))
  "Returns string type for a service object of type '<Calibrate-response>"
  "microstrain_3dmgx1_imu/CalibrateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Calibrate-response)))
  "Returns string type for a service object of type 'Calibrate-response"
  "microstrain_3dmgx1_imu/CalibrateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Calibrate-response>)))
  "Returns md5sum for a message object of type '<Calibrate-response>"
  "4c715151b405532ed910c498c3183c86")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Calibrate-response)))
  "Returns md5sum for a message object of type 'Calibrate-response"
  "4c715151b405532ed910c498c3183c86")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Calibrate-response>)))
  "Returns full string definition for message of type '<Calibrate-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Calibrate-response)))
  "Returns full string definition for message of type 'Calibrate-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Calibrate-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Calibrate-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Calibrate-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Calibrate)))
  'Calibrate-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Calibrate)))
  'Calibrate-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Calibrate)))
  "Returns string type for a service object of type '<Calibrate>"
  "microstrain_3dmgx1_imu/Calibrate")