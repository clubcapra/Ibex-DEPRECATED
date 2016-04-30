; Auto-generated. Do not edit!


(cl:in-package ros_vision-msg)


;//! \htmlinclude FilterGroupNames.msg.html

(cl:defclass <FilterGroupNames> (roslisp-msg-protocol:ros-message)
  ((names
    :reader names
    :initarg :names
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass FilterGroupNames (<FilterGroupNames>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FilterGroupNames>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FilterGroupNames)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-msg:<FilterGroupNames> is deprecated: use ros_vision-msg:FilterGroupNames instead.")))

(cl:ensure-generic-function 'names-val :lambda-list '(m))
(cl:defmethod names-val ((m <FilterGroupNames>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:names-val is deprecated.  Use ros_vision-msg:names instead.")
  (names m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FilterGroupNames>) ostream)
  "Serializes a message object of type '<FilterGroupNames>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'names))))
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
   (cl:slot-value msg 'names))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FilterGroupNames>) istream)
  "Deserializes a message object of type '<FilterGroupNames>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'names) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'names)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FilterGroupNames>)))
  "Returns string type for a message object of type '<FilterGroupNames>"
  "ros_vision/FilterGroupNames")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FilterGroupNames)))
  "Returns string type for a message object of type 'FilterGroupNames"
  "ros_vision/FilterGroupNames")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FilterGroupNames>)))
  "Returns md5sum for a message object of type '<FilterGroupNames>"
  "dc7ae3609524b18034e49294a4ce670e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FilterGroupNames)))
  "Returns md5sum for a message object of type 'FilterGroupNames"
  "dc7ae3609524b18034e49294a4ce670e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FilterGroupNames>)))
  "Returns full string definition for message of type '<FilterGroupNames>"
  (cl:format cl:nil "string[] names~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FilterGroupNames)))
  "Returns full string definition for message of type 'FilterGroupNames"
  (cl:format cl:nil "string[] names~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FilterGroupNames>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'names) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FilterGroupNames>))
  "Converts a ROS message object to a list"
  (cl:list 'FilterGroupNames
    (cl:cons ':names (names msg))
))
