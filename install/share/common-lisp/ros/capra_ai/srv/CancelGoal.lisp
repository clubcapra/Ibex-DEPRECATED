; Auto-generated. Do not edit!


(cl:in-package capra_ai-srv)


;//! \htmlinclude CancelGoal-request.msg.html

(cl:defclass <CancelGoal-request> (roslisp-msg-protocol:ros-message)
  ((cancel
    :reader cancel
    :initarg :cancel
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass CancelGoal-request (<CancelGoal-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CancelGoal-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CancelGoal-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_ai-srv:<CancelGoal-request> is deprecated: use capra_ai-srv:CancelGoal-request instead.")))

(cl:ensure-generic-function 'cancel-val :lambda-list '(m))
(cl:defmethod cancel-val ((m <CancelGoal-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-srv:cancel-val is deprecated.  Use capra_ai-srv:cancel instead.")
  (cancel m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CancelGoal-request>) ostream)
  "Serializes a message object of type '<CancelGoal-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'cancel) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CancelGoal-request>) istream)
  "Deserializes a message object of type '<CancelGoal-request>"
    (cl:setf (cl:slot-value msg 'cancel) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CancelGoal-request>)))
  "Returns string type for a service object of type '<CancelGoal-request>"
  "capra_ai/CancelGoalRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CancelGoal-request)))
  "Returns string type for a service object of type 'CancelGoal-request"
  "capra_ai/CancelGoalRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CancelGoal-request>)))
  "Returns md5sum for a message object of type '<CancelGoal-request>"
  "6d6dba85b2fd764127a311dd3aeaaf2f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CancelGoal-request)))
  "Returns md5sum for a message object of type 'CancelGoal-request"
  "6d6dba85b2fd764127a311dd3aeaaf2f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CancelGoal-request>)))
  "Returns full string definition for message of type '<CancelGoal-request>"
  (cl:format cl:nil "bool cancel~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CancelGoal-request)))
  "Returns full string definition for message of type 'CancelGoal-request"
  (cl:format cl:nil "bool cancel~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CancelGoal-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CancelGoal-request>))
  "Converts a ROS message object to a list"
  (cl:list 'CancelGoal-request
    (cl:cons ':cancel (cancel msg))
))
;//! \htmlinclude CancelGoal-response.msg.html

(cl:defclass <CancelGoal-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass CancelGoal-response (<CancelGoal-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CancelGoal-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CancelGoal-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_ai-srv:<CancelGoal-response> is deprecated: use capra_ai-srv:CancelGoal-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <CancelGoal-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-srv:success-val is deprecated.  Use capra_ai-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CancelGoal-response>) ostream)
  "Serializes a message object of type '<CancelGoal-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CancelGoal-response>) istream)
  "Deserializes a message object of type '<CancelGoal-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CancelGoal-response>)))
  "Returns string type for a service object of type '<CancelGoal-response>"
  "capra_ai/CancelGoalResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CancelGoal-response)))
  "Returns string type for a service object of type 'CancelGoal-response"
  "capra_ai/CancelGoalResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CancelGoal-response>)))
  "Returns md5sum for a message object of type '<CancelGoal-response>"
  "6d6dba85b2fd764127a311dd3aeaaf2f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CancelGoal-response)))
  "Returns md5sum for a message object of type 'CancelGoal-response"
  "6d6dba85b2fd764127a311dd3aeaaf2f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CancelGoal-response>)))
  "Returns full string definition for message of type '<CancelGoal-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CancelGoal-response)))
  "Returns full string definition for message of type 'CancelGoal-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CancelGoal-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CancelGoal-response>))
  "Converts a ROS message object to a list"
  (cl:list 'CancelGoal-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'CancelGoal)))
  'CancelGoal-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'CancelGoal)))
  'CancelGoal-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CancelGoal)))
  "Returns string type for a service object of type '<CancelGoal>"
  "capra_ai/CancelGoal")