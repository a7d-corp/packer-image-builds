build {
    name = "ubuntu-server-noble-numbat"
    sources = ["proxmox-iso.ubuntu-server-noble-numbat"]

  provisioner "shell" {
    inline = ["while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"]
  }

  provisioner "ansible" {
    playbook_file = "ansible/_run.yaml"
    user = local.build_username
    # force SCP to use the legacy protocol on newer versions
    # extra_arguments = [ "--scp-extra-args", "'-O'" ]
    # force SSH to use deprecated key algos
    # ansible_ssh_extra_args = [ "-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa" ]
  }

  provisioner "shell" {
    inline = [
      "sudo cloud-init clean",
      "sudo sync"
    ]
  }
}