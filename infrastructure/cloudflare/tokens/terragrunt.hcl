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
      onepassword = {
        vault = "kubernetes-home-ops"
        item  = "CertManager - Cloudflare API Token"
      }
    }

    "home-ops-crd-schemas" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["Pages Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
      onepassword = {
        vault = "kubernetes-home-ops"
        item  = "CRD Schemas - Cloudflare Token"
      }
    }

    "pve-certbot" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
      # TODO
      # onepassword = {
      #   vault = "terraform-proxmox"
      #   item  = "pve-certbot - Cloudflare API Token"
      # }
    }

    "truenas-certbot" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
      onepassword = {
        vault = "truenas-terraform"
        item  = "ACME DNS - Cloudflare Token"
      }
    }

    "truenas-zipline-tunnel" = {
      rotation_days = 31
      validity_days = 33
      policies = [{
        permission_groups = ["Cloudflare Tunnel Write", "DNS Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
      onepassword = {
        vault = "truenas-terraform"
        item  = "Zipline Cloudflare Tunnel Token"
      }
    }

    "mikrotik-terraform-dns" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write"]
        resources         = { "com.cloudflare.api.account.${local.account_id}" = "*" }
      }]
      onepassword = {
        vault = "mikrotik-terraform"
        item  = "Cloudflare DNS Token"
      }
    }
  }
}
