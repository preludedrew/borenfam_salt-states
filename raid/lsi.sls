core|raid|storcli_pkg:
  pkg.installed:
    - sources:
      - storcli: salt://raid/files/storcli_1.19.04_all.deb

core|raid|symlink-storcli:
  file.symlink:
    - name: /usr/sbin/storcli
    - target: /opt/MegaRAID/storcli/storcli64
    - require:
      - pkg: core|raid|storcli_pkg
