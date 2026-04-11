output "key_id" {
  description = "The application key ID"
  value       = b2_application_key.this.application_key_id
}

output "key_secret" {
  description = "The application key secret"
  value       = b2_application_key.this.application_key
  sensitive   = true
}

output "rotation_timestamp" {
  description = "RFC3339 timestamp of the next scheduled rotation"
  value       = time_rotating.rotation.rotation_rfc3339
}
