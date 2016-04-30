; Auto-generated. Do not edit!


(cl:in-package ros_vision-msg)


;//! \htmlinclude FilterList.msg.html

(cl:defclass <FilterList> (roslisp-msg-protocol:ros-message)
  ((filters
    :reader filters
    :initarg :filters
    :type (cl:vector ros_vision-msg:Filter)
   :initform (cl:make-array 0 :element-type 'ros_vision-msg:Filter :initial-element (cl:make-instance 'ros_vision-msg:Filter))))
)

(cl:defclass FilterList (<FilterList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FilterList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FilterList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-msg:<FilterList> is deprecated: use ros_vision-msg:FilterList instead.")))

(cl:ensure-generic-function 'filters-val :lambda-list '(m))
(cl:defmethod filters-val ((m <FilterList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:filters-val is deprecated.  Use ros_vision-msg:filters instead.")
  (filters m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FilterList>) ostream)
  "Serializes a message object of type '<FilterList>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'filters))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'filters))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FilterList>) istream)
  "Deserializes a message object of type '<FilterList>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FilterList>)))
  "Returns string type for a message object of type '<FilterList>"
  "ros_vision/FilterList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FilterList)))
  "Returns string type for a message object of type 'FilterList"
  "ros_vision/FilterList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FilterList>)))
  "Returns md5sum for a message object of type '<FilterList>"
  "95c111bc027a9ce077a15d7c9894685b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FilterList)))
  "Returns md5sum for a message object of type 'FilterList"
  "95c111bc027a9ce077a15d7c9894685b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FilterList>)))
  "Returns full string definition for message of type '<FilterList>"
  (cl:format cl:nil "Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FilterList)))
  "Returns full string definition for message of type 'FilterList"
  (cl:format cl:nil "Filter[] filters~%================================================================================~%MSG: ros_vision/Filter~%string name~%string type~%string description~%IODescriptor[] inputs~%IODescriptor[] outputs~%Parameter[] parameters~%~%================================================================================~%MSG: ros_vision/IODescriptor~%string name~%string topic~%string type~%================================================================================~%MSG: ros_vision/Parameter~%string name~%string description~%string type~%string default~%string min~%string max~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FilterList>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'filters) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FilterList>))
  "Converts a ROS message object to a list"
  (cl:list 'FilterList
    (cl:cons ':filters (filters msg))
))
