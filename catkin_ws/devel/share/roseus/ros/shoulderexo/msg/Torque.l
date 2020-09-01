;; Auto-generated. Do not edit!


(when (boundp 'shoulderexo::Torque)
  (if (not (find-package "SHOULDEREXO"))
    (make-package "SHOULDEREXO"))
  (shadow 'Torque (find-package "SHOULDEREXO")))
(unless (find-package "SHOULDEREXO::TORQUE")
  (make-package "SHOULDEREXO::TORQUE"))

(in-package "ROS")
;;//! \htmlinclude Torque.msg.html


(defclass shoulderexo::Torque
  :super ros::object
  :slots (_torque1 _torque2 _port_num ))

(defmethod shoulderexo::Torque
  (:init
   (&key
    ((:torque1 __torque1) 0.0)
    ((:torque2 __torque2) 0.0)
    ((:port_num __port_num) 0)
    )
   (send-super :init)
   (setq _torque1 (float __torque1))
   (setq _torque2 (float __torque2))
   (setq _port_num (round __port_num))
   self)
  (:torque1
   (&optional __torque1)
   (if __torque1 (setq _torque1 __torque1)) _torque1)
  (:torque2
   (&optional __torque2)
   (if __torque2 (setq _torque2 __torque2)) _torque2)
  (:port_num
   (&optional __port_num)
   (if __port_num (setq _port_num __port_num)) _port_num)
  (:serialization-length
   ()
   (+
    ;; float32 _torque1
    4
    ;; float32 _torque2
    4
    ;; int32 _port_num
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
     ;; int32 _port_num
       (write-long _port_num s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _torque1
     (setq _torque1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque2
     (setq _torque2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _port_num
     (setq _port_num (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get shoulderexo::Torque :md5sum-) "67e3a742abd7e4b159e23cb00d1df783")
(setf (get shoulderexo::Torque :datatype-) "shoulderexo/Torque")
(setf (get shoulderexo::Torque :definition-)
      "float32 torque1
float32 torque2
int32 port_num

")



(provide :shoulderexo/Torque "67e3a742abd7e4b159e23cb00d1df783")


