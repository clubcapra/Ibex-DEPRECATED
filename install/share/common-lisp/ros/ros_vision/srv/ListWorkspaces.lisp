; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude ListWorkspaces-request.msg.html

(cl:defclass <ListWorkspaces-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ListWorkspaces-request (<ListWorkspaces-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListWorkspaces-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListWorkspaces-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<ListWorkspaces-request> is deprecated: use ros_vision-srv:ListWorkspaces-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListWorkspaces-request>) ostream)
  "Serializes a message object of type '<ListWorkspaces-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListWorkspaces-request>) istream)
  "Deserializes a message object of type '<ListWorkspaces-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListWorkspaces-request>)))
  "Returns string type for a service object of type '<ListWorkspaces-request>"
  "ros_vision/ListWorkspacesRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListWorkspaces-request)))
  "Returns string type for a service object of type 'ListWorkspaces-request"
  "ros_vision/ListWorkspacesRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListWorkspaces-request>)))
  "Returns md5sum for a message object of type '<ListWorkspaces-request>"
  "8b36c598e23fd962676550874c6879f7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListWorkspaces-request)))
  "Returns md5sum for a message object of type 'ListWorkspaces-request"
  "8b36c598e23fd962676550874c6879f7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListWorkspaces-request>)))
  "Returns full string definition for message of type '<ListWorkspaces-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListWorkspaces-request)))
  "Returns full string definition for message of type 'ListWorkspaces-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListWorkspaces-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListWorkspaces-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ListWorkspaces-request
))
;//! \htmlinclude ListWorkspaces-response.msg.html

(cl:defclass <ListWorkspaces-response> (roslisp-msg-protocol:ros-message)
  ((workspaces
    :reader workspaces
    :initarg :workspaces
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass ListWorkspaces-response (<ListWorkspaces-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListWorkspaces-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListWorkspaces-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<ListWorkspaces-response> is deprecated: use ros_vision-srv:ListWorkspaces-response instead.")))

(cl:ensure-generic-function 'workspaces-val :lambda-list '(m))
(cl:defmethod workspaces-val ((m <ListWorkspaces-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:workspaces-val is deprecated.  Use ros_vision-srv:workspaces instead.")
  (workspaces m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListWorkspaces-response>) ostream)
  "Serializes a message object of type '<ListWorkspaces-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'workspaces))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'workspaces))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListWorkspaces-response>) istream)
  "Deserializes a message object of type '<ListWorkspaces-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'workspaces) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'workspaces)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListWorkspaces-response>)))
  "Returns string type for a service object of type '<ListWorkspaces-response>"
  "ros_vision/ListWorkspacesResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListWorkspaces-response)))
  "Returns string type for a service object of type 'ListWorkspaces-response"
  "ros_vision/ListWorkspacesResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListWorkspaces-response>)))
  "Returns md5sum for a message object of type '<ListWorkspaces-response>"
  "8b36c598e23fd962676550874c6879f7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListWorkspaces-response)))
  "Returns md5sum for a message object of type 'ListWorkspaces-response"
  "8b36c598e23fd962676550874c6879f7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListWorkspaces-response>)))
  "Returns full string definition for message of type '<ListWorkspaces-response>"
  (cl:format cl:nil "string[] workspaces~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListWorkspaces-response)))
  "Returns full string definition for message of type 'ListWorkspaces-response"
  (cl:format cl:nil "string[] workspaces~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListWorkspaces-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'workspaces) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListWorkspaces-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ListWorkspaces-response
    (cl:cons ':workspaces (workspaces msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ListWorkspaces)))
  'ListWorkspaces-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ListWorkspaces)))
  'ListWorkspaces-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListWorkspaces)))
  "Returns string type for a service object of type '<ListWorkspaces>"
  "ros_vision/ListWorkspaces")