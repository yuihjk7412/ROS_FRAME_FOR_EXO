;; Auto-generated. Do not edit!


(when (boundp 'exosystem::Torque)
  (if (not (find-package "EXOSYSTEM"))
    (make-package "EXOSYSTEM"))
  (shadow 'Torque (find-package "EXOSYSTEM")))
(unless (find-package "EXOSYSTEM::TORQUE")
  (make-package "EXOSYSTEM::TORQUE"))

(in-package "ROS")
;;//! \htmlinclude Torque.msg.html


(defclass exosystem::Torque
  :super ros::object
  :slots (_torque1 _torque2 ))

(defmethod exosystem::Torque
  (:init
   (&key
    ((:torque1 __torque1) 0.0)
    ((:torque2 __torque2) 0.0)
    )
   (send-super :init)
   (setq _torque1 (float __torque1))
   (setq _torque2 (float __torque2))
   self)
  (:torque1
   (&optional __torque1)
   (if __torque1 (setq _torque1 __torque1)) _torque1)
  (:torque2
   (&optional __torque2)
   (if __torque2 (setq _torque2 __torque2)) _torque2)
  (:serialization-length
   ()
   (+
    ;; float32 _torque1
    4
    ;; float32 _torque2
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _torque1
       (sys::poke _torque1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque2
       (sys::poke _torque2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _torque1
     (setq _torque1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque2
     (setq _torque2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get exosystem::Torque :md5sum-) "4352967d78fc540447ece6189f8160cf")
(setf (get exosystem::Torque :datatype-) "exosystem/Torque")
(setf (get exosystem::Torque :definition-)
      "float32 torque1
float32 torque2
")



(provide :exosystem/Torque "4352967d78fc540447ece6189f8160cf")


