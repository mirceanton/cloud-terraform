locals {
  op_tokens      = { for k, v in var.tokens : k => v if v.onepassword != null }
  op_vault_names = toset([for k, v in local.op_tokens : v.onepassword.vault])
}

data "onepassword_vault" "this" {
  for_each = local.op_vault_names
  name     = each.key
}

resource "onepassword_item" "token" {
  for_each = local.op_tokens

  vault    = data.onepassword_vault.this[each.value.onepassword.vault].uuid
  title    = each.value.onepassword.item
  category = "login"

  username = var.account_id
  password = cloudflare_account_token.this[each.key].value

  note_value = "This item is managed by github.com/mirceanton/cloud-terraform. Do not edit it manually."
}
