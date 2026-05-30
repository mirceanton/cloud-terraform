variable "domain_name" {
  description = "The domain name for all mailboxes"
  type        = string
}

variable "password_recovery_email" {
  description = "Email address for password recovery, shared across all mailboxes"
  type        = string
}

variable "mailboxes" {
  description = "Map of mailboxes to create. Map key is the local_part (e.g. 'mircea' for mircea@example.com)."
  type = map(object({
    name                    = string
    may_receive             = optional(bool, true)
    may_send                = optional(bool, true)
    may_access_imap         = optional(bool, true)
    may_access_pop3         = optional(bool, false)
    may_access_manage_sieve = optional(bool, false)
    spam_action             = optional(string, "folder")
    spam_aggressiveness     = optional(string, "default")
    aliases                 = optional(list(string), [])
  }))
  default = {}
}
