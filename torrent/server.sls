core|torrent|torrent-user:
  user.present:
    - name: torrent-users
    - uid: 1004
    - gid_from_name: True
    - gid: 1004
    - createhome: False
