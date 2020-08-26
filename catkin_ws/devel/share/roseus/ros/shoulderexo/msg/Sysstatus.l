;; Auto-generated. Do not edit!


(when (boundp 'shoulderexo::Sysstatus)
  (if (not (find-package "SHOULDEREXO"))
    (make-package "SHOULDEREXO"))
  (shadow 'Sysstatus (find-package "SHOULDEREXO")))
(unless (find-package "SHOULDEREXO::SYSSTATUS")
  (make-package "SHOULDEREXO::SYSSTATUS"))

(in-package "ROS")
;;//! \htmlinclude Sysstatus.msg.html


(defclass shoulderexo::Sysstatus
  :super ros::object
  :slots (_record_flag _theta_m1 _theta_l1 _delta_theta_r1 _Trr_ad _theta_m2 _theta_l2 _delta_theta_r2 _Trr_cf ))

(defmethod shoulderexo::Sysstatus
  (:init
   (&key
    ((:record_flag __record_flag) 0)
    ((:theta_m1 __theta_m1) 0.0)
    ((:theta_l1 __theta_l1) 0.0)
    ((:delta_theta_r1 __delta_theta_r1) 0.0)
    ((:Trr_ad __Trr_ad) 0.0)
    ((:theta_m2 __theta_m2) 0.0)
    ((:theta_l2 __theta_l2) 0.0)
    ((:delta_theta_r2 __delta_theta_r2) 0.0)
    ((:Trr_cf __Trr_cf) 0.0)
    )
   (send-super :init)
   (setq _record_flag (round __record_flag))
   (setq _theta_m1 (float __theta_m1))
   (setq _theta_l1 (float __theta_l1))
   (setq _delta_theta_r1 (float __delta_theta_r1))
   (setq _Trr_ad (float __Trr_ad))
   (setq _theta_m2 (float __theta_m2))
   (setq _theta_l2 (float __theta_l2))
   (setq _delta_theta_r2 (float __delta_theta_r2))
   (setq _Trr_cf (float __Trr_cf))
   self)
  (:record_flag
   (&optional __record_flag)
   (if __record_flag (setq _record_flag __record_flag)) _record_flag)
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
  (:theta_m2
   (&optional __theta_m2)
   (if __theta_m2 (setq _theta_m2 __theta_m2)) _theta_m2)
  (:theta_l2
   (&optional __theta_l2)
   (if __theta_l2 (setq _theta_l2 __theta_l2)) _theta_l2)
  (:delta_theta_r2
   (&optional __delta_theta_r2)
   (if __delta_theta_r2 (setq _delta_theta_r2 __delta_theta_r2)) _delta_theta_r2)
  (:Trr_cf
   (&optional __Trr_cf)
   (if __Trr_cf (setq _Trr_cf __Trr_cf)) _Trr_cf)
  (:serialization-length
   ()
   (+
    ;; int16 _record_flag
    2
    ;; float32 _theta_m1
    4
    ;; float32 _theta_l1
    4
    ;; float32 _delta_theta_r1
    4
    ;; float32 _Trr_ad
    4
    ;; float32 _theta_m2
    4
    ;; float32 _theta_l2
    4
    ;; float32 _delta_theta_r2
    4
    ;; float32 _Trr_cf
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16 _record_flag
       (write-word _record_flag s)
     ;; float32 _theta_m1
       (sys::poke _theta_m1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _theta_l1
       (sys::poke _theta_l1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _delta_theta_r1
       (sys::poke _delta_theta_r1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Trr_ad
       (sys::poke _Trr_ad (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _theta_m2
       (sys::poke _theta_m2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _theta_l2
       (sys::poke _theta_l2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _delta_theta_r2
       (sys::poke _delta_theta_r2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _Trr_cf
       (sys::poke _Trr_cf (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16 _record_flag
     (setq _record_flag (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float32 _theta_m1
     (setq _theta_m1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _theta_l1
     (setq _theta_l1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _delta_theta_r1
     (setq _delta_theta_r1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Trr_ad
     (setq _Trr_ad (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _theta_m2
     (setq _theta_m2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _theta_l2
     (setq _theta_l2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _delta_theta_r2
     (setq _delta_theta_r2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _Trr_cf
     (setq _Trr_cf (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get shoulderexo::Sysstatus :md5sum-) "a24a13feba27c82997977933cd4b8af4")
(setf (get shoulderexo::Sysstatus :datatype-) "shoulderexo/Sysstatus")
(setf (get shoulderexo::Sysstatus :definition-)
      "int16 record_flag
float32 theta_m1
float32 theta_l1
float32 delta_theta_r1
float32 Trr_ad
float32 theta_m2
float32 theta_l2
float32 delta_theta_r2
float32 Trr_cf
")



(provide :shoulderexo/Sysstatus "a24a13feba27c82997977933cd4b8af4")


