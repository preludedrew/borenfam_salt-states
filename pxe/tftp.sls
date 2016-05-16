core|pxe|tftp_config:
  file.managed:
    - name: /etc/default/tftpd-hpa
    - source: salt://pxe/files/tftpd-hpa
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      pxe_media_dir: /media/nfs/pxe

core|pxe|tfpd_pkg:
  pkg.installed:
    - pkgs:
      - tftpd-hpa
