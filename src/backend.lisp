(in-package #:ag-ui-backend-protobuf)

(defclass protobuf-ag-ui-backend (ag-ui-protocol:ag-ui-backend) ())

(defun make-protobuf-ag-ui-backend ()
  (make-instance 'protobuf-ag-ui-backend))

(defun use-protobuf-ag-ui-backend ()
  (setf ag-ui-protocol:*ag-ui-backend* (make-protobuf-ag-ui-backend)))
