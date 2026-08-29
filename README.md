# ag-ui-backend-protobuf

AG-UI binary transport: JSON event tables as `google.protobuf.Value` (serdes
`:wkt`), length-prefixed under `application/vnd.ag-ui.event+proto`.

This is **not** the official `Event` oneof. Unknown types survive because the
payload is the dump table. `make-ag-ui-app` still serves SSE when `Accept` does
not name the proto media type.

```lisp
(asdf:load-system "ag-ui-backend-protobuf")
(ag-ui-protocol:serve-ag-ui
 (ag-ui-backend-protobuf:make-protobuf-ag-ui-backend)
 :path "/")
```

Tracks [cl-stack#187](https://github.com/egao1980/cl-stack/issues/187).

## License

MIT
