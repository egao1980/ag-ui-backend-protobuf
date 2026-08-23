(defsystem "ag-ui-backend-protobuf"
  :version "0.1.0"
  :description "protobuf transport backend for ag-ui-protocol"
  :author "egao1980"
  :license "MIT"
  :depends-on ("ag-ui-protocol" "protobuf-protocol" "sse-protocol")
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
