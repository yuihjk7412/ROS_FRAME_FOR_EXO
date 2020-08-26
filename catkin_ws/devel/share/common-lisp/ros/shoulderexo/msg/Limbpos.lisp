; Auto-generated. Do not edit!


(cl:in-package shoulderexo-msg)


;//! \htmlinclude Limbpos.msg.html

(cl:defclass <Limbpos> (roslisp-msg-protocol:ros-message)
  ((xtheta
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

(cl:defclass Limbpos (<Limbpos>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Limbpos>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Limbpos)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name shoulderexo-msg:<Limbpos> is deprecated: use shoulderexo-msg:Limbpos instead.")))

(cl:ensure-generic-function 'xtheta-val :lambda-list '(m))
(cl:defmethod xtheta-val ((m <Limbpos>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:xtheta-val is deprecated.  Use shoulderexo-msg:xtheta instead.")
  (xtheta m))

(cl:ensure-generic-function 'ytheta-val :lambda-list '(m))
(cl:defmethod ytheta-val ((m <Limbpos>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:ytheta-val is deprecated.  Use shoulderexo-msg:ytheta instead.")
  (ytheta m))

(cl:ensure-generic-function 'ztheta-val :lambda-list '(m))
(cl:defmethod ztheta-val ((m <Limbpos>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:ztheta-val is deprecated.  Use shoulderexo-msg:ztheta instead.")
  (ztheta m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Limbpos>) ostream)
  "Serializes a message object of type '<Limbpos>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Limbpos>) istream)
  "Deserializes a message object of type '<Limbpos>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Limbpos>)))
  "Returns string type for a message object of type '<Limbpos>"
  "shoulderexo/Limbpos")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Limbpos)))
  "Returns string type for a message object of type 'Limbpos"
  "shoulderexo/Limbpos")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Limbpos>)))
  "Returns md5sum for a message object of type '<Limbpos>"
  "397010c589a871e910a38f804cb36983")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Limbpos)))
  "Returns md5sum for a message object of type 'Limbpos"
  "397010c589a871e910a38f804cb36983")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Limbpos>)))
  "Returns full string definition for message of type '<Limbpos>"
  (cl:format cl:nil "float32 xtheta~%float32 ytheta~%float32 ztheta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Limbpos)))
  "Returns full string definition for message of type 'Limbpos"
  (cl:format cl:nil "float32 xtheta~%float32 ytheta~%float32 ztheta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Limbpos>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Limbpos>))
  "Converts a ROS message object to a list"
  (cl:list 'Limbpos
    (cl:cons ':xtheta (xtheta msg))
    (cl:cons ':ytheta (ytheta msg))
    (cl:cons ':ztheta (ztheta msg))
))
