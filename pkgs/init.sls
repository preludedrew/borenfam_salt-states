{% from "pkgs/map.jinja" import defaults with context %}

core|pkgs|default-pkgs:
  pkg.installed:
    - pkgs:
{% for pkg in defaults.pkgs %}
      - {{ pkg }}
{% endfor %}
