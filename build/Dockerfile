# Arguments
ARG FLOOD_VERSION=4.4
ARG RTORRENT_VERSION=latest

FROM jesec/rtorrent:$RTORRENT_VERSION as rtorrent

FROM jesec/flood:$FLOOD_VERSION as flood

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
      rtorrent="rTorrent BiTorrent client v0.9.8-r4" \
      mediainfo="MediaInfo v20.09" \
      flood="Flood v$FLOOD_VER"

# Flood with managed rTorrent daemon
ENTRYPOINT ["run.sh"]
