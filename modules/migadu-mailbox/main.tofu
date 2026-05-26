terraform {
  required_providers {
    migadu = {
      source = "metio/migadu"
      version = "2026.5.14"
    }
  }
}

resource "migadu_mailbox" "mailbox" {
  name                    = var.name
  local_part              = var.local_part
  domain_name             = var.domain_name

  # Spam settings
  spam_action              = var.spam_action
  spam_aggressiveness   = var.spam_aggressiveness

  # Access permissions
  may_receive             = var.may_receive
  may_send                = var.may_send
  may_access_imap         = var.may_access_imap
  may_access_pop3         = var.may_access_pop3
  may_access_manage_sieve  = var.may_access_manage_sieve

  password_recovery_email = var.password_recovery_email
}

resource "migadu_alias" "aliases" {
  for_each = toset(var.aliases)

  domain_name  = var.domain_name
  local_part   = each.value
  destinations = ["${var.local_part}@${var.domain_name}"]
}