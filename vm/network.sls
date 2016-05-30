core|vm|network-eth0:
  network.managed:
    - name: eth0
    - enabled: True
    - type: eth
    - proto: static
    - gateway: 10.1.1.1
    - ipaddr: {{ salt['dnsutil.A'](grains['fqdn'])[0] }}
    - netmask: 255.255.255.0
    - dns:
      - 10.1.1.1
    - dns-search:
      - borenfam.com
