base:
  '*':
    - users
    - salt.minion
{% if grains['virtual'] == "VMware" and grains['os'] == 'Ubuntu'  %}
    - vm.vmware
{% endif %}
  'nas-vm-*':
    - raid.lsi
  'multi-vm*':
    - pxe
  'salt-master*':
    - master
