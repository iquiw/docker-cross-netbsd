FROM ubuntu:18.04

COPY build.sh .
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates g++ git libc-dev libz-dev && \
    sh build.sh && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/x-tools/x86_64-unknown-netbsd/bin
ENV HOSTS=x86_64-unknown-netbsd
