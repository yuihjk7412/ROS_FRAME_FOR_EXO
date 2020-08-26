; Auto-generated. Do not edit!


(cl:in-package shoulderexo-msg)


;//! \htmlinclude Motor_Force.msg.html

(cl:defclass <Motor_Force> (roslisp-msg-protocol:ros-message)
  ((motor1_force
    :reader motor1_force
    :initarg :motor1_force
    :type cl:float
    :initform 0.0)
   (motor2_force
    :reader motor2_force
    :initarg :motor2_force
    :type cl:float
    :initform 0.0)
   (xtheta
    :reader xtheta
    :initarg :xtheta
    :type cl:float
    :initform 0.0)
   (ytheta
    :reader ytheta
    :initarg :ytheta
    :type cl:float
    :initform 0.0)
   (ztheta
    :reader ztheta
    :initarg :ztheta
    :type cl:float
    :initform 0.0))
)

(cl:defclass Motor_Force (<Motor_Force>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Motor_Force>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Motor_Force)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name shoulderexo-msg:<Motor_Force> is deprecated: use shoulderexo-msg:Motor_Force instead.")))

(cl:ensure-generic-function 'motor1_force-val :lambda-list '(m))
(cl:defmethod motor1_force-val ((m <Motor_Force>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:motor1_force-val is deprecated.  Use shoulderexo-msg:motor1_force instead.")
  (motor1_force m))

(cl:ensure-generic-function 'motor2_force-val :lambda-list '(m))
(cl:defmethod motor2_force-val ((m <Motor_Force>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:motor2_force-val is deprecated.  Use shoulderexo-msg:motor2_force instead.")
  (motor2_force m))

(cl:ensure-generic-function 'xtheta-val :lambda-list '(m))
(cl:defmethod xtheta-val ((m <Motor_Force>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:xtheta-val is deprecated.  Use shoulderexo-msg:xtheta instead.")
  (xtheta m))

(cl:ensure-generic-function 'ytheta-val :lambda-list '(m))
(cl:defmethod ytheta-val ((m <Motor_Force>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:ytheta-val is deprecated.  Use shoulderexo-msg:ytheta instead.")
  (ytheta m))

(cl:ensure-generic-function 'ztheta-val :lambda-list '(m))
(cl:defmethod ztheta-val ((m <Motor_Force>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:ztheta-val is deprecated.  Use shoulderexo-msg:ztheta instead.")
  (ztheta m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Motor_Force>) ostream)
  "Serializes a message object of type '<Motor_Force>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'motor1_force))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'motor2_force))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'xtheta))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ytheta))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ztheta))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Motor_Force>) istream)
  "Deserializes a message object of type '<Motor_Force>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'motor1_force) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'motor2_force) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'xtheta) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ytheta) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ztheta) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Motor_Force>)))
  "Returns string type for a message object of type '<Motor_Force>"
  "shoulderexo/Motor_Force")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Motor_Force)))
  "Returns string type for a message object of type 'Motor_Force"
  "shoulderexo/Motor_Force")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Motor_Force>)))
  "Returns md5sum for a message object of type '<Motor_Force>"
  "c76d4ea67ee1d454970fb9cd2fed9654")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Motor_Force)))
  "Returns md5sum for a message object of type 'Motor_Force"
  "c76d4ea67ee1d454970fb9cd2fed9654")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Motor_Force>)))
  "Returns full string definition for message of type '<Motor_Force>"
  (cl:format cl:nil "float32 motor1_force~%float32 motor2_force~%float32 xtheta~%float32 ytheta~%float32 ztheta~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Motor_Force)))
  "Returns full string definition for message of type 'Motor_Force"
  (cl:format cl:nil "float32 motor1_force~%float32 motor2_force~%float32 xtheta~%float32 ytheta~%float32 ztheta~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Motor_Force>))
  (cl:+ 0
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Motor_Force>))
  "Converts a ROS message object to a list"
  (cl:list 'Motor_Force
    (cl:cons ':motor1_force (motor1_force msg))
    (cl:cons ':motor2_force (motor2_force msg))
    (cl:cons ':xtheta (xtheta msg))
    (cl:cons ':ytheta (ytheta msg))
    (cl:cons ':ztheta (ztheta msg))
))
