# ag-ui-backend-protobuf

AG-UI transport B: protobuf payloads on SSE (`data:`).

Wave-1: `:format :protobuf` is **JSON UTF-8 octets** in SSE `data:` — the official
AG-UI `Event` proto is not compiled into cl-protobufs yet. Same events as
`ag-ui-backend-sse`; different container. Full binary (non-SSE) is a non-goal.

```lisp
(asdf:load-system "ag-ui-backend-protobuf")
(ag-ui-protocol:serve-ag-ui
 (ag-ui-backend-protobuf:make-protobuf-ag-ui-backend)
 :path "/")
```

Tracks [cl-stack#187](https://github.com/egao1980/cl-stack/issues/187).

## License

MIT
