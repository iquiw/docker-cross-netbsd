#! /bin/sh

set -e

NETBSD_URL=https://cdn.netbsd.org/pub/NetBSD/NetBSD-7.1.2

mkdir netbsd
cd netbsd

mkdir -p /x-tools/i386-unknown-netbsd/sysroot

curl $NETBSD_URL/source/sets/src.tgz | tar xzf -
curl $NETBSD_URL/source/sets/gnusrc.tgz | tar xzf -
curl $NETBSD_URL/source/sets/sharesrc.tgz | tar xzf -
curl $NETBSD_URL/source/sets/syssrc.tgz | tar xzf -

curl $NETBSD_URL/i386/binary/sets/base.tgz | tar xzf - -C /x-tools/i386-unknown-netbsd/sysroot ./usr/include ./usr/lib ./lib
curl $NETBSD_URL/i386/binary/sets/comp.tgz | tar xzf - -C /x-tools/i386-unknown-netbsd/sysroot ./usr/include ./usr/lib

cd usr/src

MKUNPRIVED=yes TOOLDIR=/x-tools/i386-unknown-netbsd \
	  MKSHARE=no MKDOC=no MKHTML=no MKINFO=no MKKMOD=no MKLINT=no MKMAN=no MKNLS=no MKPROFILE=no \
	  ./build.sh -j10 -m i386 tools

cd ../..
rm -rf usr
