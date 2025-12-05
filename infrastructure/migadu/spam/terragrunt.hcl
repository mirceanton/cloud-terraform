include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "migadu" {
  path   = find_in_parent_folders("migadu.hcl")
  expose = true
}

locals {
  dir_name = basename(get_terragrunt_dir())
}

terraform {
  source = find_in_parent_folders("modules/migadu-mailbox")
}

inputs = {
  name                    = title(local.dir_name)
  local_part              = local.dir_name
  aliases                 = ["junk"]
  may_send                = false
  domain_name             = include.migadu.locals.domain_name
  password_recovery_email = include.migadu.locals.migadu_api_email

  # API credentials
  migadu_api_email = include.migadu.locals.migadu_api_email
  migadu_api_token = include.migadu.locals.migadu_api_token
}