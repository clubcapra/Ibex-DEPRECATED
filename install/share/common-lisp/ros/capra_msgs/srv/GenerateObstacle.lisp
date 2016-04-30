; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude GenerateObstacle-request.msg.html

(cl:defclass <GenerateObstacle-request> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (params
    :reader params
    :initarg :params
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (duration
    :reader duration
    :initarg :duration
    :type cl:integer
    :initform 0))
)

(cl:defclass GenerateObstacle-request (<GenerateObstacle-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GenerateObstacle-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GenerateObstacle-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<GenerateObstacle-request> is deprecated: use capra_msgs-srv:GenerateObstacle-request instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <GenerateObstacle-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:type-val is deprecated.  Use capra_msgs-srv:type instead.")
  (type m))

(cl:ensure-generic-function 'params-val :lambda-list '(m))
(cl:defmethod params-val ((m <GenerateObstacle-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:params-val is deprecated.  Use capra_msgs-srv:params instead.")
  (params m))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <GenerateObstacle-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:duration-val is deprecated.  Use capra_msgs-srv:duration instead.")
  (duration m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GenerateObstacle-request>) ostream)
  "Serializes a message object of type '<GenerateObstacle-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'params))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'params))
  (cl:let* ((signed (cl:slot-value msg 'duration)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GenerateObstacle-request>) istream)
  "Deserializes a message object of type '<GenerateObstacle-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'params) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'params)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'duration) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GenerateObstacle-request>)))
  "Returns string type for a service object of type '<GenerateObstacle-request>"
  "capra_msgs/GenerateObstacleRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GenerateObstacle-request)))
  "Returns string type for a service object of type 'GenerateObstacle-request"
  "capra_msgs/GenerateObstacleRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GenerateObstacle-request>)))
  "Returns md5sum for a message object of type '<GenerateObstacle-request>"
  "669ae77aa9e027222bb83c2ac0e33053")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GenerateObstacle-request)))
  "Returns md5sum for a message object of type 'GenerateObstacle-request"
  "669ae77aa9e027222bb83c2ac0e33053")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GenerateObstacle-request>)))
  "Returns full string definition for message of type '<GenerateObstacle-request>"
  (cl:format cl:nil "string type~%float32[] params~%int32 duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GenerateObstacle-request)))
  "Returns full string definition for message of type 'GenerateObstacle-request"
  (cl:format cl:nil "string type~%float32[] params~%int32 duration~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GenerateObstacle-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'type))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'params) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GenerateObstacle-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GenerateObstacle-request
    (cl:cons ':type (type msg))
    (cl:cons ':params (params msg))
    (cl:cons ':duration (duration msg))
))
;//! \htmlinclude GenerateObstacle-response.msg.html

(cl:defclass <GenerateObstacle-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GenerateObstacle-response (<GenerateObstacle-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GenerateObstacle-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GenerateObstacle-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<GenerateObstacle-response> is deprecated: use capra_msgs-srv:GenerateObstacle-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GenerateObstacle-response>) ostream)
  "Serializes a message object of type '<GenerateObstacle-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GenerateObstacle-response>) istream)
  "Deserializes a message object of type '<GenerateObstacle-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GenerateObstacle-response>)))
  "Returns string type for a service object of type '<GenerateObstacle-response>"
  "capra_msgs/GenerateObstacleResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GenerateObstacle-response)))
  "Returns string type for a service object of type 'GenerateObstacle-response"
  "capra_msgs/GenerateObstacleResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GenerateObstacle-response>)))
  "Returns md5sum for a message object of type '<GenerateObstacle-response>"
  "669ae77aa9e027222bb83c2ac0e33053")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GenerateObstacle-response)))
  "Returns md5sum for a message object of type 'GenerateObstacle-response"
  "669ae77aa9e027222bb83c2ac0e33053")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GenerateObstacle-response>)))
  "Returns full string definition for message of type '<GenerateObstacle-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GenerateObstacle-response)))
  "Returns full string definition for message of type 'GenerateObstacle-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GenerateObstacle-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GenerateObstacle-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GenerateObstacle-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GenerateObstacle)))
  'GenerateObstacle-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GenerateObstacle)))
  'GenerateObstacle-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GenerateObstacle)))
  "Returns string type for a service object of type '<GenerateObstacle>"
  "capra_msgs/GenerateObstacle")