locals {
  all_aliases = merge([
    for local_part, mb in var.mailboxes : {
      for alias in mb.aliases :
      "${local_part}:${alias}" => {
        alias_local_part   = alias
        mailbox_local_part = local_part
      }
    }
  ]...)
}

resource "migadu_mailbox" "mailbox" {
  for_each = var.mailboxes

  name                    = each.value.name
  local_part              = each.key
  domain_name             = var.domain_name
  spam_action             = each.value.spam_action
  spam_aggressiveness     = each.value.spam_aggressiveness
  may_receive             = each.value.may_receive
  may_send                = each.value.may_send
  may_access_imap         = each.value.may_access_imap
  may_access_pop3         = each.value.may_access_pop3
  may_access_manage_sieve = each.value.may_access_manage_sieve
  password_recovery_email = var.password_recovery_email
}

resource "migadu_alias" "aliases" {
  for_each = local.all_aliases

  domain_name  = var.domain_name
  local_part   = each.value.alias_local_part
  destinations = ["${each.value.mailbox_local_part}@${var.domain_name}"]
}
