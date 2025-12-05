include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "migadu" {
  path   = find_in_parent_folders("migadu.hcl")
  expose = true
}

terraform {
  source = find_in_parent_folders("modules/migadu-mailbox")
}

inputs = {
  name                    = title(basename(get_terragrunt_dir()))
  local_part              = "mircea"
  domain_name             = include.migadu.locals.domain_name
  password_recovery_email = include.migadu.locals.migadu_api_email
  aliases                 = ["me", "personal", "business", "contact"]

  # API credentials
  migadu_api_email = include.migadu.locals.migadu_api_email
  migadu_api_token = include.migadu.locals.migadu_api_token
}