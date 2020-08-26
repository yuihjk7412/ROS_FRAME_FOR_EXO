;; Auto-generated. Do not edit!


(when (boundp 'exosystem::Motor_Force)
  (if (not (find-package "EXOSYSTEM"))
    (make-package "EXOSYSTEM"))
  (shadow 'Motor_Force (find-package "EXOSYSTEM")))
(unless (find-package "EXOSYSTEM::MOTOR_FORCE")
  (make-package "EXOSYSTEM::MOTOR_FORCE"))

(in-package "ROS")
;;//! \htmlinclude Motor_Force.msg.html


(defclass exosystem::Motor_Force
  :super ros::object
  :slots (_motor1_force _motor2_force _xtheta _ytheta _ztheta ))

(defmethod exosystem::Motor_Force
  (:init
   (&key
    ((:motor1_force __motor1_force) 0.0)
    ((:motor2_force __motor2_force) 0.0)
    ((:xtheta __xtheta) 0.0)
    ((:ytheta __ytheta) 0.0)
    ((:ztheta __ztheta) 0.0)
    )
   (send-super :init)
   (setq _motor1_force (float __motor1_force))
   (setq _motor2_force (float __motor2_force))
   (setq _xtheta (float __xtheta))
   (setq _ytheta (float __ytheta))
   (setq _ztheta (float __ztheta))
   self)
  (:motor1_force
   (&optional __motor1_force)
   (if __motor1_force (setq _motor1_force __motor1_force)) _motor1_force)
  (:motor2_force
   (&optional __motor2_force)
   (if __motor2_force (setq _motor2_force __motor2_force)) _motor2_force)
  (:xtheta
   (&optional __xtheta)
   (if __xtheta (setq _xtheta __xtheta)) _xtheta)
  (:ytheta
   (&optional __ytheta)
   (if __ytheta (setq _ytheta __ytheta)) _ytheta)
  (:ztheta
   (&optional __ztheta)
   (if __ztheta (setq _ztheta __ztheta)) _ztheta)
  (:serialization-length
   ()
   (+
    ;; float32 _motor1_force
    4
    ;; float32 _motor2_force
    4
    ;; float32 _xtheta
    4
    ;; float32 _ytheta
    4
    ;; float32 _ztheta
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _motor1_force
       (sys::poke _motor1_force (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _motor2_force
       (sys::poke _motor2_force (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _xtheta
       (sys::poke _xtheta (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _ytheta
       (sys::poke _ytheta (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _ztheta
       (sys::poke _ztheta (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _motor1_force
     (setq _motor1_force (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _motor2_force
     (setq _motor2_force (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _xtheta
     (setq _xtheta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ytheta
     (setq _ytheta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ztheta
     (setq _ztheta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get exosystem::Motor_Force :md5sum-) "c76d4ea67ee1d454970fb9cd2fed9654")
(setf (get exosystem::Motor_Force :datatype-) "exosystem/Motor_Force")
(setf (get exosystem::Motor_Force :definition-)
      "float32 motor1_force
float32 motor2_force
float32 xtheta
float32 ytheta
float32 ztheta
")



(provide :exosystem/Motor_Force "c76d4ea67ee1d454970fb9cd2fed9654")


