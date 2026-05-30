output "tokens" {
  description = "Map of created API token values, keyed by token name"
  sensitive   = true
  value = {
    for k, t in cloudflare_account_token.this : k => t.value
  }
}

output "available_permission_groups" {
  description = "Sorted list of all Cloudflare permission group names valid for use in policies"
  sensitive   = true
  value       = sort(keys(local.permission_groups_by_name))
}
