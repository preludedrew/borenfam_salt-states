
core|vm|network-eth1:
  network.managed:
    - name: eth1
    - enabled: True
    - type: eth
    - proto: static
    - ipaddr: 192.168.0.{{ grains['host'].split('-')[2] }}
    - netmask: 255.255.255.0

core|linuxha|xo|ssh_auth:
  ssh_auth.present:
    - user: root
    - enc: rsa
    - name: AAAAB3NzaC1yc2EAAAADAQABAAABAQCZG7eQfqxJd3SmUlUlhubqF9nzk7qAR/uRt77CiQS+s+H93n+pcyWlfGZnfIBiYbqS1n0X9k6wAyUZ5g++6TND5HCbQNW+7s0g4GD8Y1ECQF3UPubvBTcE9twnmTU/QHPhAd2rbPImkBtdOxl1fEW0mrWcFDRcOnXvTyRP3pfHn9CXcb2XGUNYPIz6lrNontoo8n8/Wk7Bli50ZoHHIWcCPhM5F9wtsTIuDXFtJRXPkcWviibH3hXe9xLtmBiWyOQqRzTHbecZcExGj7t7GGzHLIq3z4GfGtkd6ioIwwkx+9r0VXZi0XrCsdEtgjasSJN6fZ3OrTsrtuEwSx2fClhT
    - options:
      - from="192.168.0.1,192.168.0.2"

core|linuxha|xo|ssh_priv_key:
  file.managed:
    - name: /root/.ssh/id_rsa
    - makedirs: True
    - user: root 
    - mode: 600
    - group: root
    - contents_pillar: secrets:linuxha:xo_ssh_priv_key

core|linuxha|xo|ssh_pub_key:
  file.managed:
    - name: /root/.ssh/id_rsa.pub
    - contents: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZG7eQfqxJd3SmUlUlhubqF9nzk7qAR/uRt77CiQS+s+H93n+pcyWlfGZnfIBiYbqS1n0X9k6wAyUZ5g++6TND5HCbQNW+7s0g4GD8Y1ECQF3UPubvBTcE9twnmTU/QHPhAd2rbPImkBtdOxl1fEW0mrWcFDRcOnXvTyRP3pfHn9CXcb2XGUNYPIz6lrNontoo8n8/Wk7Bli50ZoHHIWcCPhM5F9wtsTIuDXFtJRXPkcWviibH3hXe9xLtmBiWyOQqRzTHbecZcExGj7t7GGzHLIq3z4GfGtkd6ioIwwkx+9r0VXZi0XrCsdEtgjasSJN6fZ3OrTsrtuEwSx2fClhT crossover_key'
    - backup: False
    - user: root
    - group: root
    - makedirs: True
