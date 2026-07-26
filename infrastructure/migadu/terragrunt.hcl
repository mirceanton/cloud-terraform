include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  domain_name    = "mirceanton.com"
  recovery_email = "mircea.pavel.anton@gmail.com"
}

terraform {
  source = "${get_repo_root()}/modules/migadu"
}

inputs = {
  domain_name             = local.domain_name
  password_recovery_email = local.recovery_email

  mailboxes = {
    "mircea" = {
      name    = "Personal"
      aliases = ["me", "personal", "business", "contact"]
    }

    "homelab" = {
      name    = "HomeLab"
      aliases = ["affine"]
    }

    "spam" = {
      name     = "Spam"
      may_send = false
      aliases  = ["junk"]
    }
  }
}
