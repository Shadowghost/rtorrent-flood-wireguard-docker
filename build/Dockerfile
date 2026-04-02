# Arguments
ARG FLOOD_VERSION=4.13.0
ARG RTORRENT_VERSION=v0.16.8
ARG LIBTORRENT_VERSION=v0.16.8

# Build rtorrent
FROM docker.io/alpine:3.23 AS build

ARG RTORRENT_VERSION
ARG LIBTORRENT_VERSION

WORKDIR /build

# Install build dependencies
RUN apk update && apk --no-cache add \
    bash \
    build-base \
    autoconf \
    automake \
    libtool \
    coreutils \
    gcompat \
    git \
    linux-headers \
    curl-dev \
    ncurses-dev

# Checkout rTorrent sources from Github repository
RUN git clone https://github.com/rakshasa/libtorrent libtorrent -b $LIBTORRENT_VERSION
RUN git clone https://github.com/rakshasa/rtorrent rtorrent -b $RTORRENT_VERSION

RUN cd /build/libtorrent && \
    autoreconf -ivf && \
    ./configure && \
    make -j7 && \
    make install

RUN cd /build/rtorrent && \
    autoreconf -ivf && \
    ./configure && \
    make -j7 && \
    make install

FROM docker.io/jesec/flood:$FLOOD_VERSION

# Environment
ENV HOME=/home/torrent

# Run build as root
USER root

# Add additional packages
RUN apk -U upgrade \
 && apk add \
    curl \
    bash \
    zlib \
    zip \
    gzip \
    p7zip \
    findutils \
 && rm -rf /var/cache/apk/* /tmp/*

# Install rTorrent (only copy built binaries and libraries)
COPY --from=build /usr/local/ /usr/local/

# Copy additional tools
COPY rootfs /
RUN chmod +x /usr/local/bin/*.sh

# Volumes
VOLUME /home/torrent/data
VOLUME /flood

# Ports
EXPOSE 3000 55587/udp

# Label
LABEL description="BitTorrent client with WebUI front-end" \
      rtorrent="rTorrent v0.16.8 " \
      mediainfo="MediaInfo v25.09" \
      flood="Flood v4.13.0"

# Flood with managed rTorrent daemon
ENTRYPOINT ["run.sh"]
