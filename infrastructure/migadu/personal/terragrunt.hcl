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
  aliases                 = ["me", "personal", "business", "contact"]
  domain_name             = include.migadu.locals.domain_name
  password_recovery_email = include.migadu.locals.recovery_email
}