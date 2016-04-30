; Auto-generated. Do not edit!


(cl:in-package ros_vision-msg)


;//! \htmlinclude FilterGroup.msg.html

(cl:defclass <FilterGroup> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (filters
    :reader filters
    :initarg :filters
    :type (cl:vector ros_vision-msg:Filter)
   :initform (cl:make-array 0 :element-type 'ros_vision-msg:Filter :initial-element (cl:make-instance 'ros_vision-msg:Filter))))
)

(cl:defclass FilterGroup (<FilterGroup>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FilterGroup>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FilterGroup)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-msg:<FilterGroup> is deprecated: use ros_vision-msg:FilterGroup instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <FilterGroup>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:name-val is deprecated.  Use ros_vision-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'filters-val :lambda-list '(m))
(cl:defmethod filters-val ((m <FilterGroup>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:filters-val is deprecated.  Use ros_vision-msg:filters instead.")
  (filters m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FilterGroup>) ostream)
  "Serializes a message object of type '<FilterGroup>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'filters))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'filters))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FilterGroup>) istream)
  "Deserializes a message object of type '<FilterGroup>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'filters) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'filters)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'ros_vision-msg:Filter))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FilterGroup>)))
  "Returns string type for a message object of type '<FilterGroup>"
  "ros_vision/FilterGroup")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FilterGroup)))
  "Returns string type for a message object of type 'FilterGroup"
  "ros_vision/FilterGroup")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FilterGroup>)))
  "Returns md5sum for a message object of type '<FilterGroup>"
  "a076ede8b5f58c9a18801edf24eb8ff7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FilterGroup)))
  "Returns md5sum for a message object of type 'FilterGroup"
  "a076ede8b5f58c9a18801edf24eb8ff7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FilterGroup>)))
  "Returns full string definition for message of type '<FilterGroup>"
  (cl:format cl:nil "string name~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FilterGroup)))
  "Returns full string definition for message of type 'FilterGroup"
  (cl:format cl:nil "string name~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FilterGroup>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'filters) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FilterGroup>))
  "Converts a ROS message object to a list"
  (cl:list 'FilterGroup
    (cl:cons ':name (name msg))
    (cl:cons ':filters (filters msg))
))
