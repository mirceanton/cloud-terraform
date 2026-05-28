output "token" {
  description = "The API token value"
  value       = cloudflare_api_token.this.value
  sensitive   = true
}

output "available_permission_groups" {
  description = "Sorted list of all Cloudflare permission group names valid for use in var.policies"
  value       = sort(keys(local.permission_groups_by_name))
  sensitive   = true
}
