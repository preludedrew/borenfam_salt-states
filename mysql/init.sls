include:
  - linuxha

core|mysql|mysql56-pkg:
  pkg.installed:
    - name: mysql-server-5.6

core|mysql|conf-exists:
  file.exists:
    - name: /db/my.cnf

core|mysql|conf:
  file.managed:
    - name: /db/my.cnf
    - source: salt://mysql/files/my.cnf
    - template: jinja
    - defaults:
      db_dir: '/db/mysql'
    - create: False


core|mysql|conf-symlink:
  file.symlink:
    - name: /etc/mysql/my.cnf
    - target: /db/my.cnf
