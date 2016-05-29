{% set rel_name = salt['grains.get']('oscodename') %}

core|mongo|mongo-pkg-repo:
  pkgrepo.managed:
    - humanname: MongoDB Repo
    - name: deb http://repo.mongodb.org/apt/ubuntu {{ rel_name }}/mongodb-org/3.0 multiverse
    - file: /etc/apt/sources.list.d/mongodb-org-3.0.list
    - require_in:
      - pkg: core|mongo|mongo-pkg
    - gpgcheck: 1
    - keyid: 7F0CEB10
    - keyserver: keyserver.ubuntu.com

core|mongo|mongo-pkg:
  pkg.installed:
    - name: mongodb-org
    - version: 3.0.12
