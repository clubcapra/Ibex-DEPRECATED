; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude CollectHardIronFieldCalibrationData-request.msg.html

(cl:defclass <CollectHardIronFieldCalibrationData-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass CollectHardIronFieldCalibrationData-request (<CollectHardIronFieldCalibrationData-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CollectHardIronFieldCalibrationData-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CollectHardIronFieldCalibrationData-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<CollectHardIronFieldCalibrationData-request> is deprecated: use capra_msgs-srv:CollectHardIronFieldCalibrationData-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CollectHardIronFieldCalibrationData-request>) ostream)
  "Serializes a message object of type '<CollectHardIronFieldCalibrationData-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CollectHardIronFieldCalibrationData-request>) istream)
  "Deserializes a message object of type '<CollectHardIronFieldCalibrationData-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CollectHardIronFieldCalibrationData-request>)))
  "Returns string type for a service object of type '<CollectHardIronFieldCalibrationData-request>"
  "capra_msgs/CollectHardIronFieldCalibrationDataRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CollectHardIronFieldCalibrationData-request)))
  "Returns string type for a service object of type 'CollectHardIronFieldCalibrationData-request"
  "capra_msgs/CollectHardIronFieldCalibrationDataRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CollectHardIronFieldCalibrationData-request>)))
  "Returns md5sum for a message object of type '<CollectHardIronFieldCalibrationData-request>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CollectHardIronFieldCalibrationData-request)))
  "Returns md5sum for a message object of type 'CollectHardIronFieldCalibrationData-request"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CollectHardIronFieldCalibrationData-request>)))
  "Returns full string definition for message of type '<CollectHardIronFieldCalibrationData-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CollectHardIronFieldCalibrationData-request)))
  "Returns full string definition for message of type 'CollectHardIronFieldCalibrationData-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CollectHardIronFieldCalibrationData-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CollectHardIronFieldCalibrationData-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CollectHardIronFieldCalibrationData-request
))
;//! \htmlinclude CollectHardIronFieldCalibrationData-response.msg.html

(cl:defclass <CollectHardIronFieldCalibrationData-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass CollectHardIronFieldCalibrationData-response (<CollectHardIronFieldCalibrationData-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CollectHardIronFieldCalibrationData-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CollectHardIronFieldCalibrationData-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<CollectHardIronFieldCalibrationData-response> is deprecated: use capra_msgs-srv:CollectHardIronFieldCalibrationData-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CollectHardIronFieldCalibrationData-response>) ostream)
  "Serializes a message object of type '<CollectHardIronFieldCalibrationData-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CollectHardIronFieldCalibrationData-response>) istream)
  "Deserializes a message object of type '<CollectHardIronFieldCalibrationData-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CollectHardIronFieldCalibrationData-response>)))
  "Returns string type for a service object of type '<CollectHardIronFieldCalibrationData-response>"
  "capra_msgs/CollectHardIronFieldCalibrationDataResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CollectHardIronFieldCalibrationData-response)))
  "Returns string type for a service object of type 'CollectHardIronFieldCalibrationData-response"
  "capra_msgs/CollectHardIronFieldCalibrationDataResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CollectHardIronFieldCalibrationData-response>)))
  "Returns md5sum for a message object of type '<CollectHardIronFieldCalibrationData-response>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CollectHardIronFieldCalibrationData-response)))
  "Returns md5sum for a message object of type 'CollectHardIronFieldCalibrationData-response"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CollectHardIronFieldCalibrationData-response>)))
  "Returns full string definition for message of type '<CollectHardIronFieldCalibrationData-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CollectHardIronFieldCalibrationData-response)))
  "Returns full string definition for message of type 'CollectHardIronFieldCalibrationData-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CollectHardIronFieldCalibrationData-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CollectHardIronFieldCalibrationData-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CollectHardIronFieldCalibrationData-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CollectHardIronFieldCalibrationData)))
  'CollectHardIronFieldCalibrationData-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CollectHardIronFieldCalibrationData)))
  'CollectHardIronFieldCalibrationData-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CollectHardIronFieldCalibrationData)))
  "Returns string type for a service object of type '<CollectHardIronFieldCalibrationData>"
  "capra_msgs/CollectHardIronFieldCalibrationData")