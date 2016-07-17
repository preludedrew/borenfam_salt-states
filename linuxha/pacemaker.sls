{% from "linuxha/map.jinja" import linuxha_res with context %}

{% if grains['os_family'] == 'Debian' and grains['oscodename'] == 'trusty' %}
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
{% elif grains['os_family'] == 'Debian' and grains['oscodename'] == 'xenial' %}
core|linuxha|pacemaker-pkg:
  pkg.installed:
    - name: pacemaker
    - version: 1.1.14-2ubuntu1

core|linuxha|corosync-pkg:
  pkg.installed:
    - name: corosync
    - version: 2.3.5-3ubuntu1
{% endif %}


{% set net_0_addr = "FIXME" %}
{% set net_1_addr = "FIXME" %}
{% set interfaces = salt['grains.get']('ip4_interfaces') %}

{% if 'eth0' in interfaces %}
{% set net_0_if = salt['network.interface']('eth0')[0] %}
{% set net_0_addr = salt['network.calc_net'](net_0_if['address'], net_0_if['netmask']).split('/')[0] %}
{% endif %}

{% if 'eth1' in interfaces %}
{% set net_1_if = salt['network.interface']('eth1')[0] %}
{% set net_1_addr = salt['network.calc_net'](net_1_if['address'], net_1_if['netmask']).split('/')[0] %}
{% endif %}


core|linuxha|corosync-conf:
  file.managed:
    - name: /etc/corosync/corosync.conf
    - source: salt://linuxha/files/corosync.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      cluster_name: {{ linuxha_res.cluster_name }}
      net_0_addr: {{ net_0_addr }}
      net_1_addr: {{ net_1_addr }}
      mcast_addr: {{ linuxha_res.mcast_addr }}
