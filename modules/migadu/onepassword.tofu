locals {
  op_vault_names = toset([for k, v in local.managed_password_mailboxes : v.managed_password.onepassword.vault])
}

data "onepassword_vault" "this" {
  for_each = local.op_vault_names
  name     = each.key
}

resource "onepassword_item" "mailbox" {
  for_each = local.managed_password_mailboxes

  vault    = data.onepassword_vault.this[each.value.managed_password.onepassword.vault].uuid
  title    = coalesce(each.value.managed_password.onepassword.item, "Migadu - ${title(each.value.name)}")
  category = "login"

  username = "${each.key}@${var.domain_name}"
  password = random_password.mailbox[each.key].result

  note_value = "This item is managed by github.com/mirceanton/cloud-terraform. Do not edit it manually."
}
