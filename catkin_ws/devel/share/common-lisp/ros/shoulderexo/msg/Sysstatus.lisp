; Auto-generated. Do not edit!


(cl:in-package shoulderexo-msg)


;//! \htmlinclude Sysstatus.msg.html

(cl:defclass <Sysstatus> (roslisp-msg-protocol:ros-message)
  ((record_flag
    :reader record_flag
    :initarg :record_flag
    :type cl:fixnum
    :initform 0)
   (theta_m1
    :reader theta_m1
    :initarg :theta_m1
    :type cl:float
    :initform 0.0)
   (theta_l1
    :reader theta_l1
    :initarg :theta_l1
    :type cl:float
    :initform 0.0)
   (delta_theta_r1
    :reader delta_theta_r1
    :initarg :delta_theta_r1
    :type cl:float
    :initform 0.0)
   (Trr_ad
    :reader Trr_ad
    :initarg :Trr_ad
    :type cl:float
    :initform 0.0)
   (theta_m2
    :reader theta_m2
    :initarg :theta_m2
    :type cl:float
    :initform 0.0)
   (theta_l2
    :reader theta_l2
    :initarg :theta_l2
    :type cl:float
    :initform 0.0)
   (delta_theta_r2
    :reader delta_theta_r2
    :initarg :delta_theta_r2
    :type cl:float
    :initform 0.0)
   (Trr_cf
    :reader Trr_cf
    :initarg :Trr_cf
    :type cl:float
    :initform 0.0))
)

(cl:defclass Sysstatus (<Sysstatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Sysstatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Sysstatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name shoulderexo-msg:<Sysstatus> is deprecated: use shoulderexo-msg:Sysstatus instead.")))

(cl:ensure-generic-function 'record_flag-val :lambda-list '(m))
(cl:defmethod record_flag-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:record_flag-val is deprecated.  Use shoulderexo-msg:record_flag instead.")
  (record_flag m))

(cl:ensure-generic-function 'theta_m1-val :lambda-list '(m))
(cl:defmethod theta_m1-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:theta_m1-val is deprecated.  Use shoulderexo-msg:theta_m1 instead.")
  (theta_m1 m))

(cl:ensure-generic-function 'theta_l1-val :lambda-list '(m))
(cl:defmethod theta_l1-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:theta_l1-val is deprecated.  Use shoulderexo-msg:theta_l1 instead.")
  (theta_l1 m))

(cl:ensure-generic-function 'delta_theta_r1-val :lambda-list '(m))
(cl:defmethod delta_theta_r1-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:delta_theta_r1-val is deprecated.  Use shoulderexo-msg:delta_theta_r1 instead.")
  (delta_theta_r1 m))

(cl:ensure-generic-function 'Trr_ad-val :lambda-list '(m))
(cl:defmethod Trr_ad-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:Trr_ad-val is deprecated.  Use shoulderexo-msg:Trr_ad instead.")
  (Trr_ad m))

(cl:ensure-generic-function 'theta_m2-val :lambda-list '(m))
(cl:defmethod theta_m2-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:theta_m2-val is deprecated.  Use shoulderexo-msg:theta_m2 instead.")
  (theta_m2 m))

(cl:ensure-generic-function 'theta_l2-val :lambda-list '(m))
(cl:defmethod theta_l2-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:theta_l2-val is deprecated.  Use shoulderexo-msg:theta_l2 instead.")
  (theta_l2 m))

(cl:ensure-generic-function 'delta_theta_r2-val :lambda-list '(m))
(cl:defmethod delta_theta_r2-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:delta_theta_r2-val is deprecated.  Use shoulderexo-msg:delta_theta_r2 instead.")
  (delta_theta_r2 m))

(cl:ensure-generic-function 'Trr_cf-val :lambda-list '(m))
(cl:defmethod Trr_cf-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader shoulderexo-msg:Trr_cf-val is deprecated.  Use shoulderexo-msg:Trr_cf instead.")
  (Trr_cf m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Sysstatus>) ostream)
  "Serializes a message object of type '<Sysstatus>"
  (cl:let* ((signed (cl:slot-value msg 'record_flag)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'theta_m1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'theta_l1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'delta_theta_r1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Trr_ad))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'theta_m2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'theta_l2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'delta_theta_r2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'Trr_cf))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Sysstatus>) istream)
  "Deserializes a message object of type '<Sysstatus>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'record_flag) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'theta_m1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'theta_l1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'delta_theta_r1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Trr_ad) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'theta_m2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'theta_l2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'delta_theta_r2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'Trr_cf) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Sysstatus>)))
  "Returns string type for a message object of type '<Sysstatus>"
  "shoulderexo/Sysstatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Sysstatus)))
  "Returns string type for a message object of type 'Sysstatus"
  "shoulderexo/Sysstatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Sysstatus>)))
  "Returns md5sum for a message object of type '<Sysstatus>"
  "a24a13feba27c82997977933cd4b8af4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Sysstatus)))
  "Returns md5sum for a message object of type 'Sysstatus"
  "a24a13feba27c82997977933cd4b8af4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Sysstatus>)))
  "Returns full string definition for message of type '<Sysstatus>"
  (cl:format cl:nil "int16 record_flag~%float32 theta_m1~%float32 theta_l1~%float32 delta_theta_r1~%float32 Trr_ad~%float32 theta_m2~%float32 theta_l2~%float32 delta_theta_r2~%float32 Trr_cf~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Sysstatus)))
  "Returns full string definition for message of type 'Sysstatus"
  (cl:format cl:nil "int16 record_flag~%float32 theta_m1~%float32 theta_l1~%float32 delta_theta_r1~%float32 Trr_ad~%float32 theta_m2~%float32 theta_l2~%float32 delta_theta_r2~%float32 Trr_cf~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Sysstatus>))
  (cl:+ 0
     2
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Sysstatus>))
  "Converts a ROS message object to a list"
  (cl:list 'Sysstatus
    (cl:cons ':record_flag (record_flag msg))
    (cl:cons ':theta_m1 (theta_m1 msg))
    (cl:cons ':theta_l1 (theta_l1 msg))
    (cl:cons ':delta_theta_r1 (delta_theta_r1 msg))
    (cl:cons ':Trr_ad (Trr_ad msg))
    (cl:cons ':theta_m2 (theta_m2 msg))
    (cl:cons ':theta_l2 (theta_l2 msg))
    (cl:cons ':delta_theta_r2 (delta_theta_r2 msg))
    (cl:cons ':Trr_cf (Trr_cf msg))
))
