docker-compose project with [rtorrent](https://github.com/rakshasa/rtorrent), [flood](https://github.com/Flood-UI/flood) and [wireguard](https://www.wireguard.com/).

---

Base for this project are the modified versions of rtorrent and flood by @jesec:
* https://github.com/jesec/flood
* https://github.com/jesec/rtorrent

and the wireguard container by @linuxserver:
* https://github.com/linuxserver/docker-wireguard

---

## wireguard

**Important directories:**
* `/config` wireguard config

**Open ports:**
* `3000` - flood web interface

For more information see the official [README](https://github.com/linuxserver/docker-wireguard/blob/master/README.md).

## rtorrent-flood

**Important directories:**
* `/home/torrent/.rtorrent.rc` - rtorrent configuration 
* `/home/torrent/data` - rtorrent data, log, session and watch subdirectories
* `/flood` - flood data directory

**Ports**
* `55587/udp` - rtorrent external connection - configurable with `.rtorrent.rc`, exposed through wireguard container

**Additional goodies:**
* automatic IP resolving in rtorrent
* auto-unrar
