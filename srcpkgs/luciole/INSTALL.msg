Luciole works for local browsing as installed. Install these for
extra features:

  Media thumbnails and metadata ....... ffmpeg
  Video filmstrip thumbnails .......... ffmpegthumbnailer
  PDF previews ........................ poppler-utils
  Encrypted 7z archives ............... 7zip
  Automatic terminal selection ........ xdg-terminal-exec
  Device mounting / LUKS unlocking .... udisks2
  SMB shares .......................... gvfs-smb
  MTP devices (phones) ................ gvfs-mtp
  Secure WebDAV (TLS) ................. glib-networking
  Network share discovery (DNS-SD) .... avahi

For DNS-SD discovery, the avahi-daemon service must be running:
  ln -s /etc/sv/avahi-daemon /var/service/

Unlocking LUKS volumes also needs a polkit authentication agent
running in your session.
