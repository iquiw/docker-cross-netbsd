FROM ubuntu:16.04

ENV NETBSD_URL=https://cdn.netbsd.org/pub/NetBSD/NetBSD-7.1.2

RUN mkdir netbsd && cd netbsd && \
    mkdir -p /x-tools/i386-unknown-netbsd/sysroot && \
    # Originally from ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-$BSD/source/sets/*.tgz
    curl $NETBSD_URL/source/sets/src.tgz | tar xzf - && \
    curl $NETBSD_URL/source/sets/gnusrc.tgz | tar xzf - && \
    curl $NETBSD_URL/source/sets/sharesrc.tgz | tar xzf - && \
    curl $NETBSD_URL/source/sets/syssrc.tgz | tar xzf - && \
    \
    curl $URL/i386/binary/sets/base.tgz | \
         tar xzf - -C /x-tools/i386-unknown-netbsd/sysroot ./usr/include ./usr/lib ./lib && \
    curl $URL/i386/binary/sets/comp.tgz | \
         tar xzf - -C /x-tools/i386-unknown-netbsd/sysroot ./usr/include ./usr/lib && \
    \
    cd usr/src && \
    \
    MKUNPRIVED=yes TOOLDIR=/x-tools/i386-unknown-netbsd \
    MKSHARE=no MKDOC=no MKHTML=no MKINFO=no MKKMOD=no MKLINT=no MKMAN=no MKNLS=no MKPROFILE=no \
    ./build.sh -j10 -m i386 tools && \
    \
    cd ../.. && \
    rm -rf usr

USER root

ENV PATH=$PATH:/x-tools/i386-unknown-netbsd/bin

ENV \
    AR_i386_unknown_netbsd=i386--netbsd-ar \
    CC_i386_unknown_netbsd=i386--netbsd-gcc-sysroot \
    CXX_i386_unknown_netbsd=i386--netbsd-g++-sysroot

ENV HOSTS=i386-unknown-netbsd
