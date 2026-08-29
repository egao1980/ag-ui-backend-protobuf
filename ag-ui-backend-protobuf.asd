(defsystem "ag-ui-backend-protobuf"
  :version "0.3.0"
  :description "WKT protobuf backend for ag-ui-protocol (JSON → google.protobuf.Value)"
  :author "egao1980"
  :license "MIT"
  :depends-on ((:version "ag-ui-protocol" "0.3.0")
               (:version "protobuf-protocol" "0.2.0")
               (:version "protobuf-backend-cl-protobufs" "0.2.0")
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
