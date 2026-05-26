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
  local_part              = basename(get_terragrunt_dir())
  aliases                 = ["junk"]
  may_send                = false
  domain_name             = include.migadu.locals.domain_name
  password_recovery_email = include.migadu.locals.recovery_email
}