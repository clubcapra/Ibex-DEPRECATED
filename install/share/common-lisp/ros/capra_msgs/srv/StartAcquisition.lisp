; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude StartAcquisition-request.msg.html

(cl:defclass <StartAcquisition-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass StartAcquisition-request (<StartAcquisition-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StartAcquisition-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StartAcquisition-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<StartAcquisition-request> is deprecated: use capra_msgs-srv:StartAcquisition-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StartAcquisition-request>) ostream)
  "Serializes a message object of type '<StartAcquisition-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StartAcquisition-request>) istream)
  "Deserializes a message object of type '<StartAcquisition-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StartAcquisition-request>)))
  "Returns string type for a service object of type '<StartAcquisition-request>"
  "capra_msgs/StartAcquisitionRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartAcquisition-request)))
  "Returns string type for a service object of type 'StartAcquisition-request"
  "capra_msgs/StartAcquisitionRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StartAcquisition-request>)))
  "Returns md5sum for a message object of type '<StartAcquisition-request>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StartAcquisition-request)))
  "Returns md5sum for a message object of type 'StartAcquisition-request"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StartAcquisition-request>)))
  "Returns full string definition for message of type '<StartAcquisition-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StartAcquisition-request)))
  "Returns full string definition for message of type 'StartAcquisition-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StartAcquisition-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StartAcquisition-request>))
  "Converts a ROS message object to a list"
  (cl:list 'StartAcquisition-request
))
;//! \htmlinclude StartAcquisition-response.msg.html

(cl:defclass <StartAcquisition-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass StartAcquisition-response (<StartAcquisition-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StartAcquisition-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StartAcquisition-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<StartAcquisition-response> is deprecated: use capra_msgs-srv:StartAcquisition-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StartAcquisition-response>) ostream)
  "Serializes a message object of type '<StartAcquisition-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StartAcquisition-response>) istream)
  "Deserializes a message object of type '<StartAcquisition-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StartAcquisition-response>)))
  "Returns string type for a service object of type '<StartAcquisition-response>"
  "capra_msgs/StartAcquisitionResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartAcquisition-response)))
  "Returns string type for a service object of type 'StartAcquisition-response"
  "capra_msgs/StartAcquisitionResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StartAcquisition-response>)))
  "Returns md5sum for a message object of type '<StartAcquisition-response>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StartAcquisition-response)))
  "Returns md5sum for a message object of type 'StartAcquisition-response"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StartAcquisition-response>)))
  "Returns full string definition for message of type '<StartAcquisition-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StartAcquisition-response)))
  "Returns full string definition for message of type 'StartAcquisition-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StartAcquisition-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StartAcquisition-response>))
  "Converts a ROS message object to a list"
  (cl:list 'StartAcquisition-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'StartAcquisition)))
  'StartAcquisition-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'StartAcquisition)))
  'StartAcquisition-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartAcquisition)))
  "Returns string type for a service object of type '<StartAcquisition>"
  "capra_msgs/StartAcquisition")