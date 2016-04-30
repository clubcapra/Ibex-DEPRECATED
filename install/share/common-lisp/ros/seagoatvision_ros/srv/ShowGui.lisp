; Auto-generated. Do not edit!


(cl:in-package seagoatvision_ros-srv)


;//! \htmlinclude ShowGui-request.msg.html

(cl:defclass <ShowGui-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ShowGui-request (<ShowGui-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ShowGui-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ShowGui-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name seagoatvision_ros-srv:<ShowGui-request> is deprecated: use seagoatvision_ros-srv:ShowGui-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ShowGui-request>) ostream)
  "Serializes a message object of type '<ShowGui-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ShowGui-request>) istream)
  "Deserializes a message object of type '<ShowGui-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ShowGui-request>)))
  "Returns string type for a service object of type '<ShowGui-request>"
  "seagoatvision_ros/ShowGuiRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ShowGui-request)))
  "Returns string type for a service object of type 'ShowGui-request"
  "seagoatvision_ros/ShowGuiRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ShowGui-request>)))
  "Returns md5sum for a message object of type '<ShowGui-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ShowGui-request)))
  "Returns md5sum for a message object of type 'ShowGui-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ShowGui-request>)))
  "Returns full string definition for message of type '<ShowGui-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ShowGui-request)))
  "Returns full string definition for message of type 'ShowGui-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ShowGui-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ShowGui-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ShowGui-request
))
;//! \htmlinclude ShowGui-response.msg.html

(cl:defclass <ShowGui-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ShowGui-response (<ShowGui-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ShowGui-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ShowGui-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name seagoatvision_ros-srv:<ShowGui-response> is deprecated: use seagoatvision_ros-srv:ShowGui-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ShowGui-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader seagoatvision_ros-srv:success-val is deprecated.  Use seagoatvision_ros-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ShowGui-response>) ostream)
  "Serializes a message object of type '<ShowGui-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ShowGui-response>) istream)
  "Deserializes a message object of type '<ShowGui-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ShowGui-response>)))
  "Returns string type for a service object of type '<ShowGui-response>"
  "seagoatvision_ros/ShowGuiResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ShowGui-response)))
  "Returns string type for a service object of type 'ShowGui-response"
  "seagoatvision_ros/ShowGuiResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ShowGui-response>)))
  "Returns md5sum for a message object of type '<ShowGui-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ShowGui-response)))
  "Returns md5sum for a message object of type 'ShowGui-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ShowGui-response>)))
  "Returns full string definition for message of type '<ShowGui-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ShowGui-response)))
  "Returns full string definition for message of type 'ShowGui-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ShowGui-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ShowGui-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ShowGui-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ShowGui)))
  'ShowGui-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ShowGui)))
  'ShowGui-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ShowGui)))
  "Returns string type for a service object of type '<ShowGui>"
  "seagoatvision_ros/ShowGui")