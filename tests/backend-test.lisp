(in-package #:ag-ui-backend-protobuf/tests)

(deftest backend-class
  (ok (typep (ag-ui-backend-protobuf:make-protobuf-ag-ui-backend)
             'ag-ui-backend-protobuf:protobuf-ag-ui-backend)))

(deftest claims-http-binary
  (let ((caps (ag-ui-protocol:get-capabilities
               (ag-ui-backend-protobuf:make-protobuf-ag-ui-backend
                :agent (ag-ui-protocol:make-ag-ui-agent :name "pb")))))
    (ok (equal "pb" (ag-ui-protocol:identity-name
                     (ag-ui-protocol:capabilities-identity caps))))
    (ok (ag-ui-protocol:transport-streaming-p
         (ag-ui-protocol:capabilities-transport caps)))
    (ok (ag-ui-protocol:transport-http-binary-p
         (ag-ui-protocol:capabilities-transport caps)))))

(deftest protobuf-app-roundtrip
  (let* ((backend (ag-ui-backend-protobuf:make-protobuf-ag-ui-backend
                   :agent (ag-ui-protocol:make-ag-ui-agent)))
         (app (ag-ui-protocol:serve-ag-ui backend :path "/"))
         (headers (let ((h (make-hash-table :test 'equal)))
                    (setf (gethash "accept" h) "application/vnd.ag-ui.event+proto")
                    h))
         (body (ag-ui-protocol:encode-json
                (ag-ui-protocol:encode-run-agent-input
                 (ag-ui-protocol:make-run-agent-input
                  :thread-id "t" :run-id "r"
                  :messages (list (ag-ui-protocol:make-ag-ui-message
                                   :role "user" :content "pb"))))))
         (res (funcall app (list :request-method :post
                                 :path-info "/"
                                 :headers headers
                                 :raw-body body)))
         (events (ag-ui-protocol:decode-ag-ui-framed (first (third res)))))
    (ok (= 200 (first res)))
    (ok (search "vnd.ag-ui.event+proto" (getf (second res) :content-type)))
    (ok (equal "pb" (ag-ui-protocol:text-message-delta (third events))))))
