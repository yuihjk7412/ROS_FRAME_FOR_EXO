
(cl:in-package :asdf)

(defsystem "exosystem-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Encoder" :depends-on ("_package_Encoder"))
    (:file "_package_Encoder" :depends-on ("_package"))
    (:file "Limbpos" :depends-on ("_package_Limbpos"))
    (:file "_package_Limbpos" :depends-on ("_package"))
  ))