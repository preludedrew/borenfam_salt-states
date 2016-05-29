{% from 'salt/map.jinja' import minion_config with context %}

{% if grains['os_family'] == 'Debian' %}
core|salt|salt-repo-debian:
  pkgrepo.managed:
    - humanname: Ubuntu Trusty SaltStacke Package Repo
    - name: deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/2016.3 trusty main
    - dist: trusty
    - file: /etc/apt/sources.list.d/saltstack.list
    - gpgcheck: 1
    - key_url: https://repo.saltstack.com/apt/ubuntu/14.04/amd64/2016.3/SALTSTACK-GPG-KEY.pub
    - require_in:
{% if 'salt-master' in grains['fqdn'] %}
      - pkg: salt-master
{% endif %}
      - pkg: salt-minion

core|salt|salt-minion-pkg:
  pkg.latest:
    - name: salt-minion
{% endif %}

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

core|salt|highstate:
  schedule.present:
    - function: state.highstate
    - seconds: {{ minion_config['run_period'] }}
    - splay: {{ minion_config['run_splay'] }}

core|salt|lastcontact:
  file.touch:
    - name: /etc/salt.lastcontact
