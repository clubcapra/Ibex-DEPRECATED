; Auto-generated. Do not edit!


(cl:in-package ros_vision-msg)


;//! \htmlinclude Workspace.msg.html

(cl:defclass <Workspace> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (input_topics
    :reader input_topics
    :initarg :input_topics
    :type (cl:vector ros_vision-msg:IODescriptor)
   :initform (cl:make-array 0 :element-type 'ros_vision-msg:IODescriptor :initial-element (cl:make-instance 'ros_vision-msg:IODescriptor)))
   (filter_groups
    :reader filter_groups
    :initarg :filter_groups
    :type (cl:vector ros_vision-msg:FilterGroup)
   :initform (cl:make-array 0 :element-type 'ros_vision-msg:FilterGroup :initial-element (cl:make-instance 'ros_vision-msg:FilterGroup))))
)

(cl:defclass Workspace (<Workspace>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Workspace>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Workspace)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-msg:<Workspace> is deprecated: use ros_vision-msg:Workspace instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <Workspace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:name-val is deprecated.  Use ros_vision-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'input_topics-val :lambda-list '(m))
(cl:defmethod input_topics-val ((m <Workspace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:input_topics-val is deprecated.  Use ros_vision-msg:input_topics instead.")
  (input_topics m))

(cl:ensure-generic-function 'filter_groups-val :lambda-list '(m))
(cl:defmethod filter_groups-val ((m <Workspace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:filter_groups-val is deprecated.  Use ros_vision-msg:filter_groups instead.")
  (filter_groups m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Workspace>) ostream)
  "Serializes a message object of type '<Workspace>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'input_topics))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'input_topics))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'filter_groups))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'filter_groups))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Workspace>) istream)
  "Deserializes a message object of type '<Workspace>"
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
  (cl:setf (cl:slot-value msg 'input_topics) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'input_topics)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'ros_vision-msg:IODescriptor))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'filter_groups) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'filter_groups)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'ros_vision-msg:FilterGroup))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Workspace>)))
  "Returns string type for a message object of type '<Workspace>"
  "ros_vision/Workspace")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Workspace)))
  "Returns string type for a message object of type 'Workspace"
  "ros_vision/Workspace")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Workspace>)))
  "Returns md5sum for a message object of type '<Workspace>"
  "ba66aee9ea0e6ca468c0e52fb7dc685e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Workspace)))
  "Returns md5sum for a message object of type 'Workspace"
  "ba66aee9ea0e6ca468c0e52fb7dc685e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Workspace>)))
  "Returns full string definition for message of type '<Workspace>"
  (cl:format cl:nil "string name~%IODescriptor[] input_topics~%FilterGroup[] filter_groups~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/FilterGroup~%string name~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Workspace)))
  "Returns full string definition for message of type 'Workspace"
  (cl:format cl:nil "string name~%IODescriptor[] input_topics~%FilterGroup[] filter_groups~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/FilterGroup~%string name~%Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Workspace>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'input_topics) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'filter_groups) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Workspace>))
  "Converts a ROS message object to a list"
  (cl:list 'Workspace
    (cl:cons ':name (name msg))
    (cl:cons ':input_topics (input_topics msg))
    (cl:cons ':filter_groups (filter_groups msg))
))
