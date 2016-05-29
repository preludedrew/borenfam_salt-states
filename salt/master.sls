core|salt|rng_tools:
  pkg.installed:
    - pkgs:
      - rng-tools
      - python-gnupg

core|salt|salt-master-pkg:
  pkg.latest:
    - name: salt-master
