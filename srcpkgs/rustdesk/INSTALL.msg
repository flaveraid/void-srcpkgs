For incoming (unattended) connections, enable the service:
  ln -s /etc/sv/rustdesk /var/service/
The service finds your session through elogind. The in-app
"Install service" button uses systemctl and won't work on Void.
