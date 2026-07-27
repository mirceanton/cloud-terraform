resource "time_rotating" "mailbox_password" {
  for_each      = local.managed_password_mailboxes
  rotation_days = coalesce(each.value.managed_password.rotation_days, 90)
}

resource "random_password" "mailbox" {
  for_each = local.managed_password_mailboxes

  length      = 32
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1

  lifecycle {
    replace_triggered_by = [time_rotating.mailbox_password[each.key]]
  }
}
