{% from "linuxha/map.jinja" import drbd_res with context %}

core|linuxha|drbd_pkg:
  pkg.installed:
    - sources:
      - storcli: salt://linux-ha/files/drbd8-utils_8.3.11-0ubuntu1_amd64.deb

core|linuxha|drbd_res:
  file.managed:
    - name: /etc/drbd.d/{{ drbd_res.drbd_res_name }}.res
    - source: salt://linuxha/files/drbd_template.res
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      drbd_res_name: {{ drbd_res.drbd_res_name }}
      drbd_server_1: {{ drbd_res.drbd_server_1 }}
      drbd_server_2: {{ drbd_res.drbd_server_2 }}
      drbd_address_1: {{ drbd_res.drbd_address_1 }}
      drbd_address_2: {{ drbd_res.drbd_address_2 }}
      drbd_port: {{ drbd_res.drbd_port }}
