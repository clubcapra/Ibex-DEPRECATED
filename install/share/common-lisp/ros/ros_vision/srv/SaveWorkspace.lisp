; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude SaveWorkspace-request.msg.html

(cl:defclass <SaveWorkspace-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass SaveWorkspace-request (<SaveWorkspace-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SaveWorkspace-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SaveWorkspace-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<SaveWorkspace-request> is deprecated: use ros_vision-srv:SaveWorkspace-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <SaveWorkspace-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:name-val is deprecated.  Use ros_vision-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SaveWorkspace-request>) ostream)
  "Serializes a message object of type '<SaveWorkspace-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SaveWorkspace-request>) istream)
  "Deserializes a message object of type '<SaveWorkspace-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SaveWorkspace-request>)))
  "Returns string type for a service object of type '<SaveWorkspace-request>"
  "ros_vision/SaveWorkspaceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveWorkspace-request)))
  "Returns string type for a service object of type 'SaveWorkspace-request"
  "ros_vision/SaveWorkspaceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SaveWorkspace-request>)))
  "Returns md5sum for a message object of type '<SaveWorkspace-request>"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SaveWorkspace-request)))
  "Returns md5sum for a message object of type 'SaveWorkspace-request"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SaveWorkspace-request>)))
  "Returns full string definition for message of type '<SaveWorkspace-request>"
  (cl:format cl:nil "string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SaveWorkspace-request)))
  "Returns full string definition for message of type 'SaveWorkspace-request"
  (cl:format cl:nil "string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SaveWorkspace-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SaveWorkspace-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SaveWorkspace-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude SaveWorkspace-response.msg.html

(cl:defclass <SaveWorkspace-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SaveWorkspace-response (<SaveWorkspace-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SaveWorkspace-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SaveWorkspace-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<SaveWorkspace-response> is deprecated: use ros_vision-srv:SaveWorkspace-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SaveWorkspace-response>) ostream)
  "Serializes a message object of type '<SaveWorkspace-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SaveWorkspace-response>) istream)
  "Deserializes a message object of type '<SaveWorkspace-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SaveWorkspace-response>)))
  "Returns string type for a service object of type '<SaveWorkspace-response>"
  "ros_vision/SaveWorkspaceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveWorkspace-response)))
  "Returns string type for a service object of type 'SaveWorkspace-response"
  "ros_vision/SaveWorkspaceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SaveWorkspace-response>)))
  "Returns md5sum for a message object of type '<SaveWorkspace-response>"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SaveWorkspace-response)))
  "Returns md5sum for a message object of type 'SaveWorkspace-response"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SaveWorkspace-response>)))
  "Returns full string definition for message of type '<SaveWorkspace-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SaveWorkspace-response)))
  "Returns full string definition for message of type 'SaveWorkspace-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SaveWorkspace-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SaveWorkspace-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SaveWorkspace-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SaveWorkspace)))
  'SaveWorkspace-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SaveWorkspace)))
  'SaveWorkspace-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveWorkspace)))
  "Returns string type for a service object of type '<SaveWorkspace>"
  "ros_vision/SaveWorkspace")