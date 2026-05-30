locals {
  op_keys        = { for k, v in var.keys : k => v if v.onepassword != null }
  op_vault_names = toset([for k, v in local.op_keys : v.onepassword.vault])
}

data "onepassword_vault" "this" {
  for_each = local.op_vault_names
  name     = each.key
}

resource "onepassword_item" "key" {
  for_each = local.op_keys

  vault    = data.onepassword_vault.this[each.value.onepassword.vault].uuid
  title    = each.value.onepassword.item
  category = "login"

  username = b2_application_key.this[each.key].application_key_id
  password = b2_application_key.this[each.key].application_key

  note_value = "This item is managed by github.com/mirceanton/cloud-terraform. Do not edit it manually."
}
