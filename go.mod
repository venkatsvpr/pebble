module github.com/cockroachdb/pebble

go 1.18

replace github.com/codahale/hdrhistogram => github.com/HdrHistogram/hdrhistogram-go v0.9.0

require (
	github.com/DataDog/zstd v1.5.2
	github.com/cespare/xxhash/v2 v2.1.2
	github.com/cockroachdb/errors v1.9.0
	github.com/cockroachdb/redact v1.1.3
	github.com/codahale/hdrhistogram v1.1.2
	github.com/ghemawat/stream v0.0.0-20171120220530-696b145b53b9
	github.com/golang/snappy v0.0.4
	github.com/klauspost/compress v1.15.3
	github.com/kr/pretty v0.3.0
	github.com/outcaste-io/badger/v3 v3.2202.0
	github.com/pmezard/go-difflib v1.0.0
	github.com/spf13/cobra v1.4.0
	github.com/stretchr/testify v1.7.1
	golang.org/x/exp v0.0.0-20220428152302-39d4317da171
	golang.org/x/sync v0.0.0-20210220032951-036812b2e83c
	golang.org/x/sys v0.0.0-20220503163025-988cb79eb6c6
)

require (
	github.com/cespare/xxhash v1.1.0 // indirect
	github.com/cockroachdb/logtags v0.0.0-20211118104740-dabe8e521a4f // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/dustin/go-humanize v1.0.0 // indirect
	github.com/getsentry/sentry-go v0.13.0 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b // indirect
	github.com/golang/groupcache v0.0.0-20190702054246-869f871628b6 // indirect
	github.com/golang/protobuf v1.5.2 // indirect
	github.com/google/flatbuffers v1.12.1 // indirect
	github.com/inconshreveable/mousetrap v1.0.0 // indirect
	github.com/kr/text v0.2.0 // indirect
	github.com/outcaste-io/ristretto v0.2.0 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/rogpeppe/go-internal v1.8.1 // indirect
	github.com/spf13/pflag v1.0.5 // indirect
	go.opencensus.io v0.22.5 // indirect
	golang.org/x/net v0.0.0-20211008194852-3b03d305991f // indirect
	google.golang.org/protobuf v1.26.0 // indirect
	gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b // indirect
)
