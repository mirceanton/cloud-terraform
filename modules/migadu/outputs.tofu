output "mailboxes" {
  description = "Map of created mailboxes, keyed by local_part"
  value = {
    for k, mb in migadu_mailbox.mailbox : k => mb.id
  }
}

output "aliases" {
  description = "Map of created aliases, keyed as 'local_part:alias'"
  value = {
    for k, alias in migadu_alias.aliases : k => alias.id
  }
}
