output "bucket_id" {
  description = "The bucket ID"
  value       = b2_bucket.this.bucket_id
}

output "bucket_name" {
  description = "The bucket name"
  value       = b2_bucket.this.bucket_name
}
