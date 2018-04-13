FROM ubuntu:16.04

COPY build.sh .
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates g++ libc-dev libz-dev && \

USER root
    sh build.sh && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/x-tools/i386-unknown-netbsd/bin

ENV \
    AR_i386_unknown_netbsd=i386--netbsd-ar \
    CC_i386_unknown_netbsd=i386--netbsd-gcc-sysroot \
    CXX_i386_unknown_netbsd=i386--netbsd-g++-sysroot

ENV HOSTS=i386-unknown-netbsd
