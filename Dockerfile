FROM ubuntu:18.04

COPY build.sh .
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates g++ git libc-dev libz-dev && \
    sh build.sh && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/x-tools/i386-unknown-netbsd/bin
ENV HOSTS=i386-unknown-netbsd
