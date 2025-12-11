include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/backblaze-bucket"
}

inputs = {
  bucket_name = basename(get_terragrunt_dir())
  bucket_type = "allPrivate"
  lifecycle_rules = [
    {
      file_name_prefix             = ""
      days_from_hiding_to_deleting = 31
    }
  ]
}