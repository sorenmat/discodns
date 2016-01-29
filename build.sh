#!/bin/bash
BRANCH=ts_fix
VERSION=0.0.7
mkdir artifacts
docker run -i -v ${PWD}/artifacts:/artifacts -v ${PWD}/:/host_root sorenmat/golang-fpm-1.5.2 sh << COMMANDS
#!/bin/bash

go get -v github.com/sorenmat/discodns
cd src/github.com/sorenmat/discodns
git checkout ${BRANCH}
go build

mkdir -p /discodns
mkdir -p /discodns/usr/sbin
mkdir -p /discodns/etc/init
mkdir -p /discodns/etc/default
cp discodns /discodns/usr/sbin
cp /host_root/etc/init/discodns.conf /discodns/etc/init/discodns.conf
chmod 755 /discodns/usr/sbin/discodns

fpm \
-s dir \
-t deb  \
-v ${VERSION} \
--name discodns \
--description "disco dns - dns server with rest api" \
--prefix "/" \
--before-install /host_root/pre-install.sh \
--after-install /host_root/post-install.sh \
--deb-user root \
--deb-group root \
-C /discodns .

cp discodns*.deb /artifacts
