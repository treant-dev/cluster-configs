variable "hcloud_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_zone_id" {
  type = string
}

variable "ssh_key_name" {
  description = "Name of the existing SSH key in Hetzner"
  type        = string
}

variable "cloud_init_path" {
  description = "Path to the cloud-init file"
  type        = string
  default     = "cloud-init/centos-cloud-init.yml"
}