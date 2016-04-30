; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude CreateFilter-request.msg.html

(cl:defclass <CreateFilter-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (order
    :reader order
    :initarg :order
    :type cl:fixnum
    :initform 0))
)

(cl:defclass CreateFilter-request (<CreateFilter-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CreateFilter-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CreateFilter-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<CreateFilter-request> is deprecated: use ros_vision-srv:CreateFilter-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <CreateFilter-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:name-val is deprecated.  Use ros_vision-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <CreateFilter-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:type-val is deprecated.  Use ros_vision-srv:type instead.")
  (type m))

(cl:ensure-generic-function 'order-val :lambda-list '(m))
(cl:defmethod order-val ((m <CreateFilter-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:order-val is deprecated.  Use ros_vision-srv:order instead.")
  (order m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CreateFilter-request>) ostream)
  "Serializes a message object of type '<CreateFilter-request>"
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
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'order)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'order)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CreateFilter-request>) istream)
  "Deserializes a message object of type '<CreateFilter-request>"
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
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'order)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'order)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CreateFilter-request>)))
  "Returns string type for a service object of type '<CreateFilter-request>"
  "ros_vision/CreateFilterRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CreateFilter-request)))
  "Returns string type for a service object of type 'CreateFilter-request"
  "ros_vision/CreateFilterRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CreateFilter-request>)))
  "Returns md5sum for a message object of type '<CreateFilter-request>"
  "16b9d386bb76c23d41cb22903acca9fc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CreateFilter-request)))
  "Returns md5sum for a message object of type 'CreateFilter-request"
  "16b9d386bb76c23d41cb22903acca9fc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CreateFilter-request>)))
  "Returns full string definition for message of type '<CreateFilter-request>"
  (cl:format cl:nil "string name~%string type~%uint16 order~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CreateFilter-request)))
  "Returns full string definition for message of type 'CreateFilter-request"
  (cl:format cl:nil "string name~%string type~%uint16 order~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CreateFilter-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:length (cl:slot-value msg 'type))
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CreateFilter-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CreateFilter-request
    (cl:cons ':name (name msg))
    (cl:cons ':type (type msg))
    (cl:cons ':order (order msg))
))
;//! \htmlinclude CreateFilter-response.msg.html

(cl:defclass <CreateFilter-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass CreateFilter-response (<CreateFilter-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CreateFilter-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CreateFilter-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<CreateFilter-response> is deprecated: use ros_vision-srv:CreateFilter-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CreateFilter-response>) ostream)
  "Serializes a message object of type '<CreateFilter-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CreateFilter-response>) istream)
  "Deserializes a message object of type '<CreateFilter-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CreateFilter-response>)))
  "Returns string type for a service object of type '<CreateFilter-response>"
  "ros_vision/CreateFilterResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CreateFilter-response)))
  "Returns string type for a service object of type 'CreateFilter-response"
  "ros_vision/CreateFilterResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CreateFilter-response>)))
  "Returns md5sum for a message object of type '<CreateFilter-response>"
  "16b9d386bb76c23d41cb22903acca9fc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CreateFilter-response)))
  "Returns md5sum for a message object of type 'CreateFilter-response"
  "16b9d386bb76c23d41cb22903acca9fc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CreateFilter-response>)))
  "Returns full string definition for message of type '<CreateFilter-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CreateFilter-response)))
  "Returns full string definition for message of type 'CreateFilter-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CreateFilter-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CreateFilter-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CreateFilter-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CreateFilter)))
  'CreateFilter-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CreateFilter)))
  'CreateFilter-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CreateFilter)))
  "Returns string type for a service object of type '<CreateFilter>"
  "ros_vision/CreateFilter")