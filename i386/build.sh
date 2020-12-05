#! /bin/sh

set -e

NETBSD_URL=https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.1

mkdir netbsd
cd netbsd

mkdir -p /x-tools/i386-unknown-netbsd/sysroot

curl $NETBSD_URL/source/sets/src.tgz | tar xzf -
curl $NETBSD_URL/source/sets/gnusrc.tgz | tar xzf -
curl $NETBSD_URL/source/sets/sharesrc.tgz | tar xzf -
curl $NETBSD_URL/source/sets/syssrc.tgz | tar xzf -

curl $NETBSD_URL/i386/binary/sets/base.tgz | tar xzf - -C /x-tools/i386-unknown-netbsd/sysroot ./usr/include ./usr/lib ./lib ./usr/share/mk
curl $NETBSD_URL/i386/binary/sets/comp.tgz | tar xzf - -C /x-tools/i386-unknown-netbsd/sysroot ./usr/include ./usr/lib

cd usr/src

MKUNPRIVED=yes TOOLDIR=/x-tools/i386-unknown-netbsd \
	  MKSHARE=no MKDOC=no MKHTML=no MKINFO=no MKKMOD=no MKLINT=no MKMAN=no MKNLS=no MKPROFILE=no \
	  ./build.sh -j10 -m i386 tools

cd ../..
rm -rf usr

cat > /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-gcc-sysroot <<'EOF'
#!/usr/bin/env bash
exec /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-gcc -march=i586 --sysroot=/x-tools/i386-unknown-netbsd/sysroot "$@"
EOF

cat > /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-g++-sysroot <<'EOF'
#!/usr/bin/env bash
exec /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-g++ -march=i586 --sysroot=/x-tools/i386-unknown-netbsd/sysroot "$@"
EOF

GCC_SHA1=`sha1sum -b /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-gcc | cut -d' ' -f1`
GPP_SHA1=`sha1sum -b /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-g++ | cut -d' ' -f1`

echo "# $GCC_SHA1" >> /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-gcc-sysroot
echo "# $GPP_SHA1" >> /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-g++-sysroot

chmod +x /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-gcc-sysroot
chmod +x /x-tools/i386-unknown-netbsd/bin/i486--netbsdelf-g++-sysroot
