;;;; srfi-28.asd

(cl:in-package :asdf)

(defsystem :srfi-28
  :serial t
  :depends-on (:srfi-23 :srfi-5)
  :components ((:file "package")
               (:file "srfi-28")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-28))))
  (load-system :srfi-28)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-28-internal :srfi-28))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

