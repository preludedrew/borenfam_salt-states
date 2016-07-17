core|pxe|tftpd-config:
  file.managed:
    - name: /etc/default/tftpd-hpa
    - source: salt://pxe/files/tftpd-hpa
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      pxe_media_dir: /media/pxe

core|pxe|tfpd-pkg:
  pkg.installed:
    - pkgs:
      - tftpd-hpa

core|pxe|tftpd-service:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: tftpd-hpa
    - onchanges:
      - file: core|pxe|tftpd-config
