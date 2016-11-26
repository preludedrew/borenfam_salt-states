{% from 'zabbix/map.jinja' import zbx_proxy_config with context %}

core|zabbix|proxy|proxy-pkg:
  pkg.installed:
    - name: zabbix-proxy-sqlite3
    - skip_verify: True

core|zabbix|proxy|proxy-conf:
  file.managed:
    - name: /etc/zabbix/zabbix_proxy.conf
    - source: salt://zabbix/files/zabbix_proxy.conf
    - template: jinja
    - defaults:
      hostname: PROXY01
      proxy_mode: {{ zbx_proxy_config.proxy_mode }}
      server: {{ zbx_proxy_config.server }}
      log_file: {{ zbx_proxy_config.log_file }}
      pid_file: {{ zbx_proxy_config.pid_file }}
      db_name: {{ zbx_proxy_config.db_name }}
      timeout: {{ zbx_proxy_config.timeout }}
      external_scripts: {{ zbx_proxy_config.external_scripts }}
      fping_location: {{ zbx_proxy_config.fping_location }}
      fping6_location: {{ zbx_proxy_config.fping6_location }}
      log_slow_queries: {{ zbx_proxy_config.log_slow_queries }}

core|zabbix|proxy|sqlite-dir:
  file.directory:
    - name: /usr/local/share/sqlite3/zabbix
    - user: zabbix
    - group: zabbix
    - dir_mode: 755
    - makedirs: True

core|zabbix|proxy|proxy-service:
  service.running:
    - name: zabbix-proxy
    - require:
      - pkg: zabbix-proxy-sqlite3
    - watch:
      - file: /etc/zabbix/zabbix_proxy.conf
