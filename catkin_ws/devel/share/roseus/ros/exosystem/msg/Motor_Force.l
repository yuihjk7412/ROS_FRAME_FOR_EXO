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
  :slots (_motor1_force _motor2_force ))

(defmethod exosystem::Motor_Force
  (:init
   (&key
    ((:motor1_force __motor1_force) 0.0)
    ((:motor2_force __motor2_force) 0.0)
    )
   (send-super :init)
   (setq _motor1_force (float __motor1_force))
   (setq _motor2_force (float __motor2_force))
   self)
  (:motor1_force
   (&optional __motor1_force)
   (if __motor1_force (setq _motor1_force __motor1_force)) _motor1_force)
  (:motor2_force
   (&optional __motor2_force)
   (if __motor2_force (setq _motor2_force __motor2_force)) _motor2_force)
  (:serialization-length
   ()
   (+
    ;; float32 _motor1_force
    4
    ;; float32 _motor2_force
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
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _motor1_force
     (setq _motor1_force (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _motor2_force
     (setq _motor2_force (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get exosystem::Motor_Force :md5sum-) "dce6fb85721e943607acc3d3dab6c114")
(setf (get exosystem::Motor_Force :datatype-) "exosystem/Motor_Force")
(setf (get exosystem::Motor_Force :definition-)
      "float32 motor1_force
float32 motor2_force
")



(provide :exosystem/Motor_Force "dce6fb85721e943607acc3d3dab6c114")


