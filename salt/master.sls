core|salt|rng_tools:
  pkg.installed:
    - pkgs:
      - rng-tools
      - python-gnupg

core|salt|salt-master-pkg:
  pkg.latest:
    - name: salt-master

core|salt|salt-api-user:
  user.present:
    - name: api_user
    - password: '12345678'
