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
    # =============================================================================================
    # Personal Accounts
    # =============================================================================================
    "mircea" = {
      name             = "Personal"
      aliases          = ["me", "personal", "business", "contact"]
      managed_password = { rotation_days = 365 }
    }
    "spam" = {
      name             = "Spam"
      may_send         = false
      aliases          = ["junk"]
      managed_password = { rotation_days = 3650 }
    }

    # =============================================================================================
    # Bot Accounts
    # =============================================================================================
    "affine.bot" = {
      name    = "Affine",
      aliases = ["affine.mcp"]
      managed_password = {
        onepassword = {
          vault = "kubernetes-home-ops"
          item  = "Affine - SMTP"
        }
      }
    }
    "paperless.bot" = {
      name = "Paperless",
      managed_password = {
        onepassword = {
          vault = "kubernetes-home-ops"
          item  = "Paperless - SMTP"
        }
      }
    }
    "ldap.bot" = {
      name    = "LDAP",
      aliases = ["ldap.bot"]
      may_receive = false
      may_send    = true
      managed_password = {
        onepassword = {
          vault = "truenas-terraform"
          item  = "LLDAP SMTP"
        }
      }
    }
  }
}
