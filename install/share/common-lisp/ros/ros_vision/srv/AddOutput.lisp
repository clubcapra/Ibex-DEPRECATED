; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude AddOutput-request.msg.html

(cl:defclass <AddOutput-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (type
    :reader type
    :initarg :type
    :type cl:string
    :initform ""))
)

(cl:defclass AddOutput-request (<AddOutput-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddOutput-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddOutput-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<AddOutput-request> is deprecated: use ros_vision-srv:AddOutput-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <AddOutput-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:name-val is deprecated.  Use ros_vision-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <AddOutput-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:type-val is deprecated.  Use ros_vision-srv:type instead.")
  (type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddOutput-request>) ostream)
  "Serializes a message object of type '<AddOutput-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddOutput-request>) istream)
  "Deserializes a message object of type '<AddOutput-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddOutput-request>)))
  "Returns string type for a service object of type '<AddOutput-request>"
  "ros_vision/AddOutputRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddOutput-request)))
  "Returns string type for a service object of type 'AddOutput-request"
  "ros_vision/AddOutputRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddOutput-request>)))
  "Returns md5sum for a message object of type '<AddOutput-request>"
  "8f11915b22b276d2fb5587b35400289d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddOutput-request)))
  "Returns md5sum for a message object of type 'AddOutput-request"
  "8f11915b22b276d2fb5587b35400289d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddOutput-request>)))
  "Returns full string definition for message of type '<AddOutput-request>"
  (cl:format cl:nil "string name~%string type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddOutput-request)))
  "Returns full string definition for message of type 'AddOutput-request"
  (cl:format cl:nil "string name~%string type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddOutput-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:length (cl:slot-value msg 'type))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddOutput-request>))
  "Converts a ROS message object to a list"
  (cl:list 'AddOutput-request
    (cl:cons ':name (name msg))
    (cl:cons ':type (type msg))
))
;//! \htmlinclude AddOutput-response.msg.html

(cl:defclass <AddOutput-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass AddOutput-response (<AddOutput-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddOutput-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddOutput-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<AddOutput-response> is deprecated: use ros_vision-srv:AddOutput-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddOutput-response>) ostream)
  "Serializes a message object of type '<AddOutput-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddOutput-response>) istream)
  "Deserializes a message object of type '<AddOutput-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddOutput-response>)))
  "Returns string type for a service object of type '<AddOutput-response>"
  "ros_vision/AddOutputResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddOutput-response)))
  "Returns string type for a service object of type 'AddOutput-response"
  "ros_vision/AddOutputResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddOutput-response>)))
  "Returns md5sum for a message object of type '<AddOutput-response>"
  "8f11915b22b276d2fb5587b35400289d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddOutput-response)))
  "Returns md5sum for a message object of type 'AddOutput-response"
  "8f11915b22b276d2fb5587b35400289d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddOutput-response>)))
  "Returns full string definition for message of type '<AddOutput-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddOutput-response)))
  "Returns full string definition for message of type 'AddOutput-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddOutput-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddOutput-response>))
  "Converts a ROS message object to a list"
  (cl:list 'AddOutput-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'AddOutput)))
  'AddOutput-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'AddOutput)))
  'AddOutput-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddOutput)))
  "Returns string type for a service object of type '<AddOutput>"
  "ros_vision/AddOutput")