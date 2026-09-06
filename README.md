# ag-ui-backend-protobuf

AG-UI binary transport. Loading this system registers both codecs; `make-ag-ui-app`
negotiates them honestly:

| Accept | Codec |
|--------|--------|
| `application/vnd.ag-ui.event+proto` | JSON dump → `google.protobuf.Value` (WKT) |
| `application/vnd.ag-ui.event+oneof` | official `@ag-ui/proto` Event oneof |
| otherwise | SSE JSON |

WKT keeps the existing media type. Official oneof uses a distinct type because
the spec's `+proto` name already meant WKT here — do not silently replace it.

HTTP binary is a Clack response function that writes length-prefixed octet
frames (not a princ'd body list).

```lisp
(asdf:load-system "ag-ui-backend-protobuf")
(ag-ui-protocol:serve-ag-ui
 (ag-ui-backend-protobuf:make-protobuf-ag-ui-backend)
 :path "/")
```

Tracks [cl-stack#187](https://github.com/egao1980/cl-stack/issues/187).

## License

MIT
