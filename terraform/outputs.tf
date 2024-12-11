resource "local_file" "ansible_inventory" {
  content = yamlencode({
    all = {
      hosts = {
        for server in hcloud_server.full_nodes :
        server.name => {
          ansible_host = server.ipv4_address
          ansible_user = "polkadot"
          ansible_port = var.ssh_port

        }
      }
    }
  })
  filename = "${path.module}/../ansible/inventory.yml"
}

output "ansible_inventory" {
  value = local_file.ansible_inventory.content
}
