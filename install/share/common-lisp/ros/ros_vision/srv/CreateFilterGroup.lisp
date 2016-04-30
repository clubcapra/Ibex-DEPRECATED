; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude CreateFilterGroup-request.msg.html

(cl:defclass <CreateFilterGroup-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (order
    :reader order
    :initarg :order
    :type cl:fixnum
    :initform 0))
)

(cl:defclass CreateFilterGroup-request (<CreateFilterGroup-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CreateFilterGroup-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CreateFilterGroup-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<CreateFilterGroup-request> is deprecated: use ros_vision-srv:CreateFilterGroup-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <CreateFilterGroup-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:name-val is deprecated.  Use ros_vision-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'order-val :lambda-list '(m))
(cl:defmethod order-val ((m <CreateFilterGroup-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:order-val is deprecated.  Use ros_vision-srv:order instead.")
  (order m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CreateFilterGroup-request>) ostream)
  "Serializes a message object of type '<CreateFilterGroup-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'order)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'order)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CreateFilterGroup-request>) istream)
  "Deserializes a message object of type '<CreateFilterGroup-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'order)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'order)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CreateFilterGroup-request>)))
  "Returns string type for a service object of type '<CreateFilterGroup-request>"
  "ros_vision/CreateFilterGroupRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CreateFilterGroup-request)))
  "Returns string type for a service object of type 'CreateFilterGroup-request"
  "ros_vision/CreateFilterGroupRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CreateFilterGroup-request>)))
  "Returns md5sum for a message object of type '<CreateFilterGroup-request>"
  "ed7c07c9a3d6364d8d33820721820341")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CreateFilterGroup-request)))
  "Returns md5sum for a message object of type 'CreateFilterGroup-request"
  "ed7c07c9a3d6364d8d33820721820341")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CreateFilterGroup-request>)))
  "Returns full string definition for message of type '<CreateFilterGroup-request>"
  (cl:format cl:nil "string name~%uint16 order~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CreateFilterGroup-request)))
  "Returns full string definition for message of type 'CreateFilterGroup-request"
  (cl:format cl:nil "string name~%uint16 order~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CreateFilterGroup-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CreateFilterGroup-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CreateFilterGroup-request
    (cl:cons ':name (name msg))
    (cl:cons ':order (order msg))
))
;//! \htmlinclude CreateFilterGroup-response.msg.html

(cl:defclass <CreateFilterGroup-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass CreateFilterGroup-response (<CreateFilterGroup-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CreateFilterGroup-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CreateFilterGroup-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<CreateFilterGroup-response> is deprecated: use ros_vision-srv:CreateFilterGroup-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CreateFilterGroup-response>) ostream)
  "Serializes a message object of type '<CreateFilterGroup-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CreateFilterGroup-response>) istream)
  "Deserializes a message object of type '<CreateFilterGroup-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CreateFilterGroup-response>)))
  "Returns string type for a service object of type '<CreateFilterGroup-response>"
  "ros_vision/CreateFilterGroupResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CreateFilterGroup-response)))
  "Returns string type for a service object of type 'CreateFilterGroup-response"
  "ros_vision/CreateFilterGroupResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CreateFilterGroup-response>)))
  "Returns md5sum for a message object of type '<CreateFilterGroup-response>"
  "ed7c07c9a3d6364d8d33820721820341")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CreateFilterGroup-response)))
  "Returns md5sum for a message object of type 'CreateFilterGroup-response"
  "ed7c07c9a3d6364d8d33820721820341")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CreateFilterGroup-response>)))
  "Returns full string definition for message of type '<CreateFilterGroup-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CreateFilterGroup-response)))
  "Returns full string definition for message of type 'CreateFilterGroup-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CreateFilterGroup-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CreateFilterGroup-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CreateFilterGroup-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CreateFilterGroup)))
  'CreateFilterGroup-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CreateFilterGroup)))
  'CreateFilterGroup-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CreateFilterGroup)))
  "Returns string type for a service object of type '<CreateFilterGroup>"
  "ros_vision/CreateFilterGroup")