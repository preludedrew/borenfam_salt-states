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
