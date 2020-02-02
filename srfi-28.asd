;;;; srfi-28.asd

(cl:in-package :asdf)


(defsystem :srfi-28
  :version "20200203"
  :description "SRFI 28 for CL: Basic Format Strings"
  :long-description "SRFI 28 for CL: Basic Format Strings
https://srfi.schemers.org/srfi-28"
  :author "Scott G. Miller"
  :maintainer "CHIBA Masaomi"
  :license "MIT"
  :serial t
  :depends-on (:srfi-23 :srfi-5)
  :components ((:file "package")
               (:file "srfi-28")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-28))))
  (let ((name "https://github.com/g000001/srfi-28")
        (nickname :srfi-28))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-28))))
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ "https://github.com/g000001/srfi-28#internals" :srfi-28))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))


;;; *EOF*
