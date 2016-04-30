; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude InitializeHardIronFieldCalibration-request.msg.html

(cl:defclass <InitializeHardIronFieldCalibration-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass InitializeHardIronFieldCalibration-request (<InitializeHardIronFieldCalibration-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <InitializeHardIronFieldCalibration-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'InitializeHardIronFieldCalibration-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<InitializeHardIronFieldCalibration-request> is deprecated: use capra_msgs-srv:InitializeHardIronFieldCalibration-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <InitializeHardIronFieldCalibration-request>) ostream)
  "Serializes a message object of type '<InitializeHardIronFieldCalibration-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <InitializeHardIronFieldCalibration-request>) istream)
  "Deserializes a message object of type '<InitializeHardIronFieldCalibration-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<InitializeHardIronFieldCalibration-request>)))
  "Returns string type for a service object of type '<InitializeHardIronFieldCalibration-request>"
  "capra_msgs/InitializeHardIronFieldCalibrationRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InitializeHardIronFieldCalibration-request)))
  "Returns string type for a service object of type 'InitializeHardIronFieldCalibration-request"
  "capra_msgs/InitializeHardIronFieldCalibrationRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<InitializeHardIronFieldCalibration-request>)))
  "Returns md5sum for a message object of type '<InitializeHardIronFieldCalibration-request>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'InitializeHardIronFieldCalibration-request)))
  "Returns md5sum for a message object of type 'InitializeHardIronFieldCalibration-request"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<InitializeHardIronFieldCalibration-request>)))
  "Returns full string definition for message of type '<InitializeHardIronFieldCalibration-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'InitializeHardIronFieldCalibration-request)))
  "Returns full string definition for message of type 'InitializeHardIronFieldCalibration-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <InitializeHardIronFieldCalibration-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <InitializeHardIronFieldCalibration-request>))
  "Converts a ROS message object to a list"
  (cl:list 'InitializeHardIronFieldCalibration-request
))
;//! \htmlinclude InitializeHardIronFieldCalibration-response.msg.html

(cl:defclass <InitializeHardIronFieldCalibration-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass InitializeHardIronFieldCalibration-response (<InitializeHardIronFieldCalibration-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <InitializeHardIronFieldCalibration-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'InitializeHardIronFieldCalibration-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<InitializeHardIronFieldCalibration-response> is deprecated: use capra_msgs-srv:InitializeHardIronFieldCalibration-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <InitializeHardIronFieldCalibration-response>) ostream)
  "Serializes a message object of type '<InitializeHardIronFieldCalibration-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <InitializeHardIronFieldCalibration-response>) istream)
  "Deserializes a message object of type '<InitializeHardIronFieldCalibration-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<InitializeHardIronFieldCalibration-response>)))
  "Returns string type for a service object of type '<InitializeHardIronFieldCalibration-response>"
  "capra_msgs/InitializeHardIronFieldCalibrationResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InitializeHardIronFieldCalibration-response)))
  "Returns string type for a service object of type 'InitializeHardIronFieldCalibration-response"
  "capra_msgs/InitializeHardIronFieldCalibrationResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<InitializeHardIronFieldCalibration-response>)))
  "Returns md5sum for a message object of type '<InitializeHardIronFieldCalibration-response>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'InitializeHardIronFieldCalibration-response)))
  "Returns md5sum for a message object of type 'InitializeHardIronFieldCalibration-response"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<InitializeHardIronFieldCalibration-response>)))
  "Returns full string definition for message of type '<InitializeHardIronFieldCalibration-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'InitializeHardIronFieldCalibration-response)))
  "Returns full string definition for message of type 'InitializeHardIronFieldCalibration-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <InitializeHardIronFieldCalibration-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <InitializeHardIronFieldCalibration-response>))
  "Converts a ROS message object to a list"
  (cl:list 'InitializeHardIronFieldCalibration-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'InitializeHardIronFieldCalibration)))
  'InitializeHardIronFieldCalibration-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'InitializeHardIronFieldCalibration)))
  'InitializeHardIronFieldCalibration-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'InitializeHardIronFieldCalibration)))
  "Returns string type for a service object of type '<InitializeHardIronFieldCalibration>"
  "capra_msgs/InitializeHardIronFieldCalibration")