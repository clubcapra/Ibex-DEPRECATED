; Auto-generated. Do not edit!


(cl:in-package capra_ai-msg)


;//! \htmlinclude GoalWithPriority.msg.html

(cl:defclass <GoalWithPriority> (roslisp-msg-protocol:ros-message)
  ((goal_id
    :reader goal_id
    :initarg :goal_id
    :type actionlib_msgs-msg:GoalID
    :initform (cl:make-instance 'actionlib_msgs-msg:GoalID))
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (priority
    :reader priority
    :initarg :priority
    :type cl:integer
    :initform 0))
)

(cl:defclass GoalWithPriority (<GoalWithPriority>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GoalWithPriority>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GoalWithPriority)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_ai-msg:<GoalWithPriority> is deprecated: use capra_ai-msg:GoalWithPriority instead.")))

(cl:ensure-generic-function 'goal_id-val :lambda-list '(m))
(cl:defmethod goal_id-val ((m <GoalWithPriority>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-msg:goal_id-val is deprecated.  Use capra_ai-msg:goal_id instead.")
  (goal_id m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <GoalWithPriority>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-msg:pose-val is deprecated.  Use capra_ai-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'priority-val :lambda-list '(m))
(cl:defmethod priority-val ((m <GoalWithPriority>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_ai-msg:priority-val is deprecated.  Use capra_ai-msg:priority instead.")
  (priority m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GoalWithPriority>) ostream)
  "Serializes a message object of type '<GoalWithPriority>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal_id) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'priority)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'priority)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'priority)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'priority)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GoalWithPriority>) istream)
  "Deserializes a message object of type '<GoalWithPriority>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal_id) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'priority)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'priority)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'priority)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'priority)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GoalWithPriority>)))
  "Returns string type for a message object of type '<GoalWithPriority>"
  "capra_ai/GoalWithPriority")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GoalWithPriority)))
  "Returns string type for a message object of type 'GoalWithPriority"
  "capra_ai/GoalWithPriority")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GoalWithPriority>)))
  "Returns md5sum for a message object of type '<GoalWithPriority>"
  "98ffe882d55a7727025836eac4535e75")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GoalWithPriority)))
  "Returns md5sum for a message object of type 'GoalWithPriority"
  "98ffe882d55a7727025836eac4535e75")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GoalWithPriority>)))
  "Returns full string definition for message of type '<GoalWithPriority>"
  (cl:format cl:nil "actionlib_msgs/GoalID goal_id~%geometry_msgs/Pose pose~%uint32 priority~%================================================================================~%MSG: actionlib_msgs/GoalID~%# The stamp should store the time at which this goal was requested.~%# It is used by an action server when it tries to preempt all~%# goals that were requested before a certain time~%time stamp~%~%# The id provides a way to associate feedback and~%# result message with specific goal requests. The id~%# specified must be unique.~%string id~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GoalWithPriority)))
  "Returns full string definition for message of type 'GoalWithPriority"
  (cl:format cl:nil "actionlib_msgs/GoalID goal_id~%geometry_msgs/Pose pose~%uint32 priority~%================================================================================~%MSG: actionlib_msgs/GoalID~%# The stamp should store the time at which this goal was requested.~%# It is used by an action server when it tries to preempt all~%# goals that were requested before a certain time~%time stamp~%~%# The id provides a way to associate feedback and~%# result message with specific goal requests. The id~%# specified must be unique.~%string id~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GoalWithPriority>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal_id))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GoalWithPriority>))
  "Converts a ROS message object to a list"
  (cl:list 'GoalWithPriority
    (cl:cons ':goal_id (goal_id msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':priority (priority msg))
))
