#! /bin/sh

set -e

NETBSD_URL=https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0

mkdir netbsd
cd netbsd

mkdir -p /x-tools/x86_64-unknown-netbsd/sysroot

curl $NETBSD_URL/source/sets/src.tgz | tar xzf -
curl $NETBSD_URL/source/sets/gnusrc.tgz | tar xzf -
curl $NETBSD_URL/source/sets/sharesrc.tgz | tar xzf -
curl $NETBSD_URL/source/sets/syssrc.tgz | tar xzf -

curl $NETBSD_URL/amd64/binary/sets/base.tgz | tar xzf - -C /x-tools/x86_64-unknown-netbsd/sysroot ./usr/include ./usr/lib ./lib ./usr/share/mk
curl $NETBSD_URL/amd64/binary/sets/comp.tgz | tar xzf - -C /x-tools/x86_64-unknown-netbsd/sysroot ./usr/include ./usr/lib

cd usr/src

MKUNPRIVED=yes TOOLDIR=/x-tools/x86_64-unknown-netbsd \
	  MKSHARE=no MKDOC=no MKHTML=no MKINFO=no MKKMOD=no MKLINT=no MKMAN=no MKNLS=no MKPROFILE=no \
	  ./build.sh -j10 -m amd64 tools

cd ../..
rm -rf usr
