; Auto-generated. Do not edit!


(cl:in-package ros_vision-srv)


;//! \htmlinclude ListFilterTypes-request.msg.html

(cl:defclass <ListFilterTypes-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ListFilterTypes-request (<ListFilterTypes-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListFilterTypes-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListFilterTypes-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<ListFilterTypes-request> is deprecated: use ros_vision-srv:ListFilterTypes-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListFilterTypes-request>) ostream)
  "Serializes a message object of type '<ListFilterTypes-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListFilterTypes-request>) istream)
  "Deserializes a message object of type '<ListFilterTypes-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListFilterTypes-request>)))
  "Returns string type for a service object of type '<ListFilterTypes-request>"
  "ros_vision/ListFilterTypesRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListFilterTypes-request)))
  "Returns string type for a service object of type 'ListFilterTypes-request"
  "ros_vision/ListFilterTypesRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListFilterTypes-request>)))
  "Returns md5sum for a message object of type '<ListFilterTypes-request>"
  "48ca7f8131dcc85f21cec2237f55b37d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListFilterTypes-request)))
  "Returns md5sum for a message object of type 'ListFilterTypes-request"
  "48ca7f8131dcc85f21cec2237f55b37d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListFilterTypes-request>)))
  "Returns full string definition for message of type '<ListFilterTypes-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListFilterTypes-request)))
  "Returns full string definition for message of type 'ListFilterTypes-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListFilterTypes-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListFilterTypes-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ListFilterTypes-request
))
;//! \htmlinclude ListFilterTypes-response.msg.html

(cl:defclass <ListFilterTypes-response> (roslisp-msg-protocol:ros-message)
  ((filter_list
    :reader filter_list
    :initarg :filter_list
    :type ros_vision-msg:FilterList
    :initform (cl:make-instance 'ros_vision-msg:FilterList)))
)

(cl:defclass ListFilterTypes-response (<ListFilterTypes-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListFilterTypes-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListFilterTypes-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-srv:<ListFilterTypes-response> is deprecated: use ros_vision-srv:ListFilterTypes-response instead.")))

(cl:ensure-generic-function 'filter_list-val :lambda-list '(m))
(cl:defmethod filter_list-val ((m <ListFilterTypes-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-srv:filter_list-val is deprecated.  Use ros_vision-srv:filter_list instead.")
  (filter_list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListFilterTypes-response>) ostream)
  "Serializes a message object of type '<ListFilterTypes-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'filter_list) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListFilterTypes-response>) istream)
  "Deserializes a message object of type '<ListFilterTypes-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'filter_list) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListFilterTypes-response>)))
  "Returns string type for a service object of type '<ListFilterTypes-response>"
  "ros_vision/ListFilterTypesResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListFilterTypes-response)))
  "Returns string type for a service object of type 'ListFilterTypes-response"
  "ros_vision/ListFilterTypesResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListFilterTypes-response>)))
  "Returns md5sum for a message object of type '<ListFilterTypes-response>"
  "48ca7f8131dcc85f21cec2237f55b37d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListFilterTypes-response)))
  "Returns md5sum for a message object of type 'ListFilterTypes-response"
  "48ca7f8131dcc85f21cec2237f55b37d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListFilterTypes-response>)))
  "Returns full string definition for message of type '<ListFilterTypes-response>"
  (cl:format cl:nil "FilterList filter_list~%~%================================================================================~%MSG: ros_vision/FilterList~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListFilterTypes-response)))
  "Returns full string definition for message of type 'ListFilterTypes-response"
  (cl:format cl:nil "FilterList filter_list~%~%================================================================================~%MSG: ros_vision/FilterList~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListFilterTypes-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'filter_list))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListFilterTypes-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ListFilterTypes-response
    (cl:cons ':filter_list (filter_list msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ListFilterTypes)))
  'ListFilterTypes-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ListFilterTypes)))
  'ListFilterTypes-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListFilterTypes)))
  "Returns string type for a service object of type '<ListFilterTypes>"
  "ros_vision/ListFilterTypes")