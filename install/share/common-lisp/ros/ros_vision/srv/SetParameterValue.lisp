; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude SetParameterValue-request.msg.html

(cl:defclass <SetParameterValue-request> (roslisp-msg-protocol:ros-message)
  ((filter_name
    :reader filter_name
    :initarg :filter_name
    :type cl:string
    :initform "")
   (parameter_name
    :reader parameter_name
    :initarg :parameter_name
    :type cl:string
    :initform "")
   (parameter_value
    :reader parameter_value
    :initarg :parameter_value
    :type cl:string
    :initform "")
   (update_topics
    :reader update_topics
    :initarg :update_topics
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetParameterValue-request (<SetParameterValue-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetParameterValue-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetParameterValue-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<SetParameterValue-request> is deprecated: use ros_vision-srv:SetParameterValue-request instead.")))

(cl:ensure-generic-function 'filter_name-val :lambda-list '(m))
(cl:defmethod filter_name-val ((m <SetParameterValue-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:filter_name-val is deprecated.  Use ros_vision-srv:filter_name instead.")
  (filter_name m))

(cl:ensure-generic-function 'parameter_name-val :lambda-list '(m))
(cl:defmethod parameter_name-val ((m <SetParameterValue-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:parameter_name-val is deprecated.  Use ros_vision-srv:parameter_name instead.")
  (parameter_name m))

(cl:ensure-generic-function 'parameter_value-val :lambda-list '(m))
(cl:defmethod parameter_value-val ((m <SetParameterValue-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:parameter_value-val is deprecated.  Use ros_vision-srv:parameter_value instead.")
  (parameter_value m))

(cl:ensure-generic-function 'update_topics-val :lambda-list '(m))
(cl:defmethod update_topics-val ((m <SetParameterValue-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:update_topics-val is deprecated.  Use ros_vision-srv:update_topics instead.")
  (update_topics m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetParameterValue-request>) ostream)
  "Serializes a message object of type '<SetParameterValue-request>"
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
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'parameter_value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'parameter_value))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'update_topics) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetParameterValue-request>) istream)
  "Deserializes a message object of type '<SetParameterValue-request>"
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
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'parameter_value) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'parameter_value) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'update_topics) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetParameterValue-request>)))
  "Returns string type for a service object of type '<SetParameterValue-request>"
  "ros_vision/SetParameterValueRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetParameterValue-request)))
  "Returns string type for a service object of type 'SetParameterValue-request"
  "ros_vision/SetParameterValueRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetParameterValue-request>)))
  "Returns md5sum for a message object of type '<SetParameterValue-request>"
  "9dfb3622c3b8f3307e6b9b3b516248ca")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetParameterValue-request)))
  "Returns md5sum for a message object of type 'SetParameterValue-request"
  "9dfb3622c3b8f3307e6b9b3b516248ca")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetParameterValue-request>)))
  "Returns full string definition for message of type '<SetParameterValue-request>"
  (cl:format cl:nil "string filter_name~%string parameter_name~%string parameter_value~%bool update_topics~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetParameterValue-request)))
  "Returns full string definition for message of type 'SetParameterValue-request"
  (cl:format cl:nil "string filter_name~%string parameter_name~%string parameter_value~%bool update_topics~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetParameterValue-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'filter_name))
     4 (cl:length (cl:slot-value msg 'parameter_name))
     4 (cl:length (cl:slot-value msg 'parameter_value))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetParameterValue-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetParameterValue-request
    (cl:cons ':filter_name (filter_name msg))
    (cl:cons ':parameter_name (parameter_name msg))
    (cl:cons ':parameter_value (parameter_value msg))
    (cl:cons ':update_topics (update_topics msg))
))
;//! \htmlinclude SetParameterValue-response.msg.html

(cl:defclass <SetParameterValue-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SetParameterValue-response (<SetParameterValue-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetParameterValue-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetParameterValue-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<SetParameterValue-response> is deprecated: use ros_vision-srv:SetParameterValue-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetParameterValue-response>) ostream)
  "Serializes a message object of type '<SetParameterValue-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetParameterValue-response>) istream)
  "Deserializes a message object of type '<SetParameterValue-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetParameterValue-response>)))
  "Returns string type for a service object of type '<SetParameterValue-response>"
  "ros_vision/SetParameterValueResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetParameterValue-response)))
  "Returns string type for a service object of type 'SetParameterValue-response"
  "ros_vision/SetParameterValueResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetParameterValue-response>)))
  "Returns md5sum for a message object of type '<SetParameterValue-response>"
  "9dfb3622c3b8f3307e6b9b3b516248ca")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetParameterValue-response)))
  "Returns md5sum for a message object of type 'SetParameterValue-response"
  "9dfb3622c3b8f3307e6b9b3b516248ca")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetParameterValue-response>)))
  "Returns full string definition for message of type '<SetParameterValue-response>"
  (cl:format cl:nil "~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetParameterValue-response)))
  "Returns full string definition for message of type 'SetParameterValue-response"
  (cl:format cl:nil "~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetParameterValue-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetParameterValue-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetParameterValue-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetParameterValue)))
  'SetParameterValue-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetParameterValue)))
  'SetParameterValue-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetParameterValue)))
  "Returns string type for a service object of type '<SetParameterValue>"
  "ros_vision/SetParameterValue")