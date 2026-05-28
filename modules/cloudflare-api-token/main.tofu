terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.19.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12"
    }
  }
}

data "cloudflare_api_token_permission_groups_list" "all" {}

locals {
  _permission_groups_grouped = {
    for pg in data.cloudflare_api_token_permission_groups_list.all.result :
    pg.name => pg.id...
  }
  permission_groups_by_name = {
    for name, ids in local._permission_groups_grouped :
    name => ids[0]
  }
}

resource "time_rotating" "expiry" {
  rotation_days = var.rotation_days
}

resource "cloudflare_api_token" "this" {
  name = var.name
  policies = [
    for policy in var.policies : {
      effect = policy.effect
      permission_groups = [
        for name in policy.permission_groups : {
          id = local.permission_groups_by_name[name]
        }
      ]
      resources = jsonencode(policy.resources)
    }
  ]
  condition  = var.condition
  expires_on = timeadd(time_rotating.expiry.rfc3339, "${var.validity_days * 24}h")
}
