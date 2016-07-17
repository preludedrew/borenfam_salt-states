{% from "plex/map.jinja" import plex with context %}

core|plex|plexmediaserver-pkg:
  pkg.installed:
    - sources:
      - plexmediaserver: {{ plex.url }}

  service.running:
    - name: plexmediaserver
    - enable: True
    - require:
      - pkg: core|plex|plexmediaserver-pkg
