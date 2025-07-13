data "hcloud_ssh_key" "infra_ssh_key" {
  name = "kostikov.konstantin.a@gmail.com"
}

resource "hcloud_network" "k8s_network" {
  name     = "k8s-network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "k8s_subnet" {
  network_id    = hcloud_network.k8s_network.id
  type          = "cloud"
  network_zone  = "eu-central"
  ip_range      = "10.0.0.0/24"
}

resource "hcloud_server" "k8s_master" {
  name        = "k8s-master"
  server_type = "cx22"
  image       = "ubuntu-22.04"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.infra_ssh_key.id]
  network {
    network_id = hcloud_network.k8s_network.id
  }
}

resource "hcloud_server" "k8s_ingress" {
  name        = "k8s-ingress"
  server_type = "cx22"
  image       = "ubuntu-22.04"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.infra_ssh_key.id]
  network {
    network_id = hcloud_network.k8s_network.id
  }
}

resource "hcloud_server" "k8s_worker" {
  name        = "k8s-worker"
  server_type = "cx32"
  image       = "ubuntu-22.04"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.infra_ssh_key.id]
  network {
    network_id = hcloud_network.k8s_network.id
  }
}