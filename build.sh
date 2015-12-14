#!/bin/bash
BRANCH=discodns
VERSION=0.0.3

docker run -i -v ${PWD}:/go/src/github.com/duedil-ltd/discodns sorenmat/golang-fpm-1.5.2 sh << COMMANDS
#!/bin/bash
export GOPATH=/go
cd /go/src/github.com/duedil-ltd/discodns
go get -v
echo "Buliding"
go build
fpm -s dir -t deb  --description "Tradeshift DNS server" -n discodns -v ${VERSION} discodns=/usr/bin/

