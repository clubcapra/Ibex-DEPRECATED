; Auto-generated. Do not edit!


(cl:in-package capra_motor_calibrator-srv)


;//! \htmlinclude CalibrateMotor-request.msg.html

(cl:defclass <CalibrateMotor-request> (roslisp-msg-protocol:ros-message)
  ((calibration_distance
    :reader calibration_distance
    :initarg :calibration_distance
    :type cl:float
    :initform 0.0))
)

(cl:defclass CalibrateMotor-request (<CalibrateMotor-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CalibrateMotor-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CalibrateMotor-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_motor_calibrator-srv:<CalibrateMotor-request> is deprecated: use capra_motor_calibrator-srv:CalibrateMotor-request instead.")))

(cl:ensure-generic-function 'calibration_distance-val :lambda-list '(m))
(cl:defmethod calibration_distance-val ((m <CalibrateMotor-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_motor_calibrator-srv:calibration_distance-val is deprecated.  Use capra_motor_calibrator-srv:calibration_distance instead.")
  (calibration_distance m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CalibrateMotor-request>) ostream)
  "Serializes a message object of type '<CalibrateMotor-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'calibration_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CalibrateMotor-request>) istream)
  "Deserializes a message object of type '<CalibrateMotor-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'calibration_distance) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CalibrateMotor-request>)))
  "Returns string type for a service object of type '<CalibrateMotor-request>"
  "capra_motor_calibrator/CalibrateMotorRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CalibrateMotor-request)))
  "Returns string type for a service object of type 'CalibrateMotor-request"
  "capra_motor_calibrator/CalibrateMotorRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CalibrateMotor-request>)))
  "Returns md5sum for a message object of type '<CalibrateMotor-request>"
  "cfd7f0162e5ce4a552a1a2922ba01fc1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CalibrateMotor-request)))
  "Returns md5sum for a message object of type 'CalibrateMotor-request"
  "cfd7f0162e5ce4a552a1a2922ba01fc1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CalibrateMotor-request>)))
  "Returns full string definition for message of type '<CalibrateMotor-request>"
  (cl:format cl:nil "float32 calibration_distance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CalibrateMotor-request)))
  "Returns full string definition for message of type 'CalibrateMotor-request"
  (cl:format cl:nil "float32 calibration_distance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CalibrateMotor-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CalibrateMotor-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CalibrateMotor-request
    (cl:cons ':calibration_distance (calibration_distance msg))
))
;//! \htmlinclude CalibrateMotor-response.msg.html

(cl:defclass <CalibrateMotor-response> (roslisp-msg-protocol:ros-message)
  ((calibration_values
    :reader calibration_values
    :initarg :calibration_values
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass CalibrateMotor-response (<CalibrateMotor-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CalibrateMotor-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CalibrateMotor-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_motor_calibrator-srv:<CalibrateMotor-response> is deprecated: use capra_motor_calibrator-srv:CalibrateMotor-response instead.")))

(cl:ensure-generic-function 'calibration_values-val :lambda-list '(m))
(cl:defmethod calibration_values-val ((m <CalibrateMotor-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_motor_calibrator-srv:calibration_values-val is deprecated.  Use capra_motor_calibrator-srv:calibration_values instead.")
  (calibration_values m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CalibrateMotor-response>) ostream)
  "Serializes a message object of type '<CalibrateMotor-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'calibration_values))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'calibration_values))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CalibrateMotor-response>) istream)
  "Deserializes a message object of type '<CalibrateMotor-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'calibration_values) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'calibration_values)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CalibrateMotor-response>)))
  "Returns string type for a service object of type '<CalibrateMotor-response>"
  "capra_motor_calibrator/CalibrateMotorResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CalibrateMotor-response)))
  "Returns string type for a service object of type 'CalibrateMotor-response"
  "capra_motor_calibrator/CalibrateMotorResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CalibrateMotor-response>)))
  "Returns md5sum for a message object of type '<CalibrateMotor-response>"
  "cfd7f0162e5ce4a552a1a2922ba01fc1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CalibrateMotor-response)))
  "Returns md5sum for a message object of type 'CalibrateMotor-response"
  "cfd7f0162e5ce4a552a1a2922ba01fc1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CalibrateMotor-response>)))
  "Returns full string definition for message of type '<CalibrateMotor-response>"
  (cl:format cl:nil "float32[] calibration_values~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CalibrateMotor-response)))
  "Returns full string definition for message of type 'CalibrateMotor-response"
  (cl:format cl:nil "float32[] calibration_values~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CalibrateMotor-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'calibration_values) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CalibrateMotor-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CalibrateMotor-response
    (cl:cons ':calibration_values (calibration_values msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CalibrateMotor)))
  'CalibrateMotor-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CalibrateMotor)))
  'CalibrateMotor-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CalibrateMotor)))
  "Returns string type for a service object of type '<CalibrateMotor>"
  "capra_motor_calibrator/CalibrateMotor")