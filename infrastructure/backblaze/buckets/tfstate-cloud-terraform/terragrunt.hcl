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
      file_name_prefix             = ""
      days_from_hiding_to_deleting = 31
    }
  ]

  keys = {
    #? Note: dev key is created manually
    "tfstate-cloud-terraform-ci" = {
      capabilities  = include.capabilities.locals.full_capabilities
      rotation_days = 7
    }
  }
}
