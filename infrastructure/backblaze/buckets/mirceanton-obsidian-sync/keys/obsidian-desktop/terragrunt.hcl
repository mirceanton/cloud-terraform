include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "capabilities" {
  path   = find_in_parent_folders("capabilities.hcl")
  expose = true
}

dependency "bucket" {
  config_path = "../.."

  mock_outputs = {
    bucket_id = "mock-bucket-id"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan", "destroy"]
}

terraform {
  source = find_in_parent_folders("modules/backblaze-appkey")
}

inputs = {
  key_name      = basename(get_terragrunt_dir())
  bucket_ids    = [dependency.bucket.outputs.bucket_id]
  capabilities  = include.capabilities.locals.readwrite_capabilities
  rotation_days = 180
}
