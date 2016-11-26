{% from 'zabbix/map.jinja' import zbx_agent_config with context %}

core|zabbix|agent-pkg:
  pkg.installed:
    - name: zabbix-agent
    - skip_verify: True

core|zabbix|agent-log-dir:
  file.directory:
    - name: /var/log/zabbix-agent
    - create: True
    - user: zabbix
    - group: zabbix
    - mode: 755
    - require:
      - pkg: zabbix-agent

core|zabbix|agent-conf:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://zabbix/files/zabbix_agentd.conf
    - template: jinja
    - defaults:
      zbx_agent_hostname: {{ grains['fqdn'] }}
      zbx_agent_pid_file: {{ zbx_agent_config.zbx_agent_pid_file }}
      zbx_agent_log_file: {{ zbx_agent_config.zbx_agent_log_file }}
      zbx_agent_server: {{ zbx_agent_config.zbx_agent_server|join(',') }}
      zbx_agent_include_path: {{ zbx_agent_config.zbx_agent_include_path }}
    - require:
      - pkg: zabbix-agent

core|zabbix|agent-service:
  service.running:
    - name: zabbix-agent
    - require:
      - pkg: zabbix-agent
    - watch:
      - file: /etc/zabbix/zabbix_agentd.conf

core|zabbix|check-server:
  cmd.run:
    - name: 'test $(which zabbix_server) || touch /usr/local/bin/zabbix_server'

core|zabbix|agent|host-exists:
  zabbix_host.present:
    - host: {{ grains.fqdn }}
    - groups: ['2']
    - interfaces: [{'type': 1, 'main': 1, 'useip': 1, 'ip': {{ grains.ipv4[0] }}, 'dns': {{ grains.fqdn }}, 'port': '10050'}]


{% if salt['zbx.host_exists'](grains['fqdn']) %}
{% set host_id = salt['zbx.host_get'](grains.fqdn)[0].hostid %}
{% set template_list = [{'templateid': '10001'}] %}

core|zabbix|agent|templates:
  module.run:
    - name: zabbix.host_update
    - hostid: {{ host_id }}
    - connection_args: {'templates' :{{ template_list }}}
{% endif %}
