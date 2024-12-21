#cloud-config
autoinstall:
  early-commands:
    - sudo systemctl stop ssh
  identity:
    hostname: ${ vm_guest_os_hostname }
    password: '${ build_password_hashed }'
    username: ${ build_username }
  keyboard:
    layout: ${ vm_guest_os_keyboard }
  late-commands:
    - echo "${ build_username } ALL=(ALL) NOPASSWD:ALL" > /target/etc/sudoers.d/${ build_username }
    - curtin in-target --target=/target -- chmod 400 /etc/sudoers.d/${ build_username }
  locale: ${ vm_guest_os_language }
  network:
    network:
      version: 2
      ethernets:
        all-en:
          match:
            name: e*
          critical: true
          dhcp4: true
%{ if length( apt_packages ) > 0 ~}
  packages:
%{ for package in apt_packages ~}
    - ${ package }
%{ endfor ~}
%{ endif ~}
  ssh:
    install-server: true
    allow-pw: true
%{ if length( ssh_keys ) > 0 ~}
    authorized-keys:
%{ for ssh_key in ssh_keys ~}
      - ${ ssh_key }
%{ endfor ~}
%{ endif ~}
  storage:
    layout:
      name: lvm
  user-data:
    package_upgrade: true
    disable_root: true
    timezone: ${ vm_guest_os_timezone }
  version: 1
