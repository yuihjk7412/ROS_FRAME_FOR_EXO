
(cl:in-package :asdf)

(defsystem "exosystem-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Encoder" :depends-on ("_package_Encoder"))
    (:file "_package_Encoder" :depends-on ("_package"))
    (:file "Limbpos" :depends-on ("_package_Limbpos"))
    (:file "_package_Limbpos" :depends-on ("_package"))
    (:file "Motor_Force" :depends-on ("_package_Motor_Force"))
    (:file "_package_Motor_Force" :depends-on ("_package"))
    (:file "Sysstatus" :depends-on ("_package_Sysstatus"))
    (:file "_package_Sysstatus" :depends-on ("_package"))
    (:file "Torque" :depends-on ("_package_Torque"))
    (:file "_package_Torque" :depends-on ("_package"))
  ))