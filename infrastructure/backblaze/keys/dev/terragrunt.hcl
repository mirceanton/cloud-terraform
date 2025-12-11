include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "capabilities" {
  path   = find_in_parent_folders("capabilities.hcl")
  expose = true
}

terraform {
  source = find_in_parent_folders("modules/backblaze-appkey")
}

inputs = {
  key_name     = basename(get_terragrunt_dir())
  bucket_ids   = [] #! allow access to all buckets
  capabilities = include.capabilities.locals.admin_capabilities
}
