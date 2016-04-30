; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude DeleteFilterGroup-request.msg.html

(cl:defclass <DeleteFilterGroup-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass DeleteFilterGroup-request (<DeleteFilterGroup-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DeleteFilterGroup-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DeleteFilterGroup-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<DeleteFilterGroup-request> is deprecated: use ros_vision-srv:DeleteFilterGroup-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <DeleteFilterGroup-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:name-val is deprecated.  Use ros_vision-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DeleteFilterGroup-request>) ostream)
  "Serializes a message object of type '<DeleteFilterGroup-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DeleteFilterGroup-request>) istream)
  "Deserializes a message object of type '<DeleteFilterGroup-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DeleteFilterGroup-request>)))
  "Returns string type for a service object of type '<DeleteFilterGroup-request>"
  "ros_vision/DeleteFilterGroupRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteFilterGroup-request)))
  "Returns string type for a service object of type 'DeleteFilterGroup-request"
  "ros_vision/DeleteFilterGroupRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DeleteFilterGroup-request>)))
  "Returns md5sum for a message object of type '<DeleteFilterGroup-request>"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DeleteFilterGroup-request)))
  "Returns md5sum for a message object of type 'DeleteFilterGroup-request"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DeleteFilterGroup-request>)))
  "Returns full string definition for message of type '<DeleteFilterGroup-request>"
  (cl:format cl:nil "string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DeleteFilterGroup-request)))
  "Returns full string definition for message of type 'DeleteFilterGroup-request"
  (cl:format cl:nil "string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DeleteFilterGroup-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DeleteFilterGroup-request>))
  "Converts a ROS message object to a list"
  (cl:list 'DeleteFilterGroup-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude DeleteFilterGroup-response.msg.html

(cl:defclass <DeleteFilterGroup-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass DeleteFilterGroup-response (<DeleteFilterGroup-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DeleteFilterGroup-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DeleteFilterGroup-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<DeleteFilterGroup-response> is deprecated: use ros_vision-srv:DeleteFilterGroup-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DeleteFilterGroup-response>) ostream)
  "Serializes a message object of type '<DeleteFilterGroup-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DeleteFilterGroup-response>) istream)
  "Deserializes a message object of type '<DeleteFilterGroup-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DeleteFilterGroup-response>)))
  "Returns string type for a service object of type '<DeleteFilterGroup-response>"
  "ros_vision/DeleteFilterGroupResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteFilterGroup-response)))
  "Returns string type for a service object of type 'DeleteFilterGroup-response"
  "ros_vision/DeleteFilterGroupResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DeleteFilterGroup-response>)))
  "Returns md5sum for a message object of type '<DeleteFilterGroup-response>"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DeleteFilterGroup-response)))
  "Returns md5sum for a message object of type 'DeleteFilterGroup-response"
  "c1f3d28f1b044c871e6eff2e9fc3c667")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DeleteFilterGroup-response>)))
  "Returns full string definition for message of type '<DeleteFilterGroup-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DeleteFilterGroup-response)))
  "Returns full string definition for message of type 'DeleteFilterGroup-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DeleteFilterGroup-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DeleteFilterGroup-response>))
  "Converts a ROS message object to a list"
  (cl:list 'DeleteFilterGroup-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'DeleteFilterGroup)))
  'DeleteFilterGroup-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'DeleteFilterGroup)))
  'DeleteFilterGroup-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeleteFilterGroup)))
  "Returns string type for a service object of type '<DeleteFilterGroup>"
  "ros_vision/DeleteFilterGroup")