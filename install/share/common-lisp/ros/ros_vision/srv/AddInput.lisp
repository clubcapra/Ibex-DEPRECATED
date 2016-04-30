; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude AddInput-request.msg.html

(cl:defclass <AddInput-request> (roslisp-msg-protocol:ros-message)
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

(cl:defclass AddInput-request (<AddInput-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddInput-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddInput-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<AddInput-request> is deprecated: use ros_vision-srv:AddInput-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <AddInput-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:name-val is deprecated.  Use ros_vision-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <AddInput-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:type-val is deprecated.  Use ros_vision-srv:type instead.")
  (type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddInput-request>) ostream)
  "Serializes a message object of type '<AddInput-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddInput-request>) istream)
  "Deserializes a message object of type '<AddInput-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddInput-request>)))
  "Returns string type for a service object of type '<AddInput-request>"
  "ros_vision/AddInputRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddInput-request)))
  "Returns string type for a service object of type 'AddInput-request"
  "ros_vision/AddInputRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddInput-request>)))
  "Returns md5sum for a message object of type '<AddInput-request>"
  "8f11915b22b276d2fb5587b35400289d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddInput-request)))
  "Returns md5sum for a message object of type 'AddInput-request"
  "8f11915b22b276d2fb5587b35400289d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddInput-request>)))
  "Returns full string definition for message of type '<AddInput-request>"
  (cl:format cl:nil "string name~%string type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddInput-request)))
  "Returns full string definition for message of type 'AddInput-request"
  (cl:format cl:nil "string name~%string type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddInput-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:length (cl:slot-value msg 'type))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddInput-request>))
  "Converts a ROS message object to a list"
  (cl:list 'AddInput-request
    (cl:cons ':name (name msg))
    (cl:cons ':type (type msg))
))
;//! \htmlinclude AddInput-response.msg.html

(cl:defclass <AddInput-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass AddInput-response (<AddInput-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddInput-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddInput-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<AddInput-response> is deprecated: use ros_vision-srv:AddInput-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddInput-response>) ostream)
  "Serializes a message object of type '<AddInput-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddInput-response>) istream)
  "Deserializes a message object of type '<AddInput-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddInput-response>)))
  "Returns string type for a service object of type '<AddInput-response>"
  "ros_vision/AddInputResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddInput-response)))
  "Returns string type for a service object of type 'AddInput-response"
  "ros_vision/AddInputResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddInput-response>)))
  "Returns md5sum for a message object of type '<AddInput-response>"
  "8f11915b22b276d2fb5587b35400289d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddInput-response)))
  "Returns md5sum for a message object of type 'AddInput-response"
  "8f11915b22b276d2fb5587b35400289d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddInput-response>)))
  "Returns full string definition for message of type '<AddInput-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddInput-response)))
  "Returns full string definition for message of type 'AddInput-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddInput-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddInput-response>))
  "Converts a ROS message object to a list"
  (cl:list 'AddInput-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'AddInput)))
  'AddInput-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'AddInput)))
  'AddInput-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddInput)))
  "Returns string type for a service object of type '<AddInput>"
  "ros_vision/AddInput")