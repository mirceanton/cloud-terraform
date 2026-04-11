resource "time_rotating" "rotation" {
  rotation_days = coalesce(var.rotation_days, 36500)
}

resource "b2_application_key" "this" {
  key_name     = var.key_name
  capabilities = var.capabilities
  bucket_ids   = length(var.bucket_ids) > 0 ? var.bucket_ids : null
  name_prefix  = var.name_prefix

  lifecycle {
    replace_triggered_by = [time_rotating.rotation]
  }
}
