{% from 'zabbix/map.jinja' import zbx_config,zbx_server_config with context %}

core|zabbix|server-pkgs:
  pkg.installed:
    - pkgs:
      - zabbix-server-mysql
      - zabbix-frontend-php

core|zabbix|server-conf:
  file.managed:
    - name: /etc/zabbix/zabbix_server.conf
    - source: salt://zabbix/files/zabbix_server.conf
    - template: jinja
    - defaults:
      zbx_server_log_file: {{ zbx_server_config.zbx_server_log_file }}
      zbx_server_debug_lvl: {{ zbx_server_config.zbx_server_debug_lvl }}
      zbx_server_pid_file: {{ zbx_server_config.zbx_server_pid_file }}
      zbx_server_db_host: {{ zbx_server_config.zbx_server_db_host }}
      zbx_server_db_name: {{ zbx_server_config.zbx_server_db_name }}
      zbx_server_db_user: {{ zbx_server_config.zbx_server_db_user }}
      zbx_server_db_pass: {{ salt['pillar.get']('secrets:mysql:zabbix_db_pass') }}

core|zabbix|frontend-conf:
  file.managed:
    - name: /etc/zabbix/zabbix.conf.php
    - source: salt://zabbix/files/zabbix.conf.php
    - template: jinja
    - defaults:
      zbx_server_db_host: {{ zbx_server_config.zbx_server_db_host }}
      zbx_server_db_name: {{ zbx_server_config.zbx_server_db_name }}
      zbx_server_db_user: {{ zbx_server_config.zbx_server_db_user }}
      zbx_server_db_pass: {{ salt['pillar.get']('secrets:mysql:zabbix_db_pass') }}
      zbx_server_db_type: {{ zbx_server_config.zbx_server_db_type }}
      zbx_server_db_port: {{ zbx_server_config.zbx_server_db_port }}
      zbx_server_address: {{ zbx_server_config.zbx_server_address }}
      zbx_server_port: {{ zbx_server_config.zbx_server_port }}
      zbx_server_name: {{ zbx_server_config.zbx_server_name }}

core|zabbix|server-service:
  service.running:
    - name: zabbix-server

{% if zbx_config.zbx_version == "3.0" %}
core|zabbix|zabbix3-frontend-conf:
  file.symlink:
    - name: /usr/share/zabbix/conf/zabbix.conf.php
    - target: /etc/zabbix/zabbix.conf.php
{% endif %}
