
local "proxmox_url" {
    expression = vault("proxmox/data/packer-pve-auth", "url")
}

local "proxmox_username" {
    expression = vault("proxmox/data/packer-pve-auth", "username")
}

local "proxmox_token" {
    expression = vault("proxmox/data/packer-pve-auth", "token")
    sensitive  = true
}

local "timestamp" {
    expression = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

local "template_description" {
    expression = format("%s. Build date: %s", var.template_description, local.timestamp)
}