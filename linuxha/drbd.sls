{% from "linuxha/map.jinja" import linuxha_res with context %}

core|linuxha|drbd-pkg:
  pkg.installed:
{% if grains['oscodename'] == 'trusty' %}
    - name: drbd8-utils
    - version: 2:8.4.4-1ubuntu1
{% elif grains['oscodename'] == 'xenial' %}
    - name: drbd-utils
    - version: 8.9.6-1
{% endif %}

{# Make sure the kernel is downgraded on trusty, so drbd works #}
{% if grains['oscodename'] == 'trusty' %}
core|linuxha|old-kernel:
  pkg.installed:
    - name: linux-generic
{% endif %}

core|linuxha|drbd_res_conf:
  file.managed:
    - name: /etc/drbd.d/{{ linuxha_res.drbd_res_name }}.res
    - source: salt://linuxha/files/drbd_template.res
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      drbd_res_name: {{ linuxha_res.drbd_res_name }}
      drbd_server_1: {{ linuxha_res.drbd_server_1 }}
      drbd_server_2: {{ linuxha_res.drbd_server_2 }}
      drbd_address_1: {{ linuxha_res.drbd_address_1 }}
      drbd_address_2: {{ linuxha_res.drbd_address_2 }}
      drbd_port: {{ linuxha_res.drbd_port }}

core|linuxha|drbd-mount:
  file.directory:
    - name: /{{ linuxha_res.drbd_res_name}}
    - user: {{ linuxha_res.drbd_mount_owner }}
    - group: {{ linuxha_res.drbd_mount_owner }}
    - create: True
    - recurse:
        - user
        - group
        - mode
