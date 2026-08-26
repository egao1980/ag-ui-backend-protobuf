(in-package #:ag-ui-backend-protobuf)

;;; Wave-1: protobuf-in-SSE `data:` is JSON UTF-8 octets (protocol :format :protobuf).
;;; Official Event proto is not compiled into cl-protobufs yet — same payload,
;;; different container. Full binary (non-SSE) transport is a non-goal.

(defclass protobuf-ag-ui-backend (ag-ui-protocol:ag-ui-backend)
  ((agent :initarg :agent :accessor backend-agent :initform nil)
   (path :initarg :path :accessor backend-path :initform "/")))

(defun make-protobuf-ag-ui-backend (&key agent (path "/"))
  (make-instance 'protobuf-ag-ui-backend :agent agent :path path))

(defun use-protobuf-ag-ui-backend (&rest args &key &allow-other-keys)
  (setf ag-ui-protocol:*ag-ui-backend* (apply #'make-protobuf-ag-ui-backend args)))

(defmethod ag-ui-protocol:run-agent ((backend protobuf-ag-ui-backend) input
                                     &key on-event)
  (ag-ui-protocol:run-agent
   (or (backend-agent backend) (ag-ui-protocol:make-ag-ui-agent))
   input :on-event on-event))

(defmethod ag-ui-protocol:serve-ag-ui ((backend protobuf-ag-ui-backend)
                                       &key path host port)
  (declare (ignore host port))
  (ag-ui-protocol:make-ag-ui-app
   (or (backend-agent backend) (ag-ui-protocol:make-ag-ui-agent))
   :path (or path (backend-path backend) "/")
   :event-format :protobuf))

(use-protobuf-ag-ui-backend)
