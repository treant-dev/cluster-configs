output "nodes" {
  description = "Nodes for Ansible inventory"
  value = merge(
    {
      oak = {
        public_ip  = hcloud_server.oak.ipv4_address
        roles      = ["worker"]
      }
      peach = {
        public_ip  = hcloud_server.peach.ipv4_address
        roles      = ["worker"]
      }
    },
    {
      for idx, s in hcloud_server.cherry :
      "cherry-${idx}" => {
        public_ip  = s.ipv4_address
        roles      = ["master"]
      }
    }
  )
}