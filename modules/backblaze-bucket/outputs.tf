output "bucket_id" {
  description = "The bucket ID"
  value       = b2_bucket.this.bucket_id
}

output "bucket_name" {
  description = "The bucket name"
  value       = b2_bucket.this.bucket_name
}

output "keys" {
  description = "Map of generated application keys, keyed by the name given in var.keys"
  sensitive   = true
  value = {
    for k, key in b2_application_key.this : k => {
      key_id     = key.application_key_id
      key_secret = key.application_key
    }
  }
}
