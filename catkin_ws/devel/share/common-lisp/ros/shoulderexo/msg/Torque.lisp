; Auto-generated. Do not edit!


(cl:in-package shoulderexo-msg)


;//! \htmlinclude Torque.msg.html

(cl:defclass <Torque> (roslisp-msg-protocol:ros-message)
  ((torque1
    :reader torque1
    :initarg :torque1
    :type cl:float
    :initform 0.0)
   (torque2
    :reader torque2
    :initarg :torque2
    :type cl:float
    :initform 0.0)
   (port_num
    :reader port_num
    :initarg :port_num
    :type cl:integer
    :initform 0))
)

(cl:defclass Torque (<Torque>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Torque>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Torque)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name shoulderexo-msg:<Torque> is deprecated: use shoulderexo-msg:Torque instead.")))

(cl:ensure-generic-function 'torque1-val :lambda-list '(m))
(cl:defmethod torque1-val ((m <Torque>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:torque1-val is deprecated.  Use shoulderexo-msg:torque1 instead.")
  (torque1 m))

(cl:ensure-generic-function 'torque2-val :lambda-list '(m))
(cl:defmethod torque2-val ((m <Torque>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:torque2-val is deprecated.  Use shoulderexo-msg:torque2 instead.")
  (torque2 m))

(cl:ensure-generic-function 'port_num-val :lambda-list '(m))
(cl:defmethod port_num-val ((m <Torque>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:port_num-val is deprecated.  Use shoulderexo-msg:port_num instead.")
  (port_num m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Torque>) ostream)
  "Serializes a message object of type '<Torque>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'port_num)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Torque>) istream)
  "Deserializes a message object of type '<Torque>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'port_num) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Torque>)))
  "Returns string type for a message object of type '<Torque>"
  "shoulderexo/Torque")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Torque)))
  "Returns string type for a message object of type 'Torque"
  "shoulderexo/Torque")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Torque>)))
  "Returns md5sum for a message object of type '<Torque>"
  "67e3a742abd7e4b159e23cb00d1df783")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Torque)))
  "Returns md5sum for a message object of type 'Torque"
  "67e3a742abd7e4b159e23cb00d1df783")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Torque>)))
  "Returns full string definition for message of type '<Torque>"
  (cl:format cl:nil "float32 torque1~%float32 torque2~%int32 port_num~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Torque)))
  "Returns full string definition for message of type 'Torque"
  (cl:format cl:nil "float32 torque1~%float32 torque2~%int32 port_num~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Torque>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Torque>))
  "Converts a ROS message object to a list"
  (cl:list 'Torque
    (cl:cons ':torque1 (torque1 msg))
    (cl:cons ':torque2 (torque2 msg))
    (cl:cons ':port_num (port_num msg))
))
