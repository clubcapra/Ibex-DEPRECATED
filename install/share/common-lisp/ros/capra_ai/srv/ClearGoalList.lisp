; Auto-generated. Do not edit!


(cl:in-package capra_ai-srv)


;//! \htmlinclude ClearGoalList-request.msg.html

(cl:defclass <ClearGoalList-request> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ClearGoalList-request (<ClearGoalList-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearGoalList-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearGoalList-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_ai-srv:<ClearGoalList-request> is deprecated: use capra_ai-srv:ClearGoalList-request instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <ClearGoalList-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-srv:data-val is deprecated.  Use capra_ai-srv:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearGoalList-request>) ostream)
  "Serializes a message object of type '<ClearGoalList-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'data) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearGoalList-request>) istream)
  "Deserializes a message object of type '<ClearGoalList-request>"
    (cl:setf (cl:slot-value msg 'data) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearGoalList-request>)))
  "Returns string type for a service object of type '<ClearGoalList-request>"
  "capra_ai/ClearGoalListRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearGoalList-request)))
  "Returns string type for a service object of type 'ClearGoalList-request"
  "capra_ai/ClearGoalListRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearGoalList-request>)))
  "Returns md5sum for a message object of type '<ClearGoalList-request>"
  "19340f526e135109f7ccd6ab9f1ca72e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearGoalList-request)))
  "Returns md5sum for a message object of type 'ClearGoalList-request"
  "19340f526e135109f7ccd6ab9f1ca72e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearGoalList-request>)))
  "Returns full string definition for message of type '<ClearGoalList-request>"
  (cl:format cl:nil "bool data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearGoalList-request)))
  "Returns full string definition for message of type 'ClearGoalList-request"
  (cl:format cl:nil "bool data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearGoalList-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearGoalList-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearGoalList-request
    (cl:cons ':data (data msg))
))
;//! \htmlinclude ClearGoalList-response.msg.html

(cl:defclass <ClearGoalList-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ClearGoalList-response (<ClearGoalList-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearGoalList-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearGoalList-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_ai-srv:<ClearGoalList-response> is deprecated: use capra_ai-srv:ClearGoalList-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ClearGoalList-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-srv:success-val is deprecated.  Use capra_ai-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearGoalList-response>) ostream)
  "Serializes a message object of type '<ClearGoalList-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearGoalList-response>) istream)
  "Deserializes a message object of type '<ClearGoalList-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearGoalList-response>)))
  "Returns string type for a service object of type '<ClearGoalList-response>"
  "capra_ai/ClearGoalListResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearGoalList-response)))
  "Returns string type for a service object of type 'ClearGoalList-response"
  "capra_ai/ClearGoalListResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearGoalList-response>)))
  "Returns md5sum for a message object of type '<ClearGoalList-response>"
  "19340f526e135109f7ccd6ab9f1ca72e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearGoalList-response)))
  "Returns md5sum for a message object of type 'ClearGoalList-response"
  "19340f526e135109f7ccd6ab9f1ca72e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearGoalList-response>)))
  "Returns full string definition for message of type '<ClearGoalList-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearGoalList-response)))
  "Returns full string definition for message of type 'ClearGoalList-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearGoalList-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearGoalList-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearGoalList-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ClearGoalList)))
  'ClearGoalList-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ClearGoalList)))
  'ClearGoalList-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearGoalList)))
  "Returns string type for a service object of type '<ClearGoalList>"
  "capra_ai/ClearGoalList")