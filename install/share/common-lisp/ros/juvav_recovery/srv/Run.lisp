; Auto-generated. Do not edit!


(cl:in-package juvav_recovery-srv)


;//! \htmlinclude Run-request.msg.html

(cl:defclass <Run-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Run-request (<Run-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Run-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Run-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name juvav_recovery-srv:<Run-request> is deprecated: use juvav_recovery-srv:Run-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Run-request>) ostream)
  "Serializes a message object of type '<Run-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Run-request>) istream)
  "Deserializes a message object of type '<Run-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Run-request>)))
  "Returns string type for a service object of type '<Run-request>"
  "juvav_recovery/RunRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Run-request)))
  "Returns string type for a service object of type 'Run-request"
  "juvav_recovery/RunRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Run-request>)))
  "Returns md5sum for a message object of type '<Run-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Run-request)))
  "Returns md5sum for a message object of type 'Run-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Run-request>)))
  "Returns full string definition for message of type '<Run-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Run-request)))
  "Returns full string definition for message of type 'Run-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Run-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Run-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Run-request
))
;//! \htmlinclude Run-response.msg.html

(cl:defclass <Run-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Run-response (<Run-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Run-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Run-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name juvav_recovery-srv:<Run-response> is deprecated: use juvav_recovery-srv:Run-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <Run-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader juvav_recovery-srv:success-val is deprecated.  Use juvav_recovery-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Run-response>) ostream)
  "Serializes a message object of type '<Run-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Run-response>) istream)
  "Deserializes a message object of type '<Run-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Run-response>)))
  "Returns string type for a service object of type '<Run-response>"
  "juvav_recovery/RunResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Run-response)))
  "Returns string type for a service object of type 'Run-response"
  "juvav_recovery/RunResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Run-response>)))
  "Returns md5sum for a message object of type '<Run-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Run-response)))
  "Returns md5sum for a message object of type 'Run-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Run-response>)))
  "Returns full string definition for message of type '<Run-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Run-response)))
  "Returns full string definition for message of type 'Run-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Run-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Run-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Run-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Run)))
  'Run-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Run)))
  'Run-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Run)))
  "Returns string type for a service object of type '<Run>"
  "juvav_recovery/Run")