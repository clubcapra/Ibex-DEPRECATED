; Auto-generated. Do not edit!


(cl:in-package capra_controlpanel-srv)


;//! \htmlinclude Flash-request.msg.html

(cl:defclass <Flash-request> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Flash-request (<Flash-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Flash-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Flash-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_controlpanel-srv:<Flash-request> is deprecated: use capra_controlpanel-srv:Flash-request instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <Flash-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-srv:state-val is deprecated.  Use capra_controlpanel-srv:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Flash-request>) ostream)
  "Serializes a message object of type '<Flash-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'state) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Flash-request>) istream)
  "Deserializes a message object of type '<Flash-request>"
    (cl:setf (cl:slot-value msg 'state) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Flash-request>)))
  "Returns string type for a service object of type '<Flash-request>"
  "capra_controlpanel/FlashRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Flash-request)))
  "Returns string type for a service object of type 'Flash-request"
  "capra_controlpanel/FlashRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Flash-request>)))
  "Returns md5sum for a message object of type '<Flash-request>"
  "4581db74aae4efc6534413a8b210908c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Flash-request)))
  "Returns md5sum for a message object of type 'Flash-request"
  "4581db74aae4efc6534413a8b210908c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Flash-request>)))
  "Returns full string definition for message of type '<Flash-request>"
  (cl:format cl:nil "bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Flash-request)))
  "Returns full string definition for message of type 'Flash-request"
  (cl:format cl:nil "bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Flash-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Flash-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Flash-request
    (cl:cons ':state (state msg))
))
;//! \htmlinclude Flash-response.msg.html

(cl:defclass <Flash-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Flash-response (<Flash-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Flash-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Flash-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_controlpanel-srv:<Flash-response> is deprecated: use capra_controlpanel-srv:Flash-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <Flash-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_controlpanel-srv:success-val is deprecated.  Use capra_controlpanel-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Flash-response>) ostream)
  "Serializes a message object of type '<Flash-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Flash-response>) istream)
  "Deserializes a message object of type '<Flash-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Flash-response>)))
  "Returns string type for a service object of type '<Flash-response>"
  "capra_controlpanel/FlashResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Flash-response)))
  "Returns string type for a service object of type 'Flash-response"
  "capra_controlpanel/FlashResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Flash-response>)))
  "Returns md5sum for a message object of type '<Flash-response>"
  "4581db74aae4efc6534413a8b210908c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Flash-response)))
  "Returns md5sum for a message object of type 'Flash-response"
  "4581db74aae4efc6534413a8b210908c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Flash-response>)))
  "Returns full string definition for message of type '<Flash-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Flash-response)))
  "Returns full string definition for message of type 'Flash-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Flash-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Flash-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Flash-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Flash)))
  'Flash-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Flash)))
  'Flash-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Flash)))
  "Returns string type for a service object of type '<Flash>"
  "capra_controlpanel/Flash")