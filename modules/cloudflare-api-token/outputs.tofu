output "token" {
  description = "The API token value"
  value       = cloudflare_api_token.this.value
  sensitive   = true
}
