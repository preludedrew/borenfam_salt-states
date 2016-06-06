include:
  - .network
{% if grains['virtual'] in ['VMWare', 'VMware'] %}
  - .vmware
{% endif %}
