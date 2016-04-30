; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude DeleteFilter-request.msg.html

(cl:defclass <DeleteFilter-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass DeleteFilter-request (<DeleteFilter-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DeleteFilter-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DeleteFilter-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<DeleteFilter-request> is deprecated: use ros_vision-srv:DeleteFilter-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <DeleteFilter-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:name-val is deprecated.  Use ros_vision-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DeleteFilter-request>) ostream)
  "Serializes a message object of type '<DeleteFilter-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DeleteFilter-request>) istream)
  "Deserializes a message object of type '<DeleteFilter-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DeleteFilter-request>)))
  "Returns string type for a service object of type '<DeleteFilter-request>"
  "ros_vision/DeleteFilterRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteFilter-request)))
  "Returns string type for a service object of type 'DeleteFilter-request"
  "ros_vision/DeleteFilterRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DeleteFilter-request>)))
  "Returns md5sum for a message object of type '<DeleteFilter-request>"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DeleteFilter-request)))
  "Returns md5sum for a message object of type 'DeleteFilter-request"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DeleteFilter-request>)))
  "Returns full string definition for message of type '<DeleteFilter-request>"
  (cl:format cl:nil "string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DeleteFilter-request)))
  "Returns full string definition for message of type 'DeleteFilter-request"
  (cl:format cl:nil "string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DeleteFilter-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DeleteFilter-request>))
  "Converts a ROS message object to a list"
  (cl:list 'DeleteFilter-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude DeleteFilter-response.msg.html

(cl:defclass <DeleteFilter-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass DeleteFilter-response (<DeleteFilter-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DeleteFilter-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DeleteFilter-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<DeleteFilter-response> is deprecated: use ros_vision-srv:DeleteFilter-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DeleteFilter-response>) ostream)
  "Serializes a message object of type '<DeleteFilter-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DeleteFilter-response>) istream)
  "Deserializes a message object of type '<DeleteFilter-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DeleteFilter-response>)))
  "Returns string type for a service object of type '<DeleteFilter-response>"
  "ros_vision/DeleteFilterResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteFilter-response)))
  "Returns string type for a service object of type 'DeleteFilter-response"
  "ros_vision/DeleteFilterResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DeleteFilter-response>)))
  "Returns md5sum for a message object of type '<DeleteFilter-response>"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DeleteFilter-response)))
  "Returns md5sum for a message object of type 'DeleteFilter-response"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DeleteFilter-response>)))
  "Returns full string definition for message of type '<DeleteFilter-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DeleteFilter-response)))
  "Returns full string definition for message of type 'DeleteFilter-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DeleteFilter-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DeleteFilter-response>))
  "Converts a ROS message object to a list"
  (cl:list 'DeleteFilter-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'DeleteFilter)))
  'DeleteFilter-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'DeleteFilter)))
  'DeleteFilter-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteFilter)))
  "Returns string type for a service object of type '<DeleteFilter>"
  "ros_vision/DeleteFilter")