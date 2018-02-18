FROM ubuntu:16.04

RUN mkdir /opt/proxygen
WORKDIR /opt/proxygen

ADD folly folly
ADD proxygen proxygen
ADD wangle wangle

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    g++ \
    flex \
    bison \
    libkrb5-dev \
    libsasl2-dev \
    libnuma-dev \
    pkg-config \
    libssl-dev \
    libcap-dev \
    gperf \
    autoconf-archive \
    libevent-dev \
    libtool \
    libboost-all-dev \
    libjemalloc-dev \
    libsnappy-dev \
    wget \
    unzip \
    libgoogle-glog-dev \
    libgflags-dev \
    libdouble-conversion-dev

RUN mkdir /opt/afl && cd /opt/afl && wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz && tar xvzf afl-latest.tgz && cd afl-2.52b && make

RUN cd folly/folly && autoreconf --install && CXX=/opt/afl/afl-2.52b/afl-g++ ./configure && make && make install

RUN cd wangle/wangle && cmake . && make && make install

RUN cd proxygen/proxygen && autoreconf -ivf && CXX=/opt/afl/afl-2.52b/afl-g++ ./configure && make && make install

ADD cases cases

RUN chmod u+x cases/*/run_afl.sh

RUN LD_LIBRARY_PATH=/usr/local/lib /opt/afl/afl-2.52b/afl-g++ -std=c++14 -o cases/httptime/test cases/httptime/test.cpp -lproxygenlib -lfolly -lglog -lgflags

