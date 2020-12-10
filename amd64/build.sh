#! /bin/sh

set -e

NETBSD_URL=https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.1

mkdir netbsd
cd netbsd

mkdir -p /x-tools/x86_64-unknown-netbsd/sysroot

curl $NETBSD_URL/source/sets/src.tgz | tar xzf -
curl $NETBSD_URL/source/sets/gnusrc.tgz | tar xzf -
curl $NETBSD_URL/source/sets/sharesrc.tgz | tar xzf -
curl $NETBSD_URL/source/sets/syssrc.tgz | tar xzf -

curl $NETBSD_URL/amd64/binary/sets/base.tar.xz | tar xJf - -C /x-tools/x86_64-unknown-netbsd/sysroot ./usr/include ./usr/lib ./lib ./usr/share/mk
curl $NETBSD_URL/amd64/binary/sets/comp.tar.xz | tar xJf - -C /x-tools/x86_64-unknown-netbsd/sysroot ./usr/include ./usr/lib

cd usr/src

MKUNPRIVED=yes TOOLDIR=/x-tools/x86_64-unknown-netbsd \
	  MKSHARE=no MKDOC=no MKHTML=no MKINFO=no MKKMOD=no MKLINT=no MKMAN=no MKNLS=no MKPROFILE=no \
	  ./build.sh -j10 -m amd64 tools

cd ../..
rm -rf usr

cat > /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-gcc-sysroot <<'EOF'
#!/usr/bin/env bash
exec /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-gcc --sysroot=/x-tools/x86_64-unknown-netbsd/sysroot "$@"
EOF

cat > /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-g++-sysroot <<'EOF'
#!/usr/bin/env bash
exec /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-g++ --sysroot=/x-tools/x86_64-unknown-netbsd/sysroot "$@"
EOF

GCC_SHA1=`sha1sum -b /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-gcc | cut -d' ' -f1`
GPP_SHA1=`sha1sum -b /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-g++ | cut -d' ' -f1`

echo "# $GCC_SHA1" >> /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-gcc-sysroot
echo "# $GPP_SHA1" >> /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-g++-sysroot

chmod +x /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-gcc-sysroot
chmod +x /x-tools/x86_64-unknown-netbsd/bin/x86_64--netbsd-g++-sysroot
