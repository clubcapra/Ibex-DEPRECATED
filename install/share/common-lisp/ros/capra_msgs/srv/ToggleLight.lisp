; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude ToggleLight-request.msg.html

(cl:defclass <ToggleLight-request> (roslisp-msg-protocol:ros-message)
  ((on
    :reader on
    :initarg :on
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ToggleLight-request (<ToggleLight-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ToggleLight-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ToggleLight-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<ToggleLight-request> is deprecated: use capra_msgs-srv:ToggleLight-request instead.")))

(cl:ensure-generic-function 'on-val :lambda-list '(m))
(cl:defmethod on-val ((m <ToggleLight-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:on-val is deprecated.  Use capra_msgs-srv:on instead.")
  (on m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ToggleLight-request>) ostream)
  "Serializes a message object of type '<ToggleLight-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'on) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ToggleLight-request>) istream)
  "Deserializes a message object of type '<ToggleLight-request>"
    (cl:setf (cl:slot-value msg 'on) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ToggleLight-request>)))
  "Returns string type for a service object of type '<ToggleLight-request>"
  "capra_msgs/ToggleLightRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ToggleLight-request)))
  "Returns string type for a service object of type 'ToggleLight-request"
  "capra_msgs/ToggleLightRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ToggleLight-request>)))
  "Returns md5sum for a message object of type '<ToggleLight-request>"
  "74983d2ffe4877de8ae30b7a94625c41")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ToggleLight-request)))
  "Returns md5sum for a message object of type 'ToggleLight-request"
  "74983d2ffe4877de8ae30b7a94625c41")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ToggleLight-request>)))
  "Returns full string definition for message of type '<ToggleLight-request>"
  (cl:format cl:nil "bool on~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ToggleLight-request)))
  "Returns full string definition for message of type 'ToggleLight-request"
  (cl:format cl:nil "bool on~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ToggleLight-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ToggleLight-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ToggleLight-request
    (cl:cons ':on (on msg))
))
;//! \htmlinclude ToggleLight-response.msg.html

(cl:defclass <ToggleLight-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ToggleLight-response (<ToggleLight-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ToggleLight-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ToggleLight-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<ToggleLight-response> is deprecated: use capra_msgs-srv:ToggleLight-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ToggleLight-response>) ostream)
  "Serializes a message object of type '<ToggleLight-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ToggleLight-response>) istream)
  "Deserializes a message object of type '<ToggleLight-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ToggleLight-response>)))
  "Returns string type for a service object of type '<ToggleLight-response>"
  "capra_msgs/ToggleLightResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ToggleLight-response)))
  "Returns string type for a service object of type 'ToggleLight-response"
  "capra_msgs/ToggleLightResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ToggleLight-response>)))
  "Returns md5sum for a message object of type '<ToggleLight-response>"
  "74983d2ffe4877de8ae30b7a94625c41")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ToggleLight-response)))
  "Returns md5sum for a message object of type 'ToggleLight-response"
  "74983d2ffe4877de8ae30b7a94625c41")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ToggleLight-response>)))
  "Returns full string definition for message of type '<ToggleLight-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ToggleLight-response)))
  "Returns full string definition for message of type 'ToggleLight-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ToggleLight-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ToggleLight-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ToggleLight-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ToggleLight)))
  'ToggleLight-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ToggleLight)))
  'ToggleLight-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ToggleLight)))
  "Returns string type for a service object of type '<ToggleLight>"
  "capra_msgs/ToggleLight")