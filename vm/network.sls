core|vm|network-eth0:
  network.managed:
    - name: eth0
    - enabled: True
    - type: eth
{% if grains['os_family'] == 'Ubuntu' %}
    - proto: static
{% elif grains['os_family'] == 'Redhat' %}
    - proto: none
{% endif %}
    - gateway: 10.1.1.1
    - ipaddr: {{ salt['dnsutil.A'](grains['fqdn'])[0] }}
    - netmask: 255.255.255.0
    - dns:
      - 10.1.1.1
    - dns-search:
      - borenfam.com
