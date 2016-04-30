; Auto-generated. Do not edit!


(cl:in-package capra_msgs-srv)


;//! \htmlinclude AddGoal-request.msg.html

(cl:defclass <AddGoal-request> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0))
)

(cl:defclass AddGoal-request (<AddGoal-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddGoal-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddGoal-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<AddGoal-request> is deprecated: use capra_msgs-srv:AddGoal-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <AddGoal-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:x-val is deprecated.  Use capra_msgs-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <AddGoal-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_msgs-srv:y-val is deprecated.  Use capra_msgs-srv:y instead.")
  (y m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddGoal-request>) ostream)
  "Serializes a message object of type '<AddGoal-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddGoal-request>) istream)
  "Deserializes a message object of type '<AddGoal-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddGoal-request>)))
  "Returns string type for a service object of type '<AddGoal-request>"
  "capra_msgs/AddGoalRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddGoal-request)))
  "Returns string type for a service object of type 'AddGoal-request"
  "capra_msgs/AddGoalRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddGoal-request>)))
  "Returns md5sum for a message object of type '<AddGoal-request>"
  "ff8d7d66dd3e4b731ef14a45d38888b6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddGoal-request)))
  "Returns md5sum for a message object of type 'AddGoal-request"
  "ff8d7d66dd3e4b731ef14a45d38888b6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddGoal-request>)))
  "Returns full string definition for message of type '<AddGoal-request>"
  (cl:format cl:nil "float32 x~%float32 y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddGoal-request)))
  "Returns full string definition for message of type 'AddGoal-request"
  (cl:format cl:nil "float32 x~%float32 y~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddGoal-request>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddGoal-request>))
  "Converts a ROS message object to a list"
  (cl:list 'AddGoal-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
))
;//! \htmlinclude AddGoal-response.msg.html

(cl:defclass <AddGoal-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass AddGoal-response (<AddGoal-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddGoal-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddGoal-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_msgs-srv:<AddGoal-response> is deprecated: use capra_msgs-srv:AddGoal-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddGoal-response>) ostream)
  "Serializes a message object of type '<AddGoal-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddGoal-response>) istream)
  "Deserializes a message object of type '<AddGoal-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddGoal-response>)))
  "Returns string type for a service object of type '<AddGoal-response>"
  "capra_msgs/AddGoalResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddGoal-response)))
  "Returns string type for a service object of type 'AddGoal-response"
  "capra_msgs/AddGoalResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddGoal-response>)))
  "Returns md5sum for a message object of type '<AddGoal-response>"
  "ff8d7d66dd3e4b731ef14a45d38888b6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddGoal-response)))
  "Returns md5sum for a message object of type 'AddGoal-response"
  "ff8d7d66dd3e4b731ef14a45d38888b6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddGoal-response>)))
  "Returns full string definition for message of type '<AddGoal-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddGoal-response)))
  "Returns full string definition for message of type 'AddGoal-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddGoal-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddGoal-response>))
  "Converts a ROS message object to a list"
  (cl:list 'AddGoal-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'AddGoal)))
  'AddGoal-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'AddGoal)))
  'AddGoal-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddGoal)))
  "Returns string type for a service object of type '<AddGoal>"
  "capra_msgs/AddGoal")