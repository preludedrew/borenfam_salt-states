{% from "nfs/map.jinja" import pkg_map with context %}
{% from "nfs/map.jinja" import nfs_mounts with context %}

{% if grains['host'] in nfs_mounts %}
core|nfs|nfs-client-pkg:
  pkg.installed:
    - pkgs: {{ pkg_map.pkgs_client }}

{% for mount in nfs_mounts[grains['host']] %}
core|nfs|mount-{{ mount.name }}:
  mount.mounted:
    - name: {{ mount.mountpoint }}
    - device: {{ mount.location }}:/nfs/{{ mount.name }}
    - fstype: nfs
    - opts:
      - auto
      - nolock
      - bg
      - intr
      - tcp
      - actimeo=1800
    - persist: {{ mount.persist|default('True') }}
    - mkmnt: {{ mount.mkmnt|default('True') }}
{% endfor %}
{% endif %}
