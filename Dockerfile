FROM ubuntu:trusty

RUN apt-get update && \
    apt-get install -yy \
      build-essential \
      autoconf \
      automake \
      libpcre3-dev \
      libevent-dev \
      pkg-config \
      zlib1g-dev \
      curl

ARG MEMTIER_VERSION

RUN curl -L https://github.com/RedisLabs/memtier_benchmark/archive/${MEMTIER_VERSION}.tar.gz  -o /tmp/memtier.tar.gz && \
    tar -C /tmp -xzvf /tmp/memtier.tar.gz && \
    cd /tmp/memtier_benchmark-${MEMTIER_VERSION} && \
    autoreconf -ivf && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/memtier_benchmark-${MEMTIER_VERSION}
