resource "cloudflare_record" "a_root" {
  zone_id = var.cloudflare_zone_id
  name    = "treant.dev"
  type    = "A"
  content = hcloud_server.peach.ipv4_address
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "a_wildcard" {
  zone_id = var.cloudflare_zone_id
  name    = "*"
  type    = "A"
  content = hcloud_server.peach.ipv4_address
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "aaaa_root" {
  zone_id = var.cloudflare_zone_id
  name    = "treant.dev"
  type    = "AAAA"
  content = hcloud_server.peach.ipv6_address
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "aaaa_wildcard" {
  zone_id = var.cloudflare_zone_id
  name    = "*"
  type    = "AAAA"
  content = hcloud_server.peach.ipv6_address
  ttl     = 1
  proxied = false
}