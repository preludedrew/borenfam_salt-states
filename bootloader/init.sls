{% if grains['os_family'] == 'RedHat' %}
core|bootloader|grub-cmdline-default:
  file.replace:
    - name: /etc/default/grub
    - flags: 'MULTILINE'
    - pattern: |
        ^GRUB_CMDLINE_LINUX.*
    - repl: GRUB_CMDLINE_LINUX="crashkerinel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet net.ifnames=0"\n

core|bootloader|update-grub:
  cmd.wait:
    - name: grub2-mkconfig -o /boot/grub2/grub.cfg
    - watch:
      - file: core|bootloader|grub-cmdline-default
{% endif %}
