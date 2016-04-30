; Auto-generated. Do not edit!


(cl:in-package capra_ai-srv)


;//! \htmlinclude AddGoal-request.msg.html

(cl:defclass <AddGoal-request> (roslisp-msg-protocol:ros-message)
  ((goal_with_priority
    :reader goal_with_priority
    :initarg :goal_with_priority
    :type capra_ai-msg:GoalWithPriority
    :initform (cl:make-instance 'capra_ai-msg:GoalWithPriority))
   (add_after_current
    :reader add_after_current
    :initarg :add_after_current
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass AddGoal-request (<AddGoal-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddGoal-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddGoal-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_ai-srv:<AddGoal-request> is deprecated: use capra_ai-srv:AddGoal-request instead.")))

(cl:ensure-generic-function 'goal_with_priority-val :lambda-list '(m))
(cl:defmethod goal_with_priority-val ((m <AddGoal-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-srv:goal_with_priority-val is deprecated.  Use capra_ai-srv:goal_with_priority instead.")
  (goal_with_priority m))

(cl:ensure-generic-function 'add_after_current-val :lambda-list '(m))
(cl:defmethod add_after_current-val ((m <AddGoal-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-srv:add_after_current-val is deprecated.  Use capra_ai-srv:add_after_current instead.")
  (add_after_current m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddGoal-request>) ostream)
  "Serializes a message object of type '<AddGoal-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal_with_priority) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'add_after_current) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddGoal-request>) istream)
  "Deserializes a message object of type '<AddGoal-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal_with_priority) istream)
    (cl:setf (cl:slot-value msg 'add_after_current) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddGoal-request>)))
  "Returns string type for a service object of type '<AddGoal-request>"
  "capra_ai/AddGoalRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddGoal-request)))
  "Returns string type for a service object of type 'AddGoal-request"
  "capra_ai/AddGoalRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddGoal-request>)))
  "Returns md5sum for a message object of type '<AddGoal-request>"
  "0b3960086158a5efbef97244ca7ac745")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddGoal-request)))
  "Returns md5sum for a message object of type 'AddGoal-request"
  "0b3960086158a5efbef97244ca7ac745")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddGoal-request>)))
  "Returns full string definition for message of type '<AddGoal-request>"
  (cl:format cl:nil "GoalWithPriority goal_with_priority~%bool add_after_current~%~%================================================================================~%MSG: capra_ai/GoalWithPriority~%actionlib_msgs/GoalID goal_id~%geometry_msgs/Pose pose~%uint32 priority~%================================================================================~%MSG: actionlib_msgs/GoalID~%# The stamp should store the time at which this goal was requested.~%# It is used by an action server when it tries to preempt all~%# goals that were requested before a certain time~%time stamp~%~%# The id provides a way to associate feedback and~%# result message with specific goal requests. The id~%# specified must be unique.~%string id~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddGoal-request)))
  "Returns full string definition for message of type 'AddGoal-request"
  (cl:format cl:nil "GoalWithPriority goal_with_priority~%bool add_after_current~%~%================================================================================~%MSG: capra_ai/GoalWithPriority~%actionlib_msgs/GoalID goal_id~%geometry_msgs/Pose pose~%uint32 priority~%================================================================================~%MSG: actionlib_msgs/GoalID~%# The stamp should store the time at which this goal was requested.~%# It is used by an action server when it tries to preempt all~%# goals that were requested before a certain time~%time stamp~%~%# The id provides a way to associate feedback and~%# result message with specific goal requests. The id~%# specified must be unique.~%string id~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddGoal-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal_with_priority))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddGoal-request>))
  "Converts a ROS message object to a list"
  (cl:list 'AddGoal-request
    (cl:cons ':goal_with_priority (goal_with_priority msg))
    (cl:cons ':add_after_current (add_after_current msg))
))
;//! \htmlinclude AddGoal-response.msg.html

(cl:defclass <AddGoal-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass AddGoal-response (<AddGoal-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddGoal-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddGoal-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_ai-srv:<AddGoal-response> is deprecated: use capra_ai-srv:AddGoal-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <AddGoal-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-srv:success-val is deprecated.  Use capra_ai-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddGoal-response>) ostream)
  "Serializes a message object of type '<AddGoal-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddGoal-response>) istream)
  "Deserializes a message object of type '<AddGoal-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddGoal-response>)))
  "Returns string type for a service object of type '<AddGoal-response>"
  "capra_ai/AddGoalResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddGoal-response)))
  "Returns string type for a service object of type 'AddGoal-response"
  "capra_ai/AddGoalResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddGoal-response>)))
  "Returns md5sum for a message object of type '<AddGoal-response>"
  "0b3960086158a5efbef97244ca7ac745")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddGoal-response)))
  "Returns md5sum for a message object of type 'AddGoal-response"
  "0b3960086158a5efbef97244ca7ac745")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddGoal-response>)))
  "Returns full string definition for message of type '<AddGoal-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddGoal-response)))
  "Returns full string definition for message of type 'AddGoal-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddGoal-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddGoal-response>))
  "Converts a ROS message object to a list"
  (cl:list 'AddGoal-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'AddGoal)))
  'AddGoal-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'AddGoal)))
  'AddGoal-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddGoal)))
  "Returns string type for a service object of type '<AddGoal>"
  "capra_ai/AddGoal")