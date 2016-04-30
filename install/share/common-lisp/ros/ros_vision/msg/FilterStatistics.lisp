; Auto-generated. Do not edit!


(cl:in-package ros_vision-msg)


;//! \htmlinclude FilterStatistics.msg.html

(cl:defclass <FilterStatistics> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (average_execution_time
    :reader average_execution_time
    :initarg :average_execution_time
    :type cl:float
    :initform 0.0)
   (last_execution_time
    :reader last_execution_time
    :initarg :last_execution_time
    :type cl:float
    :initform 0.0))
)

(cl:defclass FilterStatistics (<FilterStatistics>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FilterStatistics>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FilterStatistics)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-msg:<FilterStatistics> is deprecated: use ros_vision-msg:FilterStatistics instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <FilterStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:name-val is deprecated.  Use ros_vision-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'average_execution_time-val :lambda-list '(m))
(cl:defmethod average_execution_time-val ((m <FilterStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:average_execution_time-val is deprecated.  Use ros_vision-msg:average_execution_time instead.")
  (average_execution_time m))

(cl:ensure-generic-function 'last_execution_time-val :lambda-list '(m))
(cl:defmethod last_execution_time-val ((m <FilterStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:last_execution_time-val is deprecated.  Use ros_vision-msg:last_execution_time instead.")
  (last_execution_time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FilterStatistics>) ostream)
  "Serializes a message object of type '<FilterStatistics>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'average_execution_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'last_execution_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FilterStatistics>) istream)
  "Deserializes a message object of type '<FilterStatistics>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'average_execution_time) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'last_execution_time) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FilterStatistics>)))
  "Returns string type for a message object of type '<FilterStatistics>"
  "ros_vision/FilterStatistics")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FilterStatistics)))
  "Returns string type for a message object of type 'FilterStatistics"
  "ros_vision/FilterStatistics")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FilterStatistics>)))
  "Returns md5sum for a message object of type '<FilterStatistics>"
  "a8b6d5ea7d644a18e4b5d9cfcc65d084")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FilterStatistics)))
  "Returns md5sum for a message object of type 'FilterStatistics"
  "a8b6d5ea7d644a18e4b5d9cfcc65d084")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FilterStatistics>)))
  "Returns full string definition for message of type '<FilterStatistics>"
  (cl:format cl:nil "string name~%float32 average_execution_time~%float32 last_execution_time~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FilterStatistics)))
  "Returns full string definition for message of type 'FilterStatistics"
  (cl:format cl:nil "string name~%float32 average_execution_time~%float32 last_execution_time~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FilterStatistics>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FilterStatistics>))
  "Converts a ROS message object to a list"
  (cl:list 'FilterStatistics
    (cl:cons ':name (name msg))
    (cl:cons ':average_execution_time (average_execution_time msg))
    (cl:cons ':last_execution_time (last_execution_time msg))
))
