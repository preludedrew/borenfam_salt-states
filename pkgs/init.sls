{% from "pkgs/map.jinja" import defaults with context %}
{% from "zabbix/map.jinja" import zbx_config with context %}

{% if grains['os'] == 'Ubuntu' %}
{# Zabbix 3.0 repo, currently on trusty is supported #}
core|zabbix|zabbix-repo:
  pkgrepo.managed:
    - humanname: Zabbix {{ zbx_config.zbx_version }} Release
    - name: deb http://repo.zabbix.com/zabbix/{{ zbx_config.zbx_version }}/ubuntu {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/zabbix.list
    - keyid: 'D13D58E479EA5ED4'
    - keyserver: keyserver.ubuntu.com
{% endif %}
core|pkgs|default-pkgs:
  pkg.installed:
    - pkgs:
{% for pkg in defaults.pkgs %}
      - {{ pkg }}
{% endfor %}
