source "proxmox-iso" "ubuntu-server-noble-numbat" {

    # Proxmox API config
    proxmox_url                 = local.proxmox_url
    username                    = local.proxmox_username
    token                       = local.proxmox_token
    insecure_skip_tls_verify    = local.proxmox_insecure_tls

    # general template config
    node                    = var.proxmox_node  # passed on the commandline at build-time
    vm_id                   = var.vm_id         # passed on the commandline at build-time
    vm_name                 = var.template_name

    template_description    = local.template_description
    template_name           = var.template_name

    # VM spec
    cores               = var.cores
    cpu_type            = var.cpu_type
    memory              = var.memory
    qemu_agent          = var.qemu_agent
    scsi_controller     = var.scsi_controller

    # network devices
    network_adapters {
        model       = var.network_adapter_model
        bridge      = local.nic_bridge
        firewall    = var.network_adapter_firewall
        vlan_tag    = local.nic_vlan_tag
    }

    # Ubuntu setup iso
    boot_iso {
        type            = var.boot_iso_type
        iso_file        = local.iso_path
        unmount         = var.boot_iso_unmount
        iso_checksum    = var.install_iso_checksum
    }

    # root disk
    disks {
        disk_size       = var.root_disk_size
        format          = var.root_disk_format
        storage_pool    = local.vm_storage_pool
        type            = var.root_disk_type
    }

    # cloudinit iso
    additional_iso_files {
        cd_content          = local.data_source_content
        cd_label            = var.cloudinit_cd_label
        iso_storage_pool    = local.iso_storage_pool
        unmount             = var.cloudinit_iso_unmount
    }

    boot_command    = var.vm_boot_command
    boot            = var.vm_boot_order
    boot_wait       = var.vm_boot_wait

    communicator            = var.communicator_type
    ssh_private_key_file    = local.build_ssh_private_key
    ssh_port                = var.communicator_port
    ssh_timeout             = var.communicator_timeout
    ssh_username            = local.build_username
}
