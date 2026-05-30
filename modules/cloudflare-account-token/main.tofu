data "cloudflare_account_api_token_permission_groups_list" "all" {
  account_id = var.account_id
}

locals {
  _permission_groups_grouped = {
    for pg in data.cloudflare_account_api_token_permission_groups_list.all.result :
    pg.name => pg.id...
  }
  permission_groups_by_name = {
    for name, ids in local._permission_groups_grouped :
    name => ids[0]
  }
}

resource "time_rotating" "expiry" {
  for_each      = var.tokens
  rotation_days = each.value.rotation_days
}

resource "cloudflare_account_token" "this" {
  for_each = var.tokens

  account_id = var.account_id
  name       = each.key

  policies = [
    for policy in each.value.policies : {
      effect = policy.effect
      permission_groups = [
        for name in policy.permission_groups : {
          id = local.permission_groups_by_name[name]
        }
      ]
      resources = jsonencode(policy.resources)
    }
  ]

  condition  = each.value.condition
  expires_on = timeadd(time_rotating.expiry[each.key].rfc3339, "${each.value.validity_days * 24}h")
}
