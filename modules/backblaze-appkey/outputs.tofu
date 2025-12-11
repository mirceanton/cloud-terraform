output "key_id" {
  description = "The application key ID"
  value       = b2_application_key.this.application_key_id
}

output "key_secret" {
  description = "The application key secret"
  value       = b2_application_key.this.application_key
  sensitive   = true
}

output "key_name" {
  description = "The application key name"
  value       = b2_application_key.this.key_name
}

output "capabilities" {
  description = "The application key capabilities"
  value       = b2_application_key.this.capabilities
}

# Convenience: all creds bundled for secret stores
output "credentials" {
  description = "All credentials for injection into secret stores"
  value = {
    key_name   = b2_application_key.this.key_name
    key_id     = b2_application_key.this.application_key_id
    key_secret = b2_application_key.this.application_key
  }
  sensitive = true
}

output "rotation_timestamp" {
  description = "The timestamp when the key will next be rotated"
  value       = time_rotating.rotation.rotation_rfc3339
}
