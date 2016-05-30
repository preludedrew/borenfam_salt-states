base:
  '*':
    - users
    - salt.minion
    - pkgs
    - zabbix.agent
{% if grains['virtual'] == "VMware" and grains['os'] == 'Ubuntu'  %}
    - vm.vmware
{% endif %}
  'nas-vm-*':
    - raid.lsi
  'multi-vm*':
    - pxe
  'salt-master*':
    - master
  'mongo-vm*':
    - mongo
  'mysql-vm*':
    - mysql
  'zabb-vm*':
    - zabbix.server
