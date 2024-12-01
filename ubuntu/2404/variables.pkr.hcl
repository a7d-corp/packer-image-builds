variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type = string
  sensitive = true
}

variable "proxmox_insecure_tls" {
  type = bool
  default = true
}


variable "iso_template_name" {
  type = string
}


