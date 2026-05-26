output "zone_id" {
  description = "The zone ID"
  value       = cloudflare_zone.this.id
}

output "zone_name" {
  description = "The zone name"
  value       = var.zone_name
}

output "name_servers" {
  description = "Cloudflare nameservers for this zone"
  value       = cloudflare_zone.this.name_servers
}

output "status" {
  description = "Zone status"
  value       = cloudflare_zone.this.status
}