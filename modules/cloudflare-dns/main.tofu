terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.13.0"
    }
  }
}

locals {
  # Separate SRV records (they need special handling)
  srv_records     = { for k, v in var.records : k => v if v.type == "SRV" }
  non_srv_records = { for k, v in var.records : k => v if v.type != "SRV" }
}

# Standard records (A, AAAA, CNAME, TXT, MX, etc.)
resource "cloudflare_dns_record" "standard" {
  for_each = local.non_srv_records

  zone_id  = var.zone_id
  name     = each.value.name
  type     = each.value.type
  content  = each.value.value
  ttl      = each.value.ttl
  proxied  = each.value.type == "A" || each.value.type == "AAAA" || each.value.type == "CNAME" ? each.value.proxied : false
  priority = each.value.priority
  comment  = each.value.comment
}

# SRV records (require data block)
resource "cloudflare_dns_record" "srv" {
  for_each = local.srv_records

  zone_id  = var.zone_id
  name     = each.value.name
  type     = "SRV"
  ttl      = each.value.ttl
  comment  = each.value.comment
  priority = each.value.priority
  proxied  = false

  data = {
    priority = each.value.priority
    weight   = each.value.weight
    port     = each.value.port
    target   = each.value.value
  }
}