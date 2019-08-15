; Auto-generated. Do not edit!


(cl:in-package exosystem-msg)


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
    :initform 0.0))
)

(cl:defclass Motor_Force (<Motor_Force>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Motor_Force>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Motor_Force)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exosystem-msg:<Motor_Force> is deprecated: use exosystem-msg:Motor_Force instead.")))

(cl:ensure-generic-function 'motor1_force-val :lambda-list '(m))
(cl:defmethod motor1_force-val ((m <Motor_Force>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exosystem-msg:motor1_force-val is deprecated.  Use exosystem-msg:motor1_force instead.")
  (motor1_force m))

(cl:ensure-generic-function 'motor2_force-val :lambda-list '(m))
(cl:defmethod motor2_force-val ((m <Motor_Force>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exosystem-msg:motor2_force-val is deprecated.  Use exosystem-msg:motor2_force instead.")
  (motor2_force m))
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Motor_Force>)))
  "Returns string type for a message object of type '<Motor_Force>"
  "exosystem/Motor_Force")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Motor_Force)))
  "Returns string type for a message object of type 'Motor_Force"
  "exosystem/Motor_Force")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Motor_Force>)))
  "Returns md5sum for a message object of type '<Motor_Force>"
  "dce6fb85721e943607acc3d3dab6c114")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Motor_Force)))
  "Returns md5sum for a message object of type 'Motor_Force"
  "dce6fb85721e943607acc3d3dab6c114")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Motor_Force>)))
  "Returns full string definition for message of type '<Motor_Force>"
  (cl:format cl:nil "float32 motor1_force~%float32 motor2_force~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Motor_Force)))
  "Returns full string definition for message of type 'Motor_Force"
  (cl:format cl:nil "float32 motor1_force~%float32 motor2_force~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Motor_Force>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Motor_Force>))
  "Converts a ROS message object to a list"
  (cl:list 'Motor_Force
    (cl:cons ':motor1_force (motor1_force msg))
    (cl:cons ':motor2_force (motor2_force msg))
))
