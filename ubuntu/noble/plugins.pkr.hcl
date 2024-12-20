packer {
  required_version = ">= 1.10"
  required_plugins {
    proxmox = {
      version = "= 1.2.0"
      source  = "github.com/hashicorp/proxmox"
    }
    ssh-key = {
      version = ">= 1.2.0"
      source  = "github.com/ivoronin/sshkey"
    }
  }
}

data "sshkey" "packer" {
  type  = "ed25519"
  name  = "packer_key"
}