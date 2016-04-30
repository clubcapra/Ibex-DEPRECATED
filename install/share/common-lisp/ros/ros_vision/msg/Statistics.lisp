; Auto-generated. Do not edit!


(cl:in-package ros_vision-msg)


;//! \htmlinclude Statistics.msg.html

(cl:defclass <Statistics> (roslisp-msg-protocol:ros-message)
  ((average_execution_time
    :reader average_execution_time
    :initarg :average_execution_time
    :type cl:float
    :initform 0.0)
   (filters
    :reader filters
    :initarg :filters
    :type (cl:vector ros_vision-msg:FilterStatistics)
   :initform (cl:make-array 0 :element-type 'ros_vision-msg:FilterStatistics :initial-element (cl:make-instance 'ros_vision-msg:FilterStatistics))))
)

(cl:defclass Statistics (<Statistics>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Statistics>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Statistics)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-msg:<Statistics> is deprecated: use ros_vision-msg:Statistics instead.")))

(cl:ensure-generic-function 'average_execution_time-val :lambda-list '(m))
(cl:defmethod average_execution_time-val ((m <Statistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:average_execution_time-val is deprecated.  Use ros_vision-msg:average_execution_time instead.")
  (average_execution_time m))

(cl:ensure-generic-function 'filters-val :lambda-list '(m))
(cl:defmethod filters-val ((m <Statistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:filters-val is deprecated.  Use ros_vision-msg:filters instead.")
  (filters m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Statistics>) ostream)
  "Serializes a message object of type '<Statistics>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'average_execution_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'filters))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'filters))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Statistics>) istream)
  "Deserializes a message object of type '<Statistics>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'average_execution_time) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'filters) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'filters)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'ros_vision-msg:FilterStatistics))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Statistics>)))
  "Returns string type for a message object of type '<Statistics>"
  "ros_vision/Statistics")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Statistics)))
  "Returns string type for a message object of type 'Statistics"
  "ros_vision/Statistics")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Statistics>)))
  "Returns md5sum for a message object of type '<Statistics>"
  "bf5006a109010ce73134497d95c76257")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Statistics)))
  "Returns md5sum for a message object of type 'Statistics"
  "bf5006a109010ce73134497d95c76257")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Statistics>)))
  "Returns full string definition for message of type '<Statistics>"
  (cl:format cl:nil "float32 average_execution_time~%FilterStatistics[] filters~%================================================================================~%MSG: ros_vision/FilterStatistics~%string name~%float32 average_execution_time~%float32 last_execution_time~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Statistics)))
  "Returns full string definition for message of type 'Statistics"
  (cl:format cl:nil "float32 average_execution_time~%FilterStatistics[] filters~%================================================================================~%MSG: ros_vision/FilterStatistics~%string name~%float32 average_execution_time~%float32 last_execution_time~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Statistics>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'filters) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Statistics>))
  "Converts a ROS message object to a list"
  (cl:list 'Statistics
    (cl:cons ':average_execution_time (average_execution_time msg))
    (cl:cons ':filters (filters msg))
))
