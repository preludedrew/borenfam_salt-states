{% from "plex/map.jinja" import plex with context %}

core|plex|plexmediaserver-pkg:
  pkg.installed:
    - sources:
      - plexmediaserver: {{ plex.url }}

core|plex|plex-svc:
  service.disabled:
    - name: plexmediaserver
    - require:
      - pkg: core|plex|plexmediaserver-pkg

core|plex|plex-cfg-symlink:
  file.symlink:
    - name: {{ plex.symlink_dir }}
    - target: {{ plex.data_dir }}
    - makedirs: True
    - require_in:
      - pkg: core|plex|plexmediaserver-pkg

core|plex|plex-cfg-perms:
  file.directory:
    - name: {{ plex.data_dir }}
    - user: plex
    - group: plex
    - makedirs: False
    - create: False
    - mode: '0755'
    - recurse:
      - user
      - group
    - require:
      - file: core|plex|plex-cfg-symlink
