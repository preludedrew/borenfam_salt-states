{% from 'salt/map.jinja' import minion_config with context %}

{% if not grains['os_family'] == 'ClearOS' %}
{% set os_name = grains['os']|lower %}
{% set rel_name = grains['oscodename'] %}
{% set rel_ver = grains['osrelease'] %}

core|salt|salt-repo:
  pkgrepo.managed:
{% if grains['os_family'] == 'Debian' %}
    - humanname: Ubuntu Trusty SaltStack Package Repo
    - name: deb http://repo.saltstack.com/apt/{{ os_name }}/{{ rel_ver }}/amd64/2016.3 {{ rel_name }} main
    - dist: {{ rel_name }}
    - file: /etc/apt/sources.list.d/saltstack.list
    - gpgcheck: 1
    - key_url: https://repo.saltstack.com/apt/{{ os_name }}/{{ rel_ver }}/amd64/2016.3/SALTSTACK-GPG-KEY.pub
{% elif grains['os_family'] == 'RedHat' %}
    - name: saltstack.repo
    - humanname: RedHat SaltStack Package Repo
    - baseurl: https://repo.saltstack.com/yum/redhat/7/x86_64/2016.3/
    - gpgcheck: 1
    - gpgkey: https://repo.saltstack.com/yum/redhat/7/x86_64/2016.3/
{% endif %}
    - require_in:
{% if 'salt-master' in grains['fqdn'] %}
      - pkg: salt-master
{% endif %}
      - pkg: salt-minion

core|salt|salt-minion-pkg:
  pkg.latest:
    - name: salt-minion

core|salt|minion-conf:
  file.managed:
    - name: /etc/salt/minion.d/minion.conf
    - source: salt://salt/files/minion.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        salt_master: salt-master.borenfam.com

core|salt|minion-service:
  service.running:
    - enable: True
    - name: salt-minion

core|salt|highstate:
  schedule.present:
    - function: state.highstate
    - seconds: {{ minion_config['run_period'] }}
    - splay: {{ minion_config['run_splay'] }}
    - require:
      - service: salt-minion

core|salt|lastcontact:
  file.touch:
    - name: /etc/salt.lastcontact
{% endif %}
