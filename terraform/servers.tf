resource "hcloud_server" "full_nodes" {
  count       = length(var.node_names)
  name        = var.node_names[count.index]
  server_type = var.server_type
  image       = "ubuntu-22.04"
  location    = var.server_locations[count.index]

  user_data = <<-EOF
    #cloud-config
    packages:
      - nvme-cli
      - build-essential
    mounts:
      - ["/dev/nvme0n1", "/mnt/polkadot_full_node_data", "ext4", "defaults,nofail", "0", "2"]
    fs_setup:
      - device: /dev/nvme0n1
        partition: auto
        filesystem: ext4
    users:
      - name: polkadot
        gecos: Polkadot User
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        lock_passwd: false
        passwd: ${bcrypt(var.polkadot_user_password)}
        ssh_authorized_keys:
          - ${file("~/.ssh/id_ed25519.pub")} # Otherwise replace with your public key

    write_files:
      - path: /etc/ssh/sshd_config
        content: |
          Port ${var.ssh_port}
          PermitRootLogin yes
          PasswordAuthentication yes
          PubkeyAuthentication yes

    runcmd:
      - systemctl restart sshd
  EOF
}

resource "hcloud_firewall" "ssh_firewall" {
  name = "ssh-firewall"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = var.ssh_port
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  dynamic "apply_to" {
    for_each = toset(hcloud_server.full_nodes[*].id)

    content {
      server = apply_to.value
    }
  }
}
