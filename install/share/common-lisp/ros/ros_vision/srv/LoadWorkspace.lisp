; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude LoadWorkspace-request.msg.html

(cl:defclass <LoadWorkspace-request> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass LoadWorkspace-request (<LoadWorkspace-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LoadWorkspace-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LoadWorkspace-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<LoadWorkspace-request> is deprecated: use ros_vision-srv:LoadWorkspace-request instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <LoadWorkspace-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:name-val is deprecated.  Use ros_vision-srv:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LoadWorkspace-request>) ostream)
  "Serializes a message object of type '<LoadWorkspace-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LoadWorkspace-request>) istream)
  "Deserializes a message object of type '<LoadWorkspace-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LoadWorkspace-request>)))
  "Returns string type for a service object of type '<LoadWorkspace-request>"
  "ros_vision/LoadWorkspaceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadWorkspace-request)))
  "Returns string type for a service object of type 'LoadWorkspace-request"
  "ros_vision/LoadWorkspaceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LoadWorkspace-request>)))
  "Returns md5sum for a message object of type '<LoadWorkspace-request>"
  "b23106c960b24118a58dad42411ac73e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LoadWorkspace-request)))
  "Returns md5sum for a message object of type 'LoadWorkspace-request"
  "b23106c960b24118a58dad42411ac73e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LoadWorkspace-request>)))
  "Returns full string definition for message of type '<LoadWorkspace-request>"
  (cl:format cl:nil "string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LoadWorkspace-request)))
  "Returns full string definition for message of type 'LoadWorkspace-request"
  (cl:format cl:nil "string name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LoadWorkspace-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LoadWorkspace-request>))
  "Converts a ROS message object to a list"
  (cl:list 'LoadWorkspace-request
    (cl:cons ':name (name msg))
))
;//! \htmlinclude LoadWorkspace-response.msg.html

(cl:defclass <LoadWorkspace-response> (roslisp-msg-protocol:ros-message)
  ((workspace
    :reader workspace
    :initarg :workspace
    :type ros_vision-msg:Workspace
    :initform (cl:make-instance 'ros_vision-msg:Workspace)))
)

(cl:defclass LoadWorkspace-response (<LoadWorkspace-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LoadWorkspace-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LoadWorkspace-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<LoadWorkspace-response> is deprecated: use ros_vision-srv:LoadWorkspace-response instead.")))

(cl:ensure-generic-function 'workspace-val :lambda-list '(m))
(cl:defmethod workspace-val ((m <LoadWorkspace-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:workspace-val is deprecated.  Use ros_vision-srv:workspace instead.")
  (workspace m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LoadWorkspace-response>) ostream)
  "Serializes a message object of type '<LoadWorkspace-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'workspace) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LoadWorkspace-response>) istream)
  "Deserializes a message object of type '<LoadWorkspace-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'workspace) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LoadWorkspace-response>)))
  "Returns string type for a service object of type '<LoadWorkspace-response>"
  "ros_vision/LoadWorkspaceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadWorkspace-response)))
  "Returns string type for a service object of type 'LoadWorkspace-response"
  "ros_vision/LoadWorkspaceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LoadWorkspace-response>)))
  "Returns md5sum for a message object of type '<LoadWorkspace-response>"
  "b23106c960b24118a58dad42411ac73e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LoadWorkspace-response)))
  "Returns md5sum for a message object of type 'LoadWorkspace-response"
  "b23106c960b24118a58dad42411ac73e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LoadWorkspace-response>)))
  "Returns full string definition for message of type '<LoadWorkspace-response>"
  (cl:format cl:nil "Workspace workspace~%~%================================================================================~%MSG: ros_vision/Workspace~%string name~%IODescriptor[] input_topics~%FilterGroup[] filter_groups~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/FilterGroup~%string name~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LoadWorkspace-response)))
  "Returns full string definition for message of type 'LoadWorkspace-response"
  (cl:format cl:nil "Workspace workspace~%~%================================================================================~%MSG: ros_vision/Workspace~%string name~%IODescriptor[] input_topics~%FilterGroup[] filter_groups~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/FilterGroup~%string name~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LoadWorkspace-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'workspace))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LoadWorkspace-response>))
  "Converts a ROS message object to a list"
  (cl:list 'LoadWorkspace-response
    (cl:cons ':workspace (workspace msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'LoadWorkspace)))
  'LoadWorkspace-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'LoadWorkspace)))
  'LoadWorkspace-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LoadWorkspace)))
  "Returns string type for a service object of type '<LoadWorkspace>"
  "ros_vision/LoadWorkspace")