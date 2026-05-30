data "cloudflare_zone" "this" {
  filter = { name = var.zone_name }
}

locals {
  srv_records     = { for k, v in var.records : k => v if v.type == "SRV" }
  non_srv_records = { for k, v in var.records : k => v if v.type != "SRV" }
}

resource "cloudflare_dns_record" "standard" {
  for_each = local.non_srv_records

  zone_id  = data.cloudflare_zone.this.id
  name     = each.value.name
  type     = each.value.type
  content  = each.value.value
  ttl      = each.value.ttl
  proxied  = each.value.type == "A" || each.value.type == "AAAA" || each.value.type == "CNAME" ? each.value.proxied : false
  priority = each.value.priority
  comment  = each.value.comment
}

resource "cloudflare_dns_record" "srv" {
  for_each = local.srv_records

  zone_id  = data.cloudflare_zone.this.id
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
