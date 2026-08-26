(in-package #:ag-ui-backend-protobuf/tests)

(deftest backend-class
  (ok (typep (ag-ui-backend-protobuf:make-protobuf-ag-ui-backend)
             'ag-ui-backend-protobuf:protobuf-ag-ui-backend)))

(deftest protobuf-app-roundtrip
  (let* ((backend (ag-ui-backend-protobuf:make-protobuf-ag-ui-backend
                   :agent (ag-ui-protocol:make-ag-ui-agent)))
         (app (ag-ui-protocol:serve-ag-ui backend :path "/"))
         (body (ag-ui-protocol:encode-json
                (ag-ui-protocol:encode-run-agent-input
                 (ag-ui-protocol:make-run-agent-input
                  :thread-id "t" :run-id "r"
                  :messages (list (ag-ui-protocol:make-ag-ui-message
                                   :role "user" :content "pb"))))))
         (res (funcall app (list :request-method :post
                                 :path-info "/"
                                 :raw-body body)))
         (events (ag-ui-protocol:decode-ag-ui-sse-stream
                  (apply #'concatenate 'string (third res))
                  :format :protobuf)))
    (ok (= 200 (first res)))
    (ok (equal "pb" (ag-ui-protocol:text-message-delta (third events))))))
