terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.12.0"
    }
  }
}

resource "b2_application_key" "this" {
  key_name     = var.key_name
  capabilities = var.capabilities
  bucket_ids   = length(var.bucket_ids) > 0 ? var.bucket_ids : null
  name_prefix  = var.name_prefix
}
