<?php
// Zabbix GUI configuration file
global $DB;

$DB['TYPE']     = '{{ zbx_server_db_type }}';
$DB['SERVER']   = '{{ zbx_server_db_host }}';
$DB['PORT']     = '{{ zbx_server_db_port }}';
$DB['DATABASE'] = '{{ zbx_server_db_name }}';
$DB['USER']     = '{{ zbx_server_db_user }}';
$DB['PASSWORD'] = '{{ zbx_server_db_pass }}';

// SCHEMA is relevant only for IBM_DB2 database
$DB['SCHEMA'] = '';

$ZBX_SERVER      = '{{ zbx_server_address }}';
$ZBX_SERVER_PORT = '{{ zbx_server_port }}';
$ZBX_SERVER_NAME = '{{ zbx_server_name }}';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
