base:
  '*':
    - users
    - salt.minion
    - pkgs
    - zabbix.agent
    - bootloader
{% if grains['virtual'] != "physical" %}
    - vm
{% endif %}
  'nas-vm-*':
    - nfs
    - raid.lsi
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
