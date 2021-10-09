# Arguments
ARG FLOOD_VERSION=4.7.0
ARG RTORRENT_VERSION=0.9.8-r15

FROM docker.io/jesec/rtorrent:$RTORRENT_VERSION as rtorrent

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
    unrar \
    findutils \
 && rm -rf /var/cache/apk/* /tmp/*

# Install rTorrent
COPY --from=rtorrent / /

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
      rtorrent="rTorrent BiTorrent client v0.9.8-r15" \
      mediainfo="MediaInfo v20.09" \
      flood="Flood v4.7.0"

# Flood with managed rTorrent daemon
ENTRYPOINT ["run.sh"]
