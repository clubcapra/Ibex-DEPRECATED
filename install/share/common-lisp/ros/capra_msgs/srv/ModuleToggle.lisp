; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude ModuleToggle-request.msg.html

(cl:defclass <ModuleToggle-request> (roslisp-msg-protocol:ros-message)
  ((Module
    :reader Module
    :initarg :Module
    :type cl:string
    :initform "")
   (on
    :reader on
    :initarg :on
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ModuleToggle-request (<ModuleToggle-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ModuleToggle-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ModuleToggle-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<ModuleToggle-request> is deprecated: use capra_msgs-srv:ModuleToggle-request instead.")))

(cl:ensure-generic-function 'Module-val :lambda-list '(m))
(cl:defmethod Module-val ((m <ModuleToggle-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:Module-val is deprecated.  Use capra_msgs-srv:Module instead.")
  (Module m))

(cl:ensure-generic-function 'on-val :lambda-list '(m))
(cl:defmethod on-val ((m <ModuleToggle-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:on-val is deprecated.  Use capra_msgs-srv:on instead.")
  (on m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ModuleToggle-request>) ostream)
  "Serializes a message object of type '<ModuleToggle-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'Module))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'Module))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'on) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ModuleToggle-request>) istream)
  "Deserializes a message object of type '<ModuleToggle-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'Module) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'Module) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'on) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ModuleToggle-request>)))
  "Returns string type for a service object of type '<ModuleToggle-request>"
  "capra_msgs/ModuleToggleRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ModuleToggle-request)))
  "Returns string type for a service object of type 'ModuleToggle-request"
  "capra_msgs/ModuleToggleRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ModuleToggle-request>)))
  "Returns md5sum for a message object of type '<ModuleToggle-request>"
  "5417d091a3ca68989e75b1d90cc8e161")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ModuleToggle-request)))
  "Returns md5sum for a message object of type 'ModuleToggle-request"
  "5417d091a3ca68989e75b1d90cc8e161")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ModuleToggle-request>)))
  "Returns full string definition for message of type '<ModuleToggle-request>"
  (cl:format cl:nil "string Module~%bool on~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ModuleToggle-request)))
  "Returns full string definition for message of type 'ModuleToggle-request"
  (cl:format cl:nil "string Module~%bool on~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ModuleToggle-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'Module))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ModuleToggle-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ModuleToggle-request
    (cl:cons ':Module (Module msg))
    (cl:cons ':on (on msg))
))
;//! \htmlinclude ModuleToggle-response.msg.html

(cl:defclass <ModuleToggle-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ModuleToggle-response (<ModuleToggle-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ModuleToggle-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ModuleToggle-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<ModuleToggle-response> is deprecated: use capra_msgs-srv:ModuleToggle-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ModuleToggle-response>) ostream)
  "Serializes a message object of type '<ModuleToggle-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ModuleToggle-response>) istream)
  "Deserializes a message object of type '<ModuleToggle-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ModuleToggle-response>)))
  "Returns string type for a service object of type '<ModuleToggle-response>"
  "capra_msgs/ModuleToggleResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ModuleToggle-response)))
  "Returns string type for a service object of type 'ModuleToggle-response"
  "capra_msgs/ModuleToggleResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ModuleToggle-response>)))
  "Returns md5sum for a message object of type '<ModuleToggle-response>"
  "5417d091a3ca68989e75b1d90cc8e161")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ModuleToggle-response)))
  "Returns md5sum for a message object of type 'ModuleToggle-response"
  "5417d091a3ca68989e75b1d90cc8e161")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ModuleToggle-response>)))
  "Returns full string definition for message of type '<ModuleToggle-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ModuleToggle-response)))
  "Returns full string definition for message of type 'ModuleToggle-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ModuleToggle-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ModuleToggle-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ModuleToggle-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ModuleToggle)))
  'ModuleToggle-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ModuleToggle)))
  'ModuleToggle-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ModuleToggle)))
  "Returns string type for a service object of type '<ModuleToggle>"
  "capra_msgs/ModuleToggle")