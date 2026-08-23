(in-package #:ag-ui-backend-protobuf/tests)

(deftest backend-class
  (ok (typep (ag-ui-backend-protobuf:make-protobuf-ag-ui-backend) 'ag-ui-backend-protobuf:protobuf-ag-ui-backend)))
