; Auto-generated. Do not edit!


(cl:in-package exosystem-msg)


;//! \htmlinclude Sysstatus.msg.html

(cl:defclass <Sysstatus> (roslisp-msg-protocol:ros-message)
  ((theta_m1
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
    :initform 0.0))
)

(cl:defclass Sysstatus (<Sysstatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Sysstatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Sysstatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exosystem-msg:<Sysstatus> is deprecated: use exosystem-msg:Sysstatus instead.")))

(cl:ensure-generic-function 'theta_m1-val :lambda-list '(m))
(cl:defmethod theta_m1-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exosystem-msg:theta_m1-val is deprecated.  Use exosystem-msg:theta_m1 instead.")
  (theta_m1 m))

(cl:ensure-generic-function 'theta_l1-val :lambda-list '(m))
(cl:defmethod theta_l1-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exosystem-msg:theta_l1-val is deprecated.  Use exosystem-msg:theta_l1 instead.")
  (theta_l1 m))

(cl:ensure-generic-function 'delta_theta_r1-val :lambda-list '(m))
(cl:defmethod delta_theta_r1-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exosystem-msg:delta_theta_r1-val is deprecated.  Use exosystem-msg:delta_theta_r1 instead.")
  (delta_theta_r1 m))

(cl:ensure-generic-function 'Trr_ad-val :lambda-list '(m))
(cl:defmethod Trr_ad-val ((m <Sysstatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exosystem-msg:Trr_ad-val is deprecated.  Use exosystem-msg:Trr_ad instead.")
  (Trr_ad m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Sysstatus>) ostream)
  "Serializes a message object of type '<Sysstatus>"
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
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Sysstatus>) istream)
  "Deserializes a message object of type '<Sysstatus>"
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Sysstatus>)))
  "Returns string type for a message object of type '<Sysstatus>"
  "exosystem/Sysstatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Sysstatus)))
  "Returns string type for a message object of type 'Sysstatus"
  "exosystem/Sysstatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Sysstatus>)))
  "Returns md5sum for a message object of type '<Sysstatus>"
  "d950118da79c144be1aca147a9c90400")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Sysstatus)))
  "Returns md5sum for a message object of type 'Sysstatus"
  "d950118da79c144be1aca147a9c90400")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Sysstatus>)))
  "Returns full string definition for message of type '<Sysstatus>"
  (cl:format cl:nil "float32 theta_m1~%float32 theta_l1~%float32 delta_theta_r1~%float32 Trr_ad~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Sysstatus)))
  "Returns full string definition for message of type 'Sysstatus"
  (cl:format cl:nil "float32 theta_m1~%float32 theta_l1~%float32 delta_theta_r1~%float32 Trr_ad~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Sysstatus>))
  (cl:+ 0
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Sysstatus>))
  "Converts a ROS message object to a list"
  (cl:list 'Sysstatus
    (cl:cons ':theta_m1 (theta_m1 msg))
    (cl:cons ':theta_l1 (theta_l1 msg))
    (cl:cons ':delta_theta_r1 (delta_theta_r1 msg))
    (cl:cons ':Trr_ad (Trr_ad msg))
))