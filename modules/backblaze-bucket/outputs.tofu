output "bucket_id" {
  description = "The bucket ID"
  value       = b2_bucket.this.bucket_id
}

output "bucket_name" {
  description = "The bucket name"
  value       = b2_bucket.this.bucket_name
}

output "app_key_id" {
  description = "The application key ID"
  value       = b2_application_key.this.application_key_id
}

output "app_key_secret" {
  description = "The application key secret"
  value       = b2_application_key.this.application_key
  sensitive   = true
}

# Convenience: all creds bundled for 1Password
output "credentials" {
  description = "All credentials for injection into secret stores"
  value = {
    bucket_name    = b2_bucket.this.bucket_name
    bucket_id      = b2_bucket.this.bucket_id
    key_id         = b2_application_key.this.application_key_id
    key_secret     = b2_application_key.this.application_key
    s3_endpoint    = "s3.eu-central-003.backblazeb2.com"
  }
  sensitive = true
}