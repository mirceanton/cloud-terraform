resource "b2_bucket" "this" {
  bucket_name = var.bucket_name
  bucket_type = var.bucket_type
  bucket_info = var.bucket_info

  dynamic "lifecycle_rules" {
    for_each = var.lifecycle_rules
    content {
      file_name_prefix              = lifecycle_rules.value.file_name_prefix
      days_from_uploading_to_hiding = lifecycle_rules.value.days_from_uploading_to_hiding
      days_from_hiding_to_deleting  = lifecycle_rules.value.days_from_hiding_to_deleting
    }
  }

  dynamic "cors_rules" {
    for_each = var.cors_rules
    content {
      cors_rule_name     = cors_rules.value.cors_rule_name
      allowed_origins    = cors_rules.value.allowed_origins
      allowed_headers    = cors_rules.value.allowed_headers
      allowed_operations = cors_rules.value.allowed_operations
      max_age_seconds    = cors_rules.value.max_age_seconds
    }
  }
}

resource "time_rotating" "key_rotation" {
  for_each      = var.keys
  rotation_days = coalesce(each.value.rotation_days, 36500)
}

resource "b2_application_key" "this" {
  for_each     = var.keys
  key_name     = each.key
  capabilities = each.value.capabilities
  bucket_ids   = [b2_bucket.this.bucket_id]
  name_prefix  = each.value.name_prefix

  lifecycle {
    replace_triggered_by = [time_rotating.key_rotation[each.key]]
  }
}
