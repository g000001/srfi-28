;;;; srfi-28.lisp

(cl:in-package :srfi-28-internal)

(def-suite srfi-28)

(in-suite srfi-28)

(defun format (format-string &rest objects)
  (let ((buffer (make-string-output-stream)))
    (let loop ((format-list (coerce format-string 'list))
               (objects objects))
         (cond ((null format-list) (get-output-stream-string buffer))
               ((char= (car format-list) #\~)
                (if (null (cdr format-list))
                    (error 'format "Incomplete escape sequence")
                    (case (cadr format-list)
                      ((#\a)
                         (if (null objects)
                             (error 'format "No value for escape sequence")
                             (progn
                               (princ (car objects) buffer)
                               (loop (cddr format-list) (cdr objects)))))
                      ((#\s)
                         (if (null objects)
                             (error 'format "No value for escape sequence")
                             (progn
                               (write (car objects) :stream buffer)
                               (loop (cddr format-list) (cdr objects)))))
                      ((#\%)
                         (terpri buffer)
                         (loop (cddr format-list) objects))
                      ((#\~)
                         (write-char #\~ buffer)
                         (loop (cddr format-list) objects))
                      (otherwise
                         (error 'format "Unrecognized escape sequence")))))
               (:else (write-char (car format-list) buffer)
                (loop (cdr format-list) objects))))))

(test format
  (is (string= (format "foo")
               "foo"))
  (is (string= (format "foo~%")
               "foo
"))
  (is (string= (format "foo~a" "FOO")
               "fooFOO"))
  (is (string= (format "foo~s" "FOO")
               "foo\"FOO\""))
  (is (string= (format "foo~~")
               "foo~"))
  (is (string= (format "foo~a~a~a~a~a" 1 2 3 4 5)
               "foo12345"))
  (is (string= (format "foo~a~s~a~s~a" 1 2 3 4 5)
               "foo12345"))
  (signals (cl:error) (format "foo~x"))
  (signals (cl:error) (format "foo~"))
  (signals (cl:error) (format "foo~a"))
  (signals (cl:error) (format "foo~s")))









