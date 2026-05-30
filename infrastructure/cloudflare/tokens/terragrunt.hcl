include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/cloudflare-account-token"
}

locals {
  account_id = get_env("CLOUDFLARE_ACCOUNT_ID")
}

inputs = {
  account_id = local.account_id

  tokens = {
    "home-ops-cert-manager" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
    }

    "home-ops-crd-schemas" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["Pages Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
    }

    "home-ops-external-dns" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
    }

    "pve-certbot" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
    }

    "truenas-certbot" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
    }
  }
}
