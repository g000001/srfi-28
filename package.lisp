;;;; package.lisp

(cl:in-package :cl-user)


(defpackage "https://github.com/g000001/srfi-28"
  (:use)
  (:export :format))


(defpackage "https://github.com/g000001/srfi-28#internals"
  (:use "https://github.com/g000001/srfi-28"
        :cl
        :fiveam)
  (:shadowing-import-from "https://github.com/g000001/srfi-28"
                          :format)
  (:shadowing-import-from :srfi-23
                          :error)
  (:shadowing-import-from :srfi-5
                          :let)
  (:shadow :loop))


;;; *EOF*
