# commandline variables
variable "proxmox_node" {
    type = string
}

variable "vm_id" {
    type = string
}

variable "install_iso_file" {
    type = string
}

variable "install_iso_checksum" {
    type = string
}

variable "template_name" {
    type = string
}

variable "template_description" {
    type = string
}

variable "cores" {
    type = number
}

variable "cpu_type" {
    type = string
}

variable "memory" {
    type = number
}

variable "qemu_agent" {
    type = bool
}

variable "scsi_controller" {
    type = string
}

variable "network_adapter_model" {
    type = string
}

variable "network_adapter_firewall" {
    type = bool
}

variable "boot_iso_type" {
    type = string
}

variable "boot_iso_unmount" {
    type = bool
}

variable "root_disk_size" {
    type = string
}

variable "root_disk_format" {
    type = string
}

variable "root_disk_type" {
    type = string
}

variable "cloudinit_cd_label" {
    type = string
}

variable "cloudinit_iso_unmount" {
    type = string
}

variable "vm_boot_order" {
    type = string
}

variable "vm_boot_wait" {
    type = string
}

variable "vm_boot_command" {
    type = list(string)
}

variable "communicator_type" {
    type = string
}

variable "communicator_port" {
    type = number
}

variable "communicator_timeout" {
    type = string
}

variable "vm_guest_os_keyboard" {
    type = string
}

variable "vm_guest_os_language" {
    type = string
}

variable "vm_guest_os_timezone" {
    type = string
}

variable "cloudinit_apt_packages" {
    type = list(string)
}
