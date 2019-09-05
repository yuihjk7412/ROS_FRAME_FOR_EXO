;; Auto-generated. Do not edit!


(when (boundp 'exosystem::Sysstatus)
  (if (not (find-package "EXOSYSTEM"))
    (make-package "EXOSYSTEM"))
  (shadow 'Sysstatus (find-package "EXOSYSTEM")))
(unless (find-package "EXOSYSTEM::SYSSTATUS")
  (make-package "EXOSYSTEM::SYSSTATUS"))

(in-package "ROS")
;;//! \htmlinclude Sysstatus.msg.html


(defclass exosystem::Sysstatus
  :super ros::object
  :slots (_theta_m1 _theta_l1 _delta_theta_r1 _Trr_ad ))

(defmethod exosystem::Sysstatus
  (:init
   (&key
    ((:theta_m1 __theta_m1) 0.0)
    ((:theta_l1 __theta_l1) 0.0)
    ((:delta_theta_r1 __delta_theta_r1) 0.0)
    ((:Trr_ad __Trr_ad) 0.0)
    )
   (send-super :init)
   (setq _theta_m1 (float __theta_m1))
   (setq _theta_l1 (float __theta_l1))
   (setq _delta_theta_r1 (float __delta_theta_r1))
   (setq _Trr_ad (float __Trr_ad))
   self)
  (:theta_m1
   (&optional __theta_m1)
   (if __theta_m1 (setq _theta_m1 __theta_m1)) _theta_m1)
  (:theta_l1
   (&optional __theta_l1)
   (if __theta_l1 (setq _theta_l1 __theta_l1)) _theta_l1)
  (:delta_theta_r1
   (&optional __delta_theta_r1)
   (if __delta_theta_r1 (setq _delta_theta_r1 __delta_theta_r1)) _delta_theta_r1)
  (:Trr_ad
   (&optional __Trr_ad)
   (if __Trr_ad (setq _Trr_ad __Trr_ad)) _Trr_ad)
  (:serialization-length
   ()
   (+
    ;; float32 _theta_m1
    4
    ;; float32 _theta_l1
    4
    ;; float32 _delta_theta_r1
    4
    ;; float32 _Trr_ad
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _theta_m1
       (sys::poke _theta_m1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _theta_l1
       (sys::poke _theta_l1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _delta_theta_r1
       (sys::poke _delta_theta_r1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Trr_ad
       (sys::poke _Trr_ad (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _theta_m1
     (setq _theta_m1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _theta_l1
     (setq _theta_l1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _delta_theta_r1
     (setq _delta_theta_r1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Trr_ad
     (setq _Trr_ad (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get exosystem::Sysstatus :md5sum-) "d950118da79c144be1aca147a9c90400")
(setf (get exosystem::Sysstatus :datatype-) "exosystem/Sysstatus")
(setf (get exosystem::Sysstatus :definition-)
      "float32 theta_m1
float32 theta_l1
float32 delta_theta_r1
float32 Trr_ad
")



(provide :exosystem/Sysstatus "d950118da79c144be1aca147a9c90400")


