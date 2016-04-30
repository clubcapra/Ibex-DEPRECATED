; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude GetWorkspace-request.msg.html

(cl:defclass <GetWorkspace-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetWorkspace-request (<GetWorkspace-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetWorkspace-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetWorkspace-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<GetWorkspace-request> is deprecated: use ros_vision-srv:GetWorkspace-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetWorkspace-request>) ostream)
  "Serializes a message object of type '<GetWorkspace-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetWorkspace-request>) istream)
  "Deserializes a message object of type '<GetWorkspace-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetWorkspace-request>)))
  "Returns string type for a service object of type '<GetWorkspace-request>"
  "ros_vision/GetWorkspaceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetWorkspace-request)))
  "Returns string type for a service object of type 'GetWorkspace-request"
  "ros_vision/GetWorkspaceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetWorkspace-request>)))
  "Returns md5sum for a message object of type '<GetWorkspace-request>"
  "4fe033c7c690050d20ac47435e8e465c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetWorkspace-request)))
  "Returns md5sum for a message object of type 'GetWorkspace-request"
  "4fe033c7c690050d20ac47435e8e465c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetWorkspace-request>)))
  "Returns full string definition for message of type '<GetWorkspace-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetWorkspace-request)))
  "Returns full string definition for message of type 'GetWorkspace-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetWorkspace-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetWorkspace-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetWorkspace-request
))
;//! \htmlinclude GetWorkspace-response.msg.html

(cl:defclass <GetWorkspace-response> (roslisp-msg-protocol:ros-message)
  ((workspace
    :reader workspace
    :initarg :workspace
    :type ros_vision-msg:Workspace
    :initform (cl:make-instance 'ros_vision-msg:Workspace)))
)

(cl:defclass GetWorkspace-response (<GetWorkspace-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetWorkspace-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetWorkspace-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<GetWorkspace-response> is deprecated: use ros_vision-srv:GetWorkspace-response instead.")))

(cl:ensure-generic-function 'workspace-val :lambda-list '(m))
(cl:defmethod workspace-val ((m <GetWorkspace-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:workspace-val is deprecated.  Use ros_vision-srv:workspace instead.")
  (workspace m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetWorkspace-response>) ostream)
  "Serializes a message object of type '<GetWorkspace-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'workspace) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetWorkspace-response>) istream)
  "Deserializes a message object of type '<GetWorkspace-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'workspace) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetWorkspace-response>)))
  "Returns string type for a service object of type '<GetWorkspace-response>"
  "ros_vision/GetWorkspaceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetWorkspace-response)))
  "Returns string type for a service object of type 'GetWorkspace-response"
  "ros_vision/GetWorkspaceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetWorkspace-response>)))
  "Returns md5sum for a message object of type '<GetWorkspace-response>"
  "4fe033c7c690050d20ac47435e8e465c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetWorkspace-response)))
  "Returns md5sum for a message object of type 'GetWorkspace-response"
  "4fe033c7c690050d20ac47435e8e465c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetWorkspace-response>)))
  "Returns full string definition for message of type '<GetWorkspace-response>"
  (cl:format cl:nil "Workspace workspace~%~%================================================================================~%MSG: ros_vision/Workspace~%string name~%IODescriptor[] input_topics~%FilterGroup[] filter_groups~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/FilterGroup~%string name~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetWorkspace-response)))
  "Returns full string definition for message of type 'GetWorkspace-response"
  (cl:format cl:nil "Workspace workspace~%~%================================================================================~%MSG: ros_vision/Workspace~%string name~%IODescriptor[] input_topics~%FilterGroup[] filter_groups~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/FilterGroup~%string name~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetWorkspace-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'workspace))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetWorkspace-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetWorkspace-response
    (cl:cons ':workspace (workspace msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetWorkspace)))
  'GetWorkspace-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetWorkspace)))
  'GetWorkspace-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetWorkspace)))
  "Returns string type for a service object of type '<GetWorkspace>"
  "ros_vision/GetWorkspace")