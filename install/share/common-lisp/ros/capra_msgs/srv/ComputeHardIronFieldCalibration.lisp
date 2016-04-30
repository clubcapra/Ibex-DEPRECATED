; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude ComputeHardIronFieldCalibration-request.msg.html

(cl:defclass <ComputeHardIronFieldCalibration-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ComputeHardIronFieldCalibration-request (<ComputeHardIronFieldCalibration-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ComputeHardIronFieldCalibration-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ComputeHardIronFieldCalibration-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<ComputeHardIronFieldCalibration-request> is deprecated: use capra_msgs-srv:ComputeHardIronFieldCalibration-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ComputeHardIronFieldCalibration-request>) ostream)
  "Serializes a message object of type '<ComputeHardIronFieldCalibration-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ComputeHardIronFieldCalibration-request>) istream)
  "Deserializes a message object of type '<ComputeHardIronFieldCalibration-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ComputeHardIronFieldCalibration-request>)))
  "Returns string type for a service object of type '<ComputeHardIronFieldCalibration-request>"
  "capra_msgs/ComputeHardIronFieldCalibrationRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ComputeHardIronFieldCalibration-request)))
  "Returns string type for a service object of type 'ComputeHardIronFieldCalibration-request"
  "capra_msgs/ComputeHardIronFieldCalibrationRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ComputeHardIronFieldCalibration-request>)))
  "Returns md5sum for a message object of type '<ComputeHardIronFieldCalibration-request>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ComputeHardIronFieldCalibration-request)))
  "Returns md5sum for a message object of type 'ComputeHardIronFieldCalibration-request"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ComputeHardIronFieldCalibration-request>)))
  "Returns full string definition for message of type '<ComputeHardIronFieldCalibration-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ComputeHardIronFieldCalibration-request)))
  "Returns full string definition for message of type 'ComputeHardIronFieldCalibration-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ComputeHardIronFieldCalibration-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ComputeHardIronFieldCalibration-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ComputeHardIronFieldCalibration-request
))
;//! \htmlinclude ComputeHardIronFieldCalibration-response.msg.html

(cl:defclass <ComputeHardIronFieldCalibration-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ComputeHardIronFieldCalibration-response (<ComputeHardIronFieldCalibration-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ComputeHardIronFieldCalibration-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ComputeHardIronFieldCalibration-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<ComputeHardIronFieldCalibration-response> is deprecated: use capra_msgs-srv:ComputeHardIronFieldCalibration-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ComputeHardIronFieldCalibration-response>) ostream)
  "Serializes a message object of type '<ComputeHardIronFieldCalibration-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ComputeHardIronFieldCalibration-response>) istream)
  "Deserializes a message object of type '<ComputeHardIronFieldCalibration-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ComputeHardIronFieldCalibration-response>)))
  "Returns string type for a service object of type '<ComputeHardIronFieldCalibration-response>"
  "capra_msgs/ComputeHardIronFieldCalibrationResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ComputeHardIronFieldCalibration-response)))
  "Returns string type for a service object of type 'ComputeHardIronFieldCalibration-response"
  "capra_msgs/ComputeHardIronFieldCalibrationResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ComputeHardIronFieldCalibration-response>)))
  "Returns md5sum for a message object of type '<ComputeHardIronFieldCalibration-response>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ComputeHardIronFieldCalibration-response)))
  "Returns md5sum for a message object of type 'ComputeHardIronFieldCalibration-response"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ComputeHardIronFieldCalibration-response>)))
  "Returns full string definition for message of type '<ComputeHardIronFieldCalibration-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ComputeHardIronFieldCalibration-response)))
  "Returns full string definition for message of type 'ComputeHardIronFieldCalibration-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ComputeHardIronFieldCalibration-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ComputeHardIronFieldCalibration-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ComputeHardIronFieldCalibration-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ComputeHardIronFieldCalibration)))
  'ComputeHardIronFieldCalibration-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ComputeHardIronFieldCalibration)))
  'ComputeHardIronFieldCalibration-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ComputeHardIronFieldCalibration)))
  "Returns string type for a service object of type '<ComputeHardIronFieldCalibration>"
  "capra_msgs/ComputeHardIronFieldCalibration")