# standard configuration values from Vault
locals {
    build_username          = vault("proxmox/data/packer-pve-data", "build_username")
    cloudinit_storage_pool  = vault("proxmox/data/packer-pve-data", "cloudinit_storage_pool")
    iso_storage_pool        = vault("proxmox/data/packer-pve-data", "iso_storage_pool")
    iso_storage_type        = vault("proxmox/data/packer-pve-data", "iso_storage_type")
    nic_bridge              = vault("proxmox/data/packer-pve-data", "nic_bridge")
    nic_vlan_tag            = vault("proxmox/data/packer-pve-data", "nic_vlan_tag")
    ssh_public_key          = vault("proxmox/data/packer-pve-data", "ssh_public_key")
    vm_storage_pool         = vault("proxmox/data/packer-pve-data", "vm_storage_pool")

    proxmox_url             = vault("proxmox/data/packer-pve-auth", "url")
    proxmox_username        = vault("proxmox/data/packer-pve-auth", "username")
    proxmox_insecure_tls    = vault("proxmox/data/packer-pve-auth", "insecure_tls")
}

local "build_password_hashed" {
    expression = vault("proxmox/data/packer-pve-data", "build_password_hashed")
    sensitive = true
}

local "proxmox_token" {
    expression = vault("proxmox/data/packer-pve-auth", "token")
    sensitive  = true
}

locals {
    timestamp               = formatdate("DD-MMM-YYYY hh:mm ZZZ", timestamp())
    template_description    = format("%s. Build date: %s", var.template_description, local.timestamp)
    iso_path                = "${local.iso_storage_pool}:${local.iso_storage_type}/${var.install_iso_file}"
    build_ssh_private_key   = data.sshkey.packer.private_key_path
    build_ssh_public_key    = data.sshkey.packer.public_key
    data_source_content = {
        "/meta-data"                = file("${abspath(path.root)}/data/meta-data")
        "/user-data"                = templatefile("${abspath(path.root)}/data/user-data.pkrtpl.hcl", {
            apt_packages            = var.cloudinit_apt_packages
            build_password_hashed   = local.build_password_hashed
            build_username          = local.build_username
            ssh_keys                = concat([local.ssh_public_key], [local.build_ssh_public_key])
            vm_guest_os_hostname    = var.template_name
            vm_guest_os_keyboard    = var.vm_guest_os_keyboard
            vm_guest_os_language    = var.vm_guest_os_language
            vm_guest_os_timezone    = var.template_name
        })
    }
}
