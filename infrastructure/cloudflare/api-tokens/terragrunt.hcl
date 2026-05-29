include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/cloudflare-api-token"
}

inputs = {
  tokens = {
    "home-ops-cert-manager" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.zone.*" = "*" }
      }]
    }

    "home-ops-crd-schemas" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["Pages Write"]
        resources         = { "com.cloudflare.api.account.*" = "*" }
      }]
    }

    "home-ops-external-dns" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.zone.*" = "*" }
      }]
    }

    "pve-certbot" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.zone.*" = "*" }
      }]
    }

    "truenas-certbot" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.zone.*" = "*" }
      }]
    }
  }
}
