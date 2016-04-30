; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude GetParameterValue-request.msg.html

(cl:defclass <GetParameterValue-request> (roslisp-msg-protocol:ros-message)
  ((filter_name
    :reader filter_name
    :initarg :filter_name
    :type cl:string
    :initform "")
   (parameter_name
    :reader parameter_name
    :initarg :parameter_name
    :type cl:string
    :initform ""))
)

(cl:defclass GetParameterValue-request (<GetParameterValue-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetParameterValue-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetParameterValue-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<GetParameterValue-request> is deprecated: use ros_vision-srv:GetParameterValue-request instead.")))

(cl:ensure-generic-function 'filter_name-val :lambda-list '(m))
(cl:defmethod filter_name-val ((m <GetParameterValue-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:filter_name-val is deprecated.  Use ros_vision-srv:filter_name instead.")
  (filter_name m))

(cl:ensure-generic-function 'parameter_name-val :lambda-list '(m))
(cl:defmethod parameter_name-val ((m <GetParameterValue-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:parameter_name-val is deprecated.  Use ros_vision-srv:parameter_name instead.")
  (parameter_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetParameterValue-request>) ostream)
  "Serializes a message object of type '<GetParameterValue-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'filter_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'filter_name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'parameter_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'parameter_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetParameterValue-request>) istream)
  "Deserializes a message object of type '<GetParameterValue-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'filter_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'filter_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'parameter_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'parameter_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetParameterValue-request>)))
  "Returns string type for a service object of type '<GetParameterValue-request>"
  "ros_vision/GetParameterValueRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetParameterValue-request)))
  "Returns string type for a service object of type 'GetParameterValue-request"
  "ros_vision/GetParameterValueRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetParameterValue-request>)))
  "Returns md5sum for a message object of type '<GetParameterValue-request>"
  "c6989f480361a011a41108499b2febd0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetParameterValue-request)))
  "Returns md5sum for a message object of type 'GetParameterValue-request"
  "c6989f480361a011a41108499b2febd0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetParameterValue-request>)))
  "Returns full string definition for message of type '<GetParameterValue-request>"
  (cl:format cl:nil "string filter_name~%string parameter_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetParameterValue-request)))
  "Returns full string definition for message of type 'GetParameterValue-request"
  (cl:format cl:nil "string filter_name~%string parameter_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetParameterValue-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'filter_name))
     4 (cl:length (cl:slot-value msg 'parameter_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetParameterValue-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetParameterValue-request
    (cl:cons ':filter_name (filter_name msg))
    (cl:cons ':parameter_name (parameter_name msg))
))
;//! \htmlinclude GetParameterValue-response.msg.html

(cl:defclass <GetParameterValue-response> (roslisp-msg-protocol:ros-message)
  ((parameter_value
    :reader parameter_value
    :initarg :parameter_value
    :type cl:string
    :initform ""))
)

(cl:defclass GetParameterValue-response (<GetParameterValue-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetParameterValue-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetParameterValue-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<GetParameterValue-response> is deprecated: use ros_vision-srv:GetParameterValue-response instead.")))

(cl:ensure-generic-function 'parameter_value-val :lambda-list '(m))
(cl:defmethod parameter_value-val ((m <GetParameterValue-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:parameter_value-val is deprecated.  Use ros_vision-srv:parameter_value instead.")
  (parameter_value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetParameterValue-response>) ostream)
  "Serializes a message object of type '<GetParameterValue-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'parameter_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'parameter_value))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetParameterValue-response>) istream)
  "Deserializes a message object of type '<GetParameterValue-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'parameter_value) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'parameter_value) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetParameterValue-response>)))
  "Returns string type for a service object of type '<GetParameterValue-response>"
  "ros_vision/GetParameterValueResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetParameterValue-response)))
  "Returns string type for a service object of type 'GetParameterValue-response"
  "ros_vision/GetParameterValueResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetParameterValue-response>)))
  "Returns md5sum for a message object of type '<GetParameterValue-response>"
  "c6989f480361a011a41108499b2febd0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetParameterValue-response)))
  "Returns md5sum for a message object of type 'GetParameterValue-response"
  "c6989f480361a011a41108499b2febd0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetParameterValue-response>)))
  "Returns full string definition for message of type '<GetParameterValue-response>"
  (cl:format cl:nil "string parameter_value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetParameterValue-response)))
  "Returns full string definition for message of type 'GetParameterValue-response"
  (cl:format cl:nil "string parameter_value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetParameterValue-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'parameter_value))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetParameterValue-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetParameterValue-response
    (cl:cons ':parameter_value (parameter_value msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetParameterValue)))
  'GetParameterValue-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetParameterValue)))
  'GetParameterValue-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetParameterValue)))
  "Returns string type for a service object of type '<GetParameterValue>"
  "ros_vision/GetParameterValue")