(in-package #:ag-ui-backend-protobuf)

;;; Binary AG-UI: JSON dump → google.protobuf.Value (serdes :wkt),
;;; length-prefixed under application/vnd.ag-ui.event+proto.
;;; Accept negotiation lives on make-ag-ui-app — this backend just loads the
;;; WKT codec and claims http-binary.

(defclass protobuf-ag-ui-backend (ag-ui-protocol:ag-ui-backend)
  ((agent :initarg :agent :accessor backend-agent :initform nil)
   (path :initarg :path :accessor backend-path :initform "/")))

(defun make-protobuf-ag-ui-backend (&key agent (path "/"))
  (make-instance 'protobuf-ag-ui-backend :agent agent :path path))

(defun use-protobuf-ag-ui-backend (&rest args &key &allow-other-keys)
  (setf ag-ui-protocol:*ag-ui-backend* (apply #'make-protobuf-ag-ui-backend args)))

(defun %agent (backend)
  (or (backend-agent backend) (ag-ui-protocol:make-ag-ui-agent)))

(defmethod ag-ui-protocol:run-agent ((backend protobuf-ag-ui-backend) input
                                     &key on-event)
  (ag-ui-protocol:run-agent (%agent backend) input :on-event on-event))

(defmethod ag-ui-protocol:get-capabilities ((backend protobuf-ag-ui-backend))
  (ag-ui-protocol:make-agent-capabilities
   :identity (make-instance 'ag-ui-protocol:identity-capabilities
                            :name (ag-ui-protocol:ag-ui-agent-name (%agent backend)))
   :transport (make-instance 'ag-ui-protocol:transport-capabilities
                             :streaming t
                             :http-binary t)))

(defmethod ag-ui-protocol:serve-ag-ui ((backend protobuf-ag-ui-backend)
                                       &key path host port)
  (declare (ignore host port))
  (ag-ui-protocol:make-ag-ui-app
   (%agent backend)
   :path (or path (backend-path backend) "/")
   :event-format :negotiate))

(use-protobuf-ag-ui-backend)
