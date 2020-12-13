FROM ubuntu:20.04

COPY build.sh .
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends cmake curl ca-certificates g++ git libc-dev libssl-dev libz-dev make ninja-build pkgconf python3 xz-utils && \
    sh build.sh && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/x-tools/i386-unknown-netbsd/bin
ENV AR_i686_unknown_netbsd=i486--netbsdelf-ar
ENV CC_i686_unknown_netbsd=i486--netbsdelf-gcc-sysroot
ENV CXX_i686_unknown_netbsd=i486--netbsdelf-g++-sysroot
ENV I686_UNKNOWN_NETBSD_OPENSSL_INCLUDE_DIR=/x-tools/i386-unknown-netbsd/sysroot/usr/include
ENV I686_UNKNOWN_NETBSD_OPENSSL_LIB_DIR=/x-tools/i386-unknown-netbsd/sysroot/usr/lib
