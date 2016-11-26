{% from "pkgs/map.jinja" import defaults with context %}
{% from "zabbix/map.jinja" import zbx_config with context %}

{# Zabbix 3.0 repo, currently on trusty is supported #}
core|pkgs|zabbix-repo:
  pkgrepo.managed:
{% if grains['os_family'] == 'Debian' %}
    - humanname: Zabbix {{ zbx_config.zbx_version }} Release ( Debian )
    - name: deb http://repo.zabbix.com/zabbix/{{ zbx_config.zbx_version }}/ubuntu trusty main
    - file: /etc/apt/sources.list.d/zabbix.list
    - keyid: 'D13D58E479EA5ED4'
    - keyserver: keyserver.ubuntu.com
{% elif grains['os_family'] == 'RedHat' %}
    - name: zabbix.repo
    - humanname: Zabbix {{ zbx_config.zbx_version }} Release ( RHEL )
    - baseurl: http://repo.zabbix.com/zabbix/{{ zbx_config.zbx_version }}/rhel/7/x86_64/
    - gpgcheck: 1
    - gpgkey: http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX
{% elif grains['os_family'] == 'ClearOS' %}
    - humanname: Zabbix {{ zbx_config.zbx_version }} Release ( RHEL )
    - baseurl: http://repo.zabbix.com/zabbix/{{ zbx_config.zbx_version }}/rhel/{{ grains['osrelease_info'][0] }}/x86_64/
    - name: zabbix.repo
    - gpgcheck: 1
    - gpgkey: http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX
{% endif %}

{% if grains['os_family'] == 'RedHat' %}
core|pkgs|epel-repo:
  pkgrepo.managed:
    - name: epel.repo
    - gpgcheck: 1
    - humanname: Extra Packages for Enterprise Linux 7
    - baseurl: http://dl.fedoraproject.org/pub/epel/{{ grains['osmajorrelease'] }}/x86_64/
    - gpgkey: http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-{{ grains['osmajorrelease'] }}
    - require_in:
      - pkg: core|pkgs|default-pkgs
{% endif %}

core|pkgs|default-pkgs:
  pkg.installed:
    - pkgs:
{% for pkg in defaults.pkgs %}
      - {{ pkg }}
{% endfor %}

core|pkgs|tmux-conf:
  file.managed:
    - name: /home/andrew/.tmux.conf
    - source: salt://pkgs/files/tmux.conf
    - user: andrew
    - group: andrew
    - mode: 644
    - require:
       - user: andrew
