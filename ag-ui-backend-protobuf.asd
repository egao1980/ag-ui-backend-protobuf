(defsystem "ag-ui-backend-protobuf"
  :version "0.3.0"
  :description "WKT protobuf backend for ag-ui-protocol (JSON → google.protobuf.Value)"
  :author "egao1980"
  :license "MIT"
  :depends-on ("ag-ui-protocol" "protobuf-protocol" "protobuf-backend-cl-protobufs"
               "serdes-protocol")
  :serial t
  :pathname "src"
  :components ((:file "package")
               (:file "backend"))
  :in-order-to ((test-op (test-op "ag-ui-backend-protobuf/tests"))))

(defsystem "ag-ui-backend-protobuf/tests"
  :depends-on ("ag-ui-backend-protobuf" "rove")
  :pathname "tests"
  :serial t
  :components ((:file "package")
               (:file "backend-test"))
  :perform (test-op (o c)
             (unless (symbol-call :rove :run c)
               (error "tests failed for ~A" (component-name c)))))
