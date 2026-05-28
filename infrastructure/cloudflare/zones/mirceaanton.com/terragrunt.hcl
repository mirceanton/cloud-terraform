include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  domain = basename(get_terragrunt_dir())
}

terraform {
  source = find_in_parent_folders("modules/cloudflare-zone")
}

inputs = {
  zone_name  = local.domain
  account_id = get_env("CLOUDFLARE_ACCOUNT_ID")
}