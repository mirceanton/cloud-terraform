resource "time_rotating" "key_rotation" {
  for_each      = var.keys
  rotation_days = coalesce(each.value.rotation_days, 36500)
}

resource "b2_application_key" "this" {
  for_each     = var.keys
  key_name     = each.key
  capabilities = each.value.capabilities
  bucket_id    = each.value.bucket_name != null ? b2_bucket.this[each.value.bucket_name].bucket_id : null
  name_prefix  = each.value.name_prefix

  lifecycle {
    replace_triggered_by = [time_rotating.key_rotation[each.key]]
  }
}
