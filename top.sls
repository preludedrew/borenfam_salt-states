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
  'nas-[1-2]':
    - nfs.server
    - plex
  'nas-vm*':
    - nfs.server
    - raid.lsi
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
  'torr-vm*':
    - torrent.server
