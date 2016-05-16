{% from 'salt/map.jinja' import minion_config with context %}

core|salt|highstate:
  schedule.present:
    - function: state.highstate
    - seconds: {{ minion_config['run_period'] }}
    - splay: {{ minion_config['run_splay'] }}

core|salt|lastcontact:
  file.touch:
    - name: /etc/salt.lastcontact
