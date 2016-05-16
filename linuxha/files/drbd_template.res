resource {{ drbd_res_name }} {   

        device    /dev/drbd0;
        disk      /dev/vg1/{{ drbd_res_name }};
        meta-disk /dev/vg1/{{ drbd_res_name }}-meta[0];
        on {{ drbd_server_1 }} {
                address   {{ drbd_address_1 }}:{{ drbd_port }};
        }

        on {{ drbd_server_2 }} {
                address   {{ drbd_address_2 }}:{{ drbd_port }};
        }
}
