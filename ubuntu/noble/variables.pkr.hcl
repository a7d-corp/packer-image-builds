variable "proxmox_insecure_tls" {
    type = bool
}

variable "iso_template_name" {
    type = string
}

variable "proxmox_iso_storage_pool" {
    type = string
}

variable "proxmox_iso_storage_type" {
    type = string
}

variable "iso_checksum" {
    type = string
}

variable "template_description" {
    type = string
}

variable "template_name" {
    type = string
}

variable "proxmox_node" {
    type = string
}

variable "vm_id" {
    type = string
}
