output "oak_ip" {
  value = hcloud_server.oak.ipv4_address
}

output "peach_ip" {
  value = hcloud_server.peach.ipv4_address
}

output "cherry_ips" {
  value = [
    for instance in hcloud_server.cherry : instance.ipv4_address
  ]
}