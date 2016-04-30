; Auto-generated. Do not edit!


(cl:in-package capra_gps-srv)


;//! \htmlinclude AddLatlongGoal-request.msg.html

(cl:defclass <AddLatlongGoal-request> (roslisp-msg-protocol:ros-message)
  ((goal_latlong
    :reader goal_latlong
    :initarg :goal_latlong
    :type sensor_msgs-msg:NavSatFix
    :initform (cl:make-instance 'sensor_msgs-msg:NavSatFix)))
)

(cl:defclass AddLatlongGoal-request (<AddLatlongGoal-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddLatlongGoal-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddLatlongGoal-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_gps-srv:<AddLatlongGoal-request> is deprecated: use capra_gps-srv:AddLatlongGoal-request instead.")))

(cl:ensure-generic-function 'goal_latlong-val :lambda-list '(m))
(cl:defmethod goal_latlong-val ((m <AddLatlongGoal-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_gps-srv:goal_latlong-val is deprecated.  Use capra_gps-srv:goal_latlong instead.")
  (goal_latlong m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddLatlongGoal-request>) ostream)
  "Serializes a message object of type '<AddLatlongGoal-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal_latlong) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddLatlongGoal-request>) istream)
  "Deserializes a message object of type '<AddLatlongGoal-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal_latlong) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddLatlongGoal-request>)))
  "Returns string type for a service object of type '<AddLatlongGoal-request>"
  "capra_gps/AddLatlongGoalRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddLatlongGoal-request)))
  "Returns string type for a service object of type 'AddLatlongGoal-request"
  "capra_gps/AddLatlongGoalRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddLatlongGoal-request>)))
  "Returns md5sum for a message object of type '<AddLatlongGoal-request>"
  "8f63823983f4fc627a448ec343bfcaa5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddLatlongGoal-request)))
  "Returns md5sum for a message object of type 'AddLatlongGoal-request"
  "8f63823983f4fc627a448ec343bfcaa5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddLatlongGoal-request>)))
  "Returns full string definition for message of type '<AddLatlongGoal-request>"
  (cl:format cl:nil "sensor_msgs/NavSatFix goal_latlong~%~%================================================================================~%MSG: sensor_msgs/NavSatFix~%# Navigation Satellite fix for any Global Navigation Satellite System~%#~%# Specified using the WGS 84 reference ellipsoid~%~%# header.stamp specifies the ROS time for this measurement (the~%#        corresponding satellite time may be reported using the~%#        sensor_msgs/TimeReference message).~%#~%# header.frame_id is the frame of reference reported by the satellite~%#        receiver, usually the location of the antenna.  This is a~%#        Euclidean frame relative to the vehicle, not a reference~%#        ellipsoid.~%Header header~%~%# satellite fix status information~%NavSatStatus status~%~%# Latitude [degrees]. Positive is north of equator; negative is south.~%float64 latitude~%~%# Longitude [degrees]. Positive is east of prime meridian; negative is west.~%float64 longitude~%~%# Altitude [m]. Positive is above the WGS 84 ellipsoid~%# (quiet NaN if no altitude is available).~%float64 altitude~%~%# Position covariance [m^2] defined relative to a tangential plane~%# through the reported position. The components are East, North, and~%# Up (ENU), in row-major order.~%#~%# Beware: this coordinate system exhibits singularities at the poles.~%~%float64[9] position_covariance~%~%# If the covariance of the fix is known, fill it in completely. If the~%# GPS receiver provides the variance of each measurement, put them~%# along the diagonal. If only Dilution of Precision is available,~%# estimate an approximate covariance from that.~%~%uint8 COVARIANCE_TYPE_UNKNOWN = 0~%uint8 COVARIANCE_TYPE_APPROXIMATED = 1~%uint8 COVARIANCE_TYPE_DIAGONAL_KNOWN = 2~%uint8 COVARIANCE_TYPE_KNOWN = 3~%~%uint8 position_covariance_type~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/NavSatStatus~%# Navigation Satellite fix status for any Global Navigation Satellite System~%~%# Whether to output an augmented fix is determined by both the fix~%# type and the last time differential corrections were received.  A~%# fix is valid when status >= STATUS_FIX.~%~%int8 STATUS_NO_FIX =  -1        # unable to fix position~%int8 STATUS_FIX =      0        # unaugmented fix~%int8 STATUS_SBAS_FIX = 1        # with satellite-based augmentation~%int8 STATUS_GBAS_FIX = 2        # with ground-based augmentation~%~%int8 status~%~%# Bits defining which Global Navigation Satellite System signals were~%# used by the receiver.~%~%uint16 SERVICE_GPS =     1~%uint16 SERVICE_GLONASS = 2~%uint16 SERVICE_COMPASS = 4      # includes BeiDou.~%uint16 SERVICE_GALILEO = 8~%~%uint16 service~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddLatlongGoal-request)))
  "Returns full string definition for message of type 'AddLatlongGoal-request"
  (cl:format cl:nil "sensor_msgs/NavSatFix goal_latlong~%~%================================================================================~%MSG: sensor_msgs/NavSatFix~%# Navigation Satellite fix for any Global Navigation Satellite System~%#~%# Specified using the WGS 84 reference ellipsoid~%~%# header.stamp specifies the ROS time for this measurement (the~%#        corresponding satellite time may be reported using the~%#        sensor_msgs/TimeReference message).~%#~%# header.frame_id is the frame of reference reported by the satellite~%#        receiver, usually the location of the antenna.  This is a~%#        Euclidean frame relative to the vehicle, not a reference~%#        ellipsoid.~%Header header~%~%# satellite fix status information~%NavSatStatus status~%~%# Latitude [degrees]. Positive is north of equator; negative is south.~%float64 latitude~%~%# Longitude [degrees]. Positive is east of prime meridian; negative is west.~%float64 longitude~%~%# Altitude [m]. Positive is above the WGS 84 ellipsoid~%# (quiet NaN if no altitude is available).~%float64 altitude~%~%# Position covariance [m^2] defined relative to a tangential plane~%# through the reported position. The components are East, North, and~%# Up (ENU), in row-major order.~%#~%# Beware: this coordinate system exhibits singularities at the poles.~%~%float64[9] position_covariance~%~%# If the covariance of the fix is known, fill it in completely. If the~%# GPS receiver provides the variance of each measurement, put them~%# along the diagonal. If only Dilution of Precision is available,~%# estimate an approximate covariance from that.~%~%uint8 COVARIANCE_TYPE_UNKNOWN = 0~%uint8 COVARIANCE_TYPE_APPROXIMATED = 1~%uint8 COVARIANCE_TYPE_DIAGONAL_KNOWN = 2~%uint8 COVARIANCE_TYPE_KNOWN = 3~%~%uint8 position_covariance_type~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: sensor_msgs/NavSatStatus~%# Navigation Satellite fix status for any Global Navigation Satellite System~%~%# Whether to output an augmented fix is determined by both the fix~%# type and the last time differential corrections were received.  A~%# fix is valid when status >= STATUS_FIX.~%~%int8 STATUS_NO_FIX =  -1        # unable to fix position~%int8 STATUS_FIX =      0        # unaugmented fix~%int8 STATUS_SBAS_FIX = 1        # with satellite-based augmentation~%int8 STATUS_GBAS_FIX = 2        # with ground-based augmentation~%~%int8 status~%~%# Bits defining which Global Navigation Satellite System signals were~%# used by the receiver.~%~%uint16 SERVICE_GPS =     1~%uint16 SERVICE_GLONASS = 2~%uint16 SERVICE_COMPASS = 4      # includes BeiDou.~%uint16 SERVICE_GALILEO = 8~%~%uint16 service~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddLatlongGoal-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal_latlong))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddLatlongGoal-request>))
  "Converts a ROS message object to a list"
  (cl:list 'AddLatlongGoal-request
    (cl:cons ':goal_latlong (goal_latlong msg))
))
;//! \htmlinclude AddLatlongGoal-response.msg.html

(cl:defclass <AddLatlongGoal-response> (roslisp-msg-protocol:ros-message)
  ((goal_xy
    :reader goal_xy
    :initarg :goal_xy
    :type geometry_msgs-msg:PoseStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseStamped)))
)

(cl:defclass AddLatlongGoal-response (<AddLatlongGoal-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AddLatlongGoal-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AddLatlongGoal-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name capra_gps-srv:<AddLatlongGoal-response> is deprecated: use capra_gps-srv:AddLatlongGoal-response instead.")))

(cl:ensure-generic-function 'goal_xy-val :lambda-list '(m))
(cl:defmethod goal_xy-val ((m <AddLatlongGoal-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader capra_gps-srv:goal_xy-val is deprecated.  Use capra_gps-srv:goal_xy instead.")
  (goal_xy m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AddLatlongGoal-response>) ostream)
  "Serializes a message object of type '<AddLatlongGoal-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal_xy) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AddLatlongGoal-response>) istream)
  "Deserializes a message object of type '<AddLatlongGoal-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal_xy) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AddLatlongGoal-response>)))
  "Returns string type for a service object of type '<AddLatlongGoal-response>"
  "capra_gps/AddLatlongGoalResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddLatlongGoal-response)))
  "Returns string type for a service object of type 'AddLatlongGoal-response"
  "capra_gps/AddLatlongGoalResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AddLatlongGoal-response>)))
  "Returns md5sum for a message object of type '<AddLatlongGoal-response>"
  "8f63823983f4fc627a448ec343bfcaa5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AddLatlongGoal-response)))
  "Returns md5sum for a message object of type 'AddLatlongGoal-response"
  "8f63823983f4fc627a448ec343bfcaa5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AddLatlongGoal-response>)))
  "Returns full string definition for message of type '<AddLatlongGoal-response>"
  (cl:format cl:nil "geometry_msgs/PoseStamped goal_xy~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AddLatlongGoal-response)))
  "Returns full string definition for message of type 'AddLatlongGoal-response"
  (cl:format cl:nil "geometry_msgs/PoseStamped goal_xy~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AddLatlongGoal-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal_xy))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AddLatlongGoal-response>))
  "Converts a ROS message object to a list"
  (cl:list 'AddLatlongGoal-response
    (cl:cons ':goal_xy (goal_xy msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'AddLatlongGoal)))
  'AddLatlongGoal-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'AddLatlongGoal)))
  'AddLatlongGoal-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AddLatlongGoal)))
  "Returns string type for a service object of type '<AddLatlongGoal>"
  "capra_gps/AddLatlongGoal")