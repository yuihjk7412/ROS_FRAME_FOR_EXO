;; Auto-generated. Do not edit!


(when (boundp 'exosystem::Encoder)
  (if (not (find-package "EXOSYSTEM"))
    (make-package "EXOSYSTEM"))
  (shadow 'Encoder (find-package "EXOSYSTEM")))
(unless (find-package "EXOSYSTEM::ENCODER")
  (make-package "EXOSYSTEM::ENCODER"))

(in-package "ROS")
;;//! \htmlinclude Encoder.msg.html


(defclass exosystem::Encoder
  :super ros::object
  :slots (_encoder1 _encoder2 ))

(defmethod exosystem::Encoder
  (:init
   (&key
    ((:encoder1 __encoder1) 0)
    ((:encoder2 __encoder2) 0)
    )
   (send-super :init)
   (setq _encoder1 (round __encoder1))
   (setq _encoder2 (round __encoder2))
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
    ;; uint16 _encoder1
    2
    ;; uint16 _encoder2
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _encoder1
       (write-word _encoder1 s)
     ;; uint16 _encoder2
       (write-word _encoder2 s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _encoder1
     (setq _encoder1 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint16 _encoder2
     (setq _encoder2 (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(setf (get exosystem::Encoder :md5sum-) "cd83c38535a6ecc48fe19927ddfdf036")
(setf (get exosystem::Encoder :datatype-) "exosystem/Encoder")
(setf (get exosystem::Encoder :definition-)
      "uint16 encoder1
uint16 encoder2

")



(provide :exosystem/Encoder "cd83c38535a6ecc48fe19927ddfdf036")


