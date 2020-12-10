FROM ubuntu:20.04

COPY build.sh .
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends cmake curl ca-certificates g++ git libc-dev libssl-dev libz-dev make ninja-build pkgconf python3 && \
    sh build.sh && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/x-tools/x86_64-unknown-netbsd/bin
ENV HOSTS=x86_64-unknown-netbsd
ENV AR_x86_64_unknown_netbsd=x86_64--netbsd-ar
ENV CC_x86_64_unknown_netbsd=x86_64--netbsd-gcc-sysroot
ENV CXX_x86_64_unknown_netbsd=x86_64--netbsd-g++-sysroot
