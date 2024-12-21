install_iso_file      = "ubuntu-24.04.1-live-server-amd64.iso"
install_iso_checksum  = "sha512:3d518612aabbdb77fd6b49cb55b824fed11e40540e4af52f5f26174257715c93740f83079ea618b4d933081f0b1bc69d32b7885b7c75bc90da5ad3fe1814cfd4"
template_name         = "template-ubuntu-2404"
template_description  = "Ubuntu 2404 Noble Numbat"

cores             = 1
cpu_type          = "host"
memory            = 2048
qemu_agent        = true
scsi_controller   = "virtio-scsi-pci"

network_adapter_model     = "virtio"
network_adapter_firewall  = false

boot_iso_type     = "scsi"
boot_iso_unmount  = true

root_disk_size    = "20G"
root_disk_format  = "raw"
root_disk_type    = "virtio"

cloudinit_cd_label = "cidata"
cloudinit_iso_unmount = true

#vm_boot_order     = "order=scsi0;ide2"
vm_boot_order     = "order=virtio0;scsi0"
vm_boot_wait      = "10s"
vm_boot_command   = [
    "<esc><wait>c",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud\"",
    "<enter>",
    "<wait> <bs><wait> <bs><wait> <bs><wait> <bs><wait> <bs>",
    "initrd /casper/initrd",
    "<enter>",
    "<wait> <bs><wait> <bs><wait> <bs><wait> <bs><wait> <bs>",
    "boot",
    "<enter>"
  ]

# userdata configuration
vm_guest_os_keyboard = "gb"
vm_guest_os_language = "en_GB-UTF8"
vm_guest_os_timezone = "Europe/London"

communicator_type = "ssh"
communicator_port = 22
communicator_timeout = "25m"

cloudinit_apt_packages = [
  "cloud-guest-utils",
  "qemu-guest-agent",
  "sudo"
]
