#!/bin/env bash

CENTOS_VERSION="$1"
LIBEVENT_VERSION="$2"
LIBEVENT_MAJOR_VERSION="$(echo $2 | awk 'BEGIN { FS = "." } { print $1 FS $2 }')"
TMUX_VERSION="$3"


(
    curl -OL https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION-stable/libevent-$LIBEVENT_VERSION-stable.tar.gz
    tar -xvzf libevent-$LIBEVENT_VERSION-stable.tar.gz
    cd libevent-$LIBEVENT_VERSION-stable
    ./configure --prefix=/usr/local && make && make install
)
(
    curl -OL https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz
    tar -xvzf tmux-$TMUX_VERSION.tar.gz
    cd tmux-$TMUX_VERSION
    LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local && make && make install
)
(
    mkdir -p /tmp/usr/local/lib
    mkdir -p /tmp/usr/bin
    cp -a /usr/local/lib/libevent-$LIBEVENT_MAJOR_VERSION.so* /tmp/usr/local/lib
    cp /usr/local/bin/tmux /tmp/usr/bin
    cd /tmp
    tar -czvf tmux-centos-$CENTOS_VERSION.tar.gz usr
    cp tmux-centos-$CENTOS_VERSION.tar.gz /tar-folder
)
