; Auto-generated. Do not edit!


(cl:in-package ros_vision-msg)


;//! \htmlinclude StartSignal.msg.html

(cl:defclass <StartSignal> (roslisp-msg-protocol:ros-message)
  ((group_names
    :reader group_names
    :initarg :group_names
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (input_time
    :reader input_time
    :initarg :input_time
    :type cl:real
    :initform 0))
)

(cl:defclass StartSignal (<StartSignal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StartSignal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StartSignal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-msg:<StartSignal> is deprecated: use ros_vision-msg:StartSignal instead.")))

(cl:ensure-generic-function 'group_names-val :lambda-list '(m))
(cl:defmethod group_names-val ((m <StartSignal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:group_names-val is deprecated.  Use ros_vision-msg:group_names instead.")
  (group_names m))

(cl:ensure-generic-function 'input_time-val :lambda-list '(m))
(cl:defmethod input_time-val ((m <StartSignal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:input_time-val is deprecated.  Use ros_vision-msg:input_time instead.")
  (input_time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StartSignal>) ostream)
  "Serializes a message object of type '<StartSignal>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'group_names))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'group_names))
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'input_time)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'input_time) (cl:floor (cl:slot-value msg 'input_time)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StartSignal>) istream)
  "Deserializes a message object of type '<StartSignal>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'group_names) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'group_names)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'input_time) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StartSignal>)))
  "Returns string type for a message object of type '<StartSignal>"
  "ros_vision/StartSignal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartSignal)))
  "Returns string type for a message object of type 'StartSignal"
  "ros_vision/StartSignal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StartSignal>)))
  "Returns md5sum for a message object of type '<StartSignal>"
  "bc31190eab6d5b529f09c9c5a9c6058e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StartSignal)))
  "Returns md5sum for a message object of type 'StartSignal"
  "bc31190eab6d5b529f09c9c5a9c6058e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StartSignal>)))
  "Returns full string definition for message of type '<StartSignal>"
  (cl:format cl:nil "string[] group_names~%time input_time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StartSignal)))
  "Returns full string definition for message of type 'StartSignal"
  (cl:format cl:nil "string[] group_names~%time input_time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StartSignal>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'group_names) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StartSignal>))
  "Converts a ROS message object to a list"
  (cl:list 'StartSignal
    (cl:cons ':group_names (group_names msg))
    (cl:cons ':input_time (input_time msg))
))
