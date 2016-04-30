; Auto-generated. Do not edit!


(cl:in-package capra_controlpanel-srv)


;//! \htmlinclude Set-request.msg.html

(cl:defclass <Set-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (state
    :reader state
    :initarg :state
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Set-request (<Set-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Set-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Set-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_controlpanel-srv:<Set-request> is deprecated: use capra_controlpanel-srv:Set-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <Set-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-srv:name-val is deprecated.  Use capra_controlpanel-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <Set-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-srv:state-val is deprecated.  Use capra_controlpanel-srv:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Set-request>) ostream)
  "Serializes a message object of type '<Set-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'state) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Set-request>) istream)
  "Deserializes a message object of type '<Set-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'state) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Set-request>)))
  "Returns string type for a service object of type '<Set-request>"
  "capra_controlpanel/SetRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Set-request)))
  "Returns string type for a service object of type 'Set-request"
  "capra_controlpanel/SetRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Set-request>)))
  "Returns md5sum for a message object of type '<Set-request>"
  "76acd565e38625a7cf6a67bfb94c503f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Set-request)))
  "Returns md5sum for a message object of type 'Set-request"
  "76acd565e38625a7cf6a67bfb94c503f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Set-request>)))
  "Returns full string definition for message of type '<Set-request>"
  (cl:format cl:nil "string name~%bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Set-request)))
  "Returns full string definition for message of type 'Set-request"
  (cl:format cl:nil "string name~%bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Set-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Set-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Set-request
    (cl:cons ':name (name msg))
    (cl:cons ':state (state msg))
))
;//! \htmlinclude Set-response.msg.html

(cl:defclass <Set-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Set-response (<Set-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Set-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Set-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_controlpanel-srv:<Set-response> is deprecated: use capra_controlpanel-srv:Set-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <Set-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-srv:success-val is deprecated.  Use capra_controlpanel-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Set-response>) ostream)
  "Serializes a message object of type '<Set-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Set-response>) istream)
  "Deserializes a message object of type '<Set-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Set-response>)))
  "Returns string type for a service object of type '<Set-response>"
  "capra_controlpanel/SetResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Set-response)))
  "Returns string type for a service object of type 'Set-response"
  "capra_controlpanel/SetResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Set-response>)))
  "Returns md5sum for a message object of type '<Set-response>"
  "76acd565e38625a7cf6a67bfb94c503f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Set-response)))
  "Returns md5sum for a message object of type 'Set-response"
  "76acd565e38625a7cf6a67bfb94c503f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Set-response>)))
  "Returns full string definition for message of type '<Set-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Set-response)))
  "Returns full string definition for message of type 'Set-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Set-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Set-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Set-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Set)))
  'Set-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Set)))
  'Set-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Set)))
  "Returns string type for a service object of type '<Set>"
  "capra_controlpanel/Set")