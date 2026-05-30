resource "b2_bucket" "this" {
  for_each    = var.buckets
  bucket_name = each.key
  bucket_type = each.value.bucket_type
  bucket_info = each.value.bucket_info

  dynamic "lifecycle_rules" {
    for_each = each.value.lifecycle_rules
    content {
      file_name_prefix              = lifecycle_rules.value.file_name_prefix
      days_from_uploading_to_hiding = lifecycle_rules.value.days_from_uploading_to_hiding
      days_from_hiding_to_deleting  = lifecycle_rules.value.days_from_hiding_to_deleting
    }
  }

  dynamic "cors_rules" {
    for_each = each.value.cors_rules
    content {
      cors_rule_name     = cors_rules.value.cors_rule_name
      allowed_origins    = cors_rules.value.allowed_origins
      allowed_headers    = cors_rules.value.allowed_headers
      allowed_operations = cors_rules.value.allowed_operations
      max_age_seconds    = cors_rules.value.max_age_seconds
    }
  }
}
