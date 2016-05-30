{% from 'zabbix/map.jinja' import zbx_agent_config with context %}

core|zabbix|agent-pkg:
  pkg.installed:
    - name: zabbix-agent

core|zabbix|agent-log-dir:
  file.directory:
    - name: /var/log/zabbix-agent
    - create: True
    - user: zabbix
    - group: zabbix
    - mode: 755

core|zabbix|agent-conf:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://zabbix/files/zabbix_agentd.conf
    - template: jinja
    - defaults:
      zbx_agent_hostname: {{ grains['fqdn'] }}
      zbx_agent_pid_file: {{ zbx_agent_config.zbx_agent_pid_file }}
      zbx_agent_log_file: {{ zbx_agent_config.zbx_agent_log_file }}
      zbx_agent_server: {{ zbx_agent_config.zbx_agent_server }}
      zbx_agent_server_active: {{ zbx_agent_config.zbx_agent_server_active }}
      zbx_agent_include_path: {{ zbx_agent_config.zbx_agent_include_path }}
