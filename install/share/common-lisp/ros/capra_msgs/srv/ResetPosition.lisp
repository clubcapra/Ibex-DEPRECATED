; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude ResetPosition-request.msg.html

(cl:defclass <ResetPosition-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ResetPosition-request (<ResetPosition-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ResetPosition-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ResetPosition-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<ResetPosition-request> is deprecated: use capra_msgs-srv:ResetPosition-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ResetPosition-request>) ostream)
  "Serializes a message object of type '<ResetPosition-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ResetPosition-request>) istream)
  "Deserializes a message object of type '<ResetPosition-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ResetPosition-request>)))
  "Returns string type for a service object of type '<ResetPosition-request>"
  "capra_msgs/ResetPositionRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ResetPosition-request)))
  "Returns string type for a service object of type 'ResetPosition-request"
  "capra_msgs/ResetPositionRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ResetPosition-request>)))
  "Returns md5sum for a message object of type '<ResetPosition-request>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ResetPosition-request)))
  "Returns md5sum for a message object of type 'ResetPosition-request"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ResetPosition-request>)))
  "Returns full string definition for message of type '<ResetPosition-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ResetPosition-request)))
  "Returns full string definition for message of type 'ResetPosition-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ResetPosition-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ResetPosition-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ResetPosition-request
))
;//! \htmlinclude ResetPosition-response.msg.html

(cl:defclass <ResetPosition-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ResetPosition-response (<ResetPosition-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ResetPosition-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ResetPosition-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<ResetPosition-response> is deprecated: use capra_msgs-srv:ResetPosition-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ResetPosition-response>) ostream)
  "Serializes a message object of type '<ResetPosition-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ResetPosition-response>) istream)
  "Deserializes a message object of type '<ResetPosition-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ResetPosition-response>)))
  "Returns string type for a service object of type '<ResetPosition-response>"
  "capra_msgs/ResetPositionResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ResetPosition-response)))
  "Returns string type for a service object of type 'ResetPosition-response"
  "capra_msgs/ResetPositionResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ResetPosition-response>)))
  "Returns md5sum for a message object of type '<ResetPosition-response>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ResetPosition-response)))
  "Returns md5sum for a message object of type 'ResetPosition-response"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ResetPosition-response>)))
  "Returns full string definition for message of type '<ResetPosition-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ResetPosition-response)))
  "Returns full string definition for message of type 'ResetPosition-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ResetPosition-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ResetPosition-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ResetPosition-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ResetPosition)))
  'ResetPosition-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ResetPosition)))
  'ResetPosition-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ResetPosition)))
  "Returns string type for a service object of type '<ResetPosition>"
  "capra_msgs/ResetPosition")