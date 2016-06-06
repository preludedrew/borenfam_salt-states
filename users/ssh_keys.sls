{% from "users/ssh_keys.jinja" import sshkeys with context %}

{% for sshkey in sshkeys %}
core|users|sshkeys-{{ sshkey.user }}:
  ssh_auth.present:
    - user: {{ sshkey.user }}
    - names:
    {% for key in sshkey.keylist %}
      - '{{ key }}'
    {% endfor %}
    - require:
      - user: {{ sshkey.user }}
{% endfor %}
