include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "capabilities" {
  path   = find_in_parent_folders("capabilities.hcl")
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules/backblaze-bucket"
}

inputs = {
  bucket_name = basename(get_terragrunt_dir())
  bucket_type = "allPrivate"
  bucket_info = {
    managed_by = "github.com/mirceanton/cloud-terraform"
  }

  lifecycle_rules = [
    {
      file_name_prefix              = ""
      days_from_uploading_to_hiding = 0
      days_from_hiding_to_deleting  = 1
    }
  ]

  keys = {
    "obsidian-sync-mobile" = {
      capabilities  = include.capabilities.locals.full_capabilities
      rotation_days = 90
    }
    "obsidian-sync-desktop" = {
      capabilities  = include.capabilities.locals.full_capabilities
      rotation_days = 90
    }
  }
}
