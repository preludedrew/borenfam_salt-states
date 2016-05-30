include:
  - .drbd
  - .pacemaker

core|vm|network-eth1:
  network.managed:
    - name: eth1
    - enabled: True
    - type: eth
    - proto: static
    - ipaddr: 192.168.0.{{ grains['host'].split('-')[2] }}
    - netmask: 255.255.255.0
