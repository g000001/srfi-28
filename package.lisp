;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-28
  (:use)
  (:export :format))

(defpackage :srfi-28-internal
  (:use :cl :fiveam)
  (:shadowing-import-from :srfi-28
                          :format)
  (:shadowing-import-from :srfi-23
                          :error)
  (:shadowing-import-from :srfi-5
                          :let)
  (:shadow :loop))

