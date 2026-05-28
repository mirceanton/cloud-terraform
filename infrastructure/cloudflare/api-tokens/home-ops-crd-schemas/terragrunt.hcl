include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = find_in_parent_folders("modules/cloudflare-api-token")
}

inputs = {
  name = basename(get_terragrunt_dir())

  # rotate the token every 5 days, but keep it valid for 7 days to allow
  # for a smooth transition between old and new tokens
  rotation_days = 5
  validity_days = 7

  policies = [{
    permission_groups = ["Pages Write"]
    resources = { "com.cloudflare.api.account.*" = "*" }
  }]
}
