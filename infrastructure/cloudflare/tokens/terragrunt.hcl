include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/cloudflare-account-token"
}

dependency "mirceanton_com" {
  config_path = "../zones/mirceanton.com"

  mock_outputs                            = { zone_id = "00000000000000000000000000000000" }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "mirceaanton_com" {
  config_path = "../zones/mirceaanton.com"

  mock_outputs                            = { zone_id = "11111111111111111111111111111111" }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
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
        permission_groups = ["DNS Write", "Zone Read"]
        resources         = { "com.cloudflare.api.account.zone.${dependency.mirceanton_com.outputs.zone_id}" = "*" }
      }]
      onepassword = {
        vault = "kubernetes-home-ops"
        item  = "CertManager - Cloudflare API Token"
      }
    }

    "public-cert-manager" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write", "Zone Read"]
        resources         = { "com.cloudflare.api.account.zone.${dependency.mirceanton_com.outputs.zone_id}" = "*" }
      }]
      onepassword = {
        vault = "kubernetes-public"
        item  = "CertManager - Cloudflare API Token"
      }
    }

    "public-external-dns" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write", "Zone Read"]
        resources         = { "com.cloudflare.api.account.zone.${dependency.mirceanton_com.outputs.zone_id}" = "*" }
      }]
      onepassword = {
        vault = "kubernetes-public"
        item  = "ExternalDNS - Cloudflare API Token"
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
        permission_groups = ["DNS Write", "Zone Read"]
        resources         = { "com.cloudflare.api.account.zone.${dependency.mirceanton_com.outputs.zone_id}" = "*" }
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
        permission_groups = ["DNS Write", "Zone Read"]
        resources         = { "com.cloudflare.api.account.zone.${dependency.mirceanton_com.outputs.zone_id}" = "*" }
      }]
      onepassword = {
        vault = "truenas-terraform"
        item  = "ACME DNS - Cloudflare Token"
      }
    }

    "mikrotik-terraform-dns" = {
      rotation_days = 5
      validity_days = 7
      policies = [{
        permission_groups = ["DNS Write", "Zone Read"]
        resources = {
          "com.cloudflare.api.account.zone.${dependency.mirceanton_com.outputs.zone_id}"  = "*"
          "com.cloudflare.api.account.zone.${dependency.mirceaanton_com.outputs.zone_id}" = "*"
        }
      }]
      onepassword = {
        vault = "mikrotik-terraform"
        item  = "Cloudflare DNS Token"
      }
    }
  }
}
