;; Auto-generated. Do not edit!


(when (boundp 'shoulderexo::Limbpos)
  (if (not (find-package "SHOULDEREXO"))
    (make-package "SHOULDEREXO"))
  (shadow 'Limbpos (find-package "SHOULDEREXO")))
(unless (find-package "SHOULDEREXO::LIMBPOS")
  (make-package "SHOULDEREXO::LIMBPOS"))

(in-package "ROS")
;;//! \htmlinclude Limbpos.msg.html


(defclass shoulderexo::Limbpos
  :super ros::object
  :slots (_xtheta _ytheta _ztheta ))

(defmethod shoulderexo::Limbpos
  (:init
   (&key
    ((:xtheta __xtheta) 0.0)
    ((:ytheta __ytheta) 0.0)
    ((:ztheta __ztheta) 0.0)
    )
   (send-super :init)
   (setq _xtheta (float __xtheta))
   (setq _ytheta (float __ytheta))
   (setq _ztheta (float __ztheta))
   self)
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
   ;; float32 _xtheta
     (setq _xtheta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ytheta
     (setq _ytheta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ztheta
     (setq _ztheta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get shoulderexo::Limbpos :md5sum-) "397010c589a871e910a38f804cb36983")
(setf (get shoulderexo::Limbpos :datatype-) "shoulderexo/Limbpos")
(setf (get shoulderexo::Limbpos :definition-)
      "float32 xtheta
float32 ytheta
float32 ztheta

")



(provide :shoulderexo/Limbpos "397010c589a871e910a38f804cb36983")


