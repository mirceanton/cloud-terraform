output "buckets" {
  description = "Map of created buckets, keyed by bucket name"
  value = {
    for k, b in b2_bucket.this : k => {
      bucket_id   = b.bucket_id
      bucket_name = b.bucket_name
    }
  }
}

output "keys" {
  description = "Map of generated application keys, keyed by key name"
  sensitive   = true
  value = {
    for k, key in b2_application_key.this : k => {
      key_id     = key.application_key_id
      key_secret = key.application_key
    }
  }
}
