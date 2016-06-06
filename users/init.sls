{%- from "users/map.jinja" import defaults with context %}

include:
  - .ssh_keys

top|users|root_user:
  user.present:
    - name: root 
    - password: {{ salt['pillar.get']('secrets:users:root_password') }} 

top|users|andrew_user:
  user.present:
    - name: andrew
    - fullname: "Andrew Boren"
    - home: /home/andrew
    - uid: 1000
    - gid_from_name: True
    - groups:
{% for group in defaults.groups %}
      - {{ group }} 
{% endfor %}
    - optional_groups:
      - vboxusers
      - torrent-users
    - shell: /bin/bash
    - password: {{ salt['pillar.get']('secrets:users:andrew_password') }} 
