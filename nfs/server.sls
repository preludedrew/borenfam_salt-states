{% from "nfs/map.jinja" import nfs_map with context %}

include:
  - linuxha

core|nfs|nfs-pkg:
  pkg.installed:
    - name: nfs-kernel-server

core|nfs|nfs-disable-boot:
  service.disabled:
    - name: nfs-kernel-server
    - require:
      - pkg: nfs-kernel-server

core|nfs|nfs-export:
  file.managed:
    - name: /etc/exports
    - contents:
{% for path in nfs_map %}
      - "{{ path.path }}\t\t{{ path.network }}({{ path.options|join(',') }})"
{% endfor %}

core|nfs|nfs-update-exports:
  cmd.run:
    - name: exportfs -ra
    - require:
      - pkg: nfs-kernel-server
    - onchanges:
      - file: core|nfs|nfs-export
