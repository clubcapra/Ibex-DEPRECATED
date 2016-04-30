; Auto-generated. Do not edit!


(cl:in-package ros_vision-msg)


;//! \htmlinclude IODescriptor.msg.html

(cl:defclass <IODescriptor> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (topic
    :reader topic
    :initarg :topic
    :type cl:string
    :initform "")
   (type
    :reader type
    :initarg :type
    :type cl:string
    :initform ""))
)

(cl:defclass IODescriptor (<IODescriptor>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IODescriptor>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IODescriptor)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_vision-msg:<IODescriptor> is deprecated: use ros_vision-msg:IODescriptor instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <IODescriptor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:name-val is deprecated.  Use ros_vision-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'topic-val :lambda-list '(m))
(cl:defmethod topic-val ((m <IODescriptor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:topic-val is deprecated.  Use ros_vision-msg:topic instead.")
  (topic m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <IODescriptor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_vision-msg:type-val is deprecated.  Use ros_vision-msg:type instead.")
  (type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IODescriptor>) ostream)
  "Serializes a message object of type '<IODescriptor>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'topic))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'topic))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IODescriptor>) istream)
  "Deserializes a message object of type '<IODescriptor>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'topic) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'topic) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IODescriptor>)))
  "Returns string type for a message object of type '<IODescriptor>"
  "ros_vision/IODescriptor")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IODescriptor)))
  "Returns string type for a message object of type 'IODescriptor"
  "ros_vision/IODescriptor")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IODescriptor>)))
  "Returns md5sum for a message object of type '<IODescriptor>"
  "76597b08bed209be3f732d1ba4027b85")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IODescriptor)))
  "Returns md5sum for a message object of type 'IODescriptor"
  "76597b08bed209be3f732d1ba4027b85")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IODescriptor>)))
  "Returns full string definition for message of type '<IODescriptor>"
  (cl:format cl:nil "string name~%string topic~%string type~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IODescriptor)))
  "Returns full string definition for message of type 'IODescriptor"
  (cl:format cl:nil "string name~%string topic~%string type~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IODescriptor>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:length (cl:slot-value msg 'topic))
     4 (cl:length (cl:slot-value msg 'type))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IODescriptor>))
  "Converts a ROS message object to a list"
  (cl:list 'IODescriptor
    (cl:cons ':name (name msg))
    (cl:cons ':topic (topic msg))
    (cl:cons ':type (type msg))
))
