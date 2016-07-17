base:
  '*':
    - users
    - salt.minion
    - pkgs
    - zabbix.agent
    - bootloader
    - nfs.client
{% if grains['virtual'] != "physical" %}
    - vm
{% endif %}
  'nas-vm-*':
    - nfs.server
    - raid.lsi
  'nas-1':
    - plex
  'multi-vm*':
    - pxe
  'salt-master*':
    - salt.master
  'mongo-vm*':
    - mongo
  'mysql-vm*':
    - mysql
  'zabb-vm*':
    - zabbix.server
  'zabbproxy-vm*':
    - zabbix.proxy
  'build-*':
    - build
