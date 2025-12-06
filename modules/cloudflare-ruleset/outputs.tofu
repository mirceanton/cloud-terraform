output "ruleset_id" {
  description = "ID of the created ruleset"
  value       = cloudflare_ruleset.redirects.id
}

output "ruleset_name" {
  description = "Name of the created ruleset"
  value       = cloudflare_ruleset.redirects.name
}