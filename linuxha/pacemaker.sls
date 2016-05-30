{% from "linuxha/map.jinja" import linuxha_res with context %}

core|linuxha|linux-ha-repo:
  pkgrepo.managed:
    - name: deb http://ppa.launchpad.net/syseleven-platform/linux-ha/ubuntu {{ grains['oscodename']}} main
    - file: /etc/apt/sources.list.d/linux-ha.list
    - keyserver: keyserver.ubuntu.com
    - keyid: '7736223724911626'
core|linuxha|pacemaker-pkg:
  pkg.installed:
    - name: pacemaker
    - version: 1.1.12+git+a9c8177-3ubuntu1

core|linuxha|corosync-pkg:
  pkg.installed:
    - name: corosync
    - version: 2.3.4-3ubuntu1

{% set net_0_if = salt['network.interface']('eth0')[0] %}
{% set net_1_if = salt['network.interface']('eth1')[0] %}


{% set net_0_addr = salt['network.calc_net'](net_0_if['address'], net_0_if['netmask']).split('/')[0] %}
{% set net_1_addr = salt['network.calc_net'](net_1_if['address'], net_1_if['netmask']).split('/')[0] %}


core|linuxha|corosync-conf:
  file.managed:
    - name: /etc/corosync/corosync.conf
    - source: salt://linuxha/files/corosync.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      cluster_name: 'mysql-vm-ha.borenfam.com'
      net_0_addr: {{ net_0_addr }}
      net_1_addr: {{ net_1_addr }}
      mcast_addr: {{ linuxha_res.mcast_addr }}
