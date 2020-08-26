;; Auto-generated. Do not edit!


(when (boundp 'shoulderexo::Encoder)
  (if (not (find-package "SHOULDEREXO"))
    (make-package "SHOULDEREXO"))
  (shadow 'Encoder (find-package "SHOULDEREXO")))
(unless (find-package "SHOULDEREXO::ENCODER")
  (make-package "SHOULDEREXO::ENCODER"))

(in-package "ROS")
;;//! \htmlinclude Encoder.msg.html


(defclass shoulderexo::Encoder
  :super ros::object
  :slots (_encoder1 _encoder2 ))

(defmethod shoulderexo::Encoder
  (:init
   (&key
    ((:encoder1 __encoder1) 0.0)
    ((:encoder2 __encoder2) 0.0)
    )
   (send-super :init)
   (setq _encoder1 (float __encoder1))
   (setq _encoder2 (float __encoder2))
   self)
  (:encoder1
   (&optional __encoder1)
   (if __encoder1 (setq _encoder1 __encoder1)) _encoder1)
  (:encoder2
   (&optional __encoder2)
   (if __encoder2 (setq _encoder2 __encoder2)) _encoder2)
  (:serialization-length
   ()
   (+
    ;; float32 _encoder1
    4
    ;; float32 _encoder2
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _encoder1
       (sys::poke _encoder1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _encoder2
       (sys::poke _encoder2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _encoder1
     (setq _encoder1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _encoder2
     (setq _encoder2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get shoulderexo::Encoder :md5sum-) "5c2f5cd41268c3b81a9a0b5972ee0639")
(setf (get shoulderexo::Encoder :datatype-) "shoulderexo/Encoder")
(setf (get shoulderexo::Encoder :definition-)
      "float32 encoder1
float32 encoder2

")



(provide :shoulderexo/Encoder "5c2f5cd41268c3b81a9a0b5972ee0639")


