FROM ubuntu:20.04

COPY build.sh .
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends cmake curl ca-certificates g++ git libc-dev libssl-dev libz-dev make ninja-build pkgconf python3 xz-utils && \
    sh build.sh && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/x-tools/x86_64-unknown-netbsd/bin
ENV AR_x86_64_unknown_netbsd=x86_64--netbsd-ar
ENV CC_x86_64_unknown_netbsd=x86_64--netbsd-gcc-sysroot
ENV CXX_x86_64_unknown_netbsd=x86_64--netbsd-g++-sysroot
ENV X86_64_UNKNOWN_NETBSD_OPENSSL_INCLUDE_DIR=/x-tools/i386-unknown-netbsd/sysroot/usr/include
ENV X86_64_UNKNOWN_NETBSD_OPENSSL_LIB_DIR=/x-tools/i386-unknown-netbsd/sysroot/usr/lib
