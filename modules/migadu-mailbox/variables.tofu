variable "name" {
  description = "Name of the mailbox (used for UI identification)"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the mailbox"
  type        = string
}

variable "may_receive" {
  description = "Whether the mailbox can receive emails"
  type        = bool
  default     = true
}

variable "may_send" {
  description = "Whether the mailbox can send emails"
  type        = bool
  default     = true
}

variable "may_access_imap" {
  description = "Whether the mailbox can be accessed via IMAP"
  type        = bool
  default     = true
}

variable "may_access_pop3" {
  description = "Whether the mailbox can be accessed via POP3"
  type        = bool
  default     = false
}

variable "may_access_manage_sieve" {
  description = "Whether the mailbox can be accessed via ManageSieve"
  type        = bool
  default     = false
}

variable "spam_action" {
  description = "Action to take on spam emails (e.g. 'folder', 'delete', 'none')"
  type        = string
  default     = "folder"
}

variable "spam_aggressiveness" {
  description = "Aggressiveness of the spam filter (e.g. 'default', 'low', 'high', 'aggressive')"
  type        = string
  default     = "default"
}

variable "local_part" {
  description = "The local part of the email address (before @)"
  type        = string
}

variable "password_recovery_email" {
  description = "Email address for password recovery"
  type        = string
}

variable "aliases" {
  description = "List of aliases where each entry is a local part. Aliases will be mapped to the main mailbox local part."
  type        = list(string)
  default     = []
}