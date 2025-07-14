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

resource "hcloud_server" "oak" {
  name        = "oak"
  server_type = "cx22"
  image       = "centos-stream-10"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.infra_ssh_key.id]
  user_data = file(var.cloud_init_path)

  network {
    network_id = hcloud_network.k8s_network.id
  }
}

resource "hcloud_server" "peach" {
  name        = "peach"
  server_type = "cx22"
  image       = "centos-stream-10"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.infra_ssh_key.id]
  user_data = file(var.cloud_init_path)

  network {
    network_id = hcloud_network.k8s_network.id
  }
}

resource "hcloud_server" "cherry" {
  count       = 1
  name        = "cherry-${count.index}"
  server_type = "cx32"
  image       = "centos-stream-10"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.infra_ssh_key.id]
  user_data = file(var.cloud_init_path)

  network {
    network_id = hcloud_network.k8s_network.id
  }
}