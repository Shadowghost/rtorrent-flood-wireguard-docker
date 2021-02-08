#!/bin/sh

find ${HOME} -name rtorrent.lock -print0 | xargs -0 rm

flood --host=0.0.0.0 --rtsocket /tmp/rtorrent.sock --rundir /flood --rtorrent
