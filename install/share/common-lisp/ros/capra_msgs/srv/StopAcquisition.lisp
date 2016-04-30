; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude StopAcquisition-request.msg.html

(cl:defclass <StopAcquisition-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass StopAcquisition-request (<StopAcquisition-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StopAcquisition-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StopAcquisition-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<StopAcquisition-request> is deprecated: use capra_msgs-srv:StopAcquisition-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StopAcquisition-request>) ostream)
  "Serializes a message object of type '<StopAcquisition-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StopAcquisition-request>) istream)
  "Deserializes a message object of type '<StopAcquisition-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StopAcquisition-request>)))
  "Returns string type for a service object of type '<StopAcquisition-request>"
  "capra_msgs/StopAcquisitionRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StopAcquisition-request)))
  "Returns string type for a service object of type 'StopAcquisition-request"
  "capra_msgs/StopAcquisitionRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StopAcquisition-request>)))
  "Returns md5sum for a message object of type '<StopAcquisition-request>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StopAcquisition-request)))
  "Returns md5sum for a message object of type 'StopAcquisition-request"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StopAcquisition-request>)))
  "Returns full string definition for message of type '<StopAcquisition-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StopAcquisition-request)))
  "Returns full string definition for message of type 'StopAcquisition-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StopAcquisition-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StopAcquisition-request>))
  "Converts a ROS message object to a list"
  (cl:list 'StopAcquisition-request
))
;//! \htmlinclude StopAcquisition-response.msg.html

(cl:defclass <StopAcquisition-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass StopAcquisition-response (<StopAcquisition-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StopAcquisition-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StopAcquisition-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<StopAcquisition-response> is deprecated: use capra_msgs-srv:StopAcquisition-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StopAcquisition-response>) ostream)
  "Serializes a message object of type '<StopAcquisition-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StopAcquisition-response>) istream)
  "Deserializes a message object of type '<StopAcquisition-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StopAcquisition-response>)))
  "Returns string type for a service object of type '<StopAcquisition-response>"
  "capra_msgs/StopAcquisitionResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StopAcquisition-response)))
  "Returns string type for a service object of type 'StopAcquisition-response"
  "capra_msgs/StopAcquisitionResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StopAcquisition-response>)))
  "Returns md5sum for a message object of type '<StopAcquisition-response>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StopAcquisition-response)))
  "Returns md5sum for a message object of type 'StopAcquisition-response"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StopAcquisition-response>)))
  "Returns full string definition for message of type '<StopAcquisition-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StopAcquisition-response)))
  "Returns full string definition for message of type 'StopAcquisition-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StopAcquisition-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StopAcquisition-response>))
  "Converts a ROS message object to a list"
  (cl:list 'StopAcquisition-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'StopAcquisition)))
  'StopAcquisition-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'StopAcquisition)))
  'StopAcquisition-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StopAcquisition)))
  "Returns string type for a service object of type '<StopAcquisition>"
  "capra_msgs/StopAcquisition")