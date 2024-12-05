source "proxmox-iso" "ubuntu-server-noble-numbat" {

    proxmox_url = "${local.proxmox_url}"
    username = "${local.proxmox_username}"
    token = "${local.proxmox_token}"
    insecure_skip_tls_verify = "${var.proxmox_insecure_tls}"

    node = "${var.proxmox_node}"
    vm_id = "${var.vm_id}"
    vm_name = "packer-ubuntu-noble-2404"

    template_description = "${local.template_description}"
    template_name = "${var.template_name}"

    cores = "1"
    memory = "2048"
    
    qemu_agent = true
    scsi_controller = "virtio-scsi-pci"

    boot_iso {
        type = "scsi"
        iso_file = "${var.proxmox_iso_storage_pool}:${var.proxmox_iso_storage_type}/${var.iso_template_name}"
        unmount = true
        iso_checksum = "${var.iso_checksum}"
    }

    disks {
        disk_size = "20G"
        format = "raw"
        storage_pool = "local-lvm"
        type = "virtio"
    }

    network_adapters {
        model = "virtio"
        bridge = "vmbr0"
        firewall = "false"
    }

    boot_command = [
        "<esc><wait>",
        "e<wait>",
        "<down><down><down><end>",
        "<bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
    ]
    
    boot = "order=scsi0;ide2"
    boot_wait = "5s"

    http_directory = "http"
    #http_bind_address = "10.1.149.166"
    http_port_min = 8802
    http_port_max = 8802
    
    ssh_username = "packer"
    ssh_password = "packer
    ssh_timeout = "30m"

    # cloud_init = true
    # cloud_init_storage_pool = "local-lvm"
}
