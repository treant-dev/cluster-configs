output "k8s_master_ip" {
  value = hcloud_server.k8s_master.ipv4_address
}

output "k8s_ingress_ip" {
  value = hcloud_server.k8s_ingress.ipv4_address
}

output "k8s_worker_ip" {
  value = hcloud_server.k8s_worker.ipv4_address
}

output "k8s_ingress_ipv6" {
  value = hcloud_server.k8s_ingress.ipv6_address
}