terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.12.0"
    }
  }
}

resource "b2_bucket" "this" {
  bucket_name = var.bucket_name
  bucket_type = var.bucket_type
  bucket_info = {
    "managed_by" = "github.com/mirceanton/cloud-terraform"
  }

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

resource "b2_application_key" "this" {
  bucket_ids   = [b2_bucket.this.bucket_id]
  key_name     = coalesce(var.app_key_name, var.bucket_name)
  capabilities = var.app_key_capabilities
}