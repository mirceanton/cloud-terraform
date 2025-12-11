# migadu-mailbox

Provision email mailboxes on Migadu-hosted domains with configurable send/receive permissions and email aliases.

## Resources

- `migadu_mailbox.mailbox` - The email mailbox
- `migadu_alias.aliases` - Email aliases pointing to the mailbox

## Inputs

| Name                      | Description                        | Type           | Required | Default |
| ------------------------- | ---------------------------------- | -------------- | -------- | ------- |
| `name`                    | Display name of the mailbox        | `string`       | yes      | -       |
| `domain_name`             | The domain name for the mailbox    | `string`       | yes      | -       |
| `local_part`              | Local part of the email (before @) | `string`       | yes      | -       |
| `password_recovery_email` | Email for password recovery        | `string`       | yes      | -       |
| `may_receive`             | Can receive emails                 | `bool`         | no       | `true`  |
| `may_send`                | Can send emails                    | `bool`         | no       | `true`  |
| `may_access_imap`         | Can access via IMAP                | `bool`         | no       | `true`  |
| `aliases`                 | List of alias local parts          | `list(string)` | no       | `[]`    |

## Outputs

| Name         | Description                         |
| ------------ | ----------------------------------- |
| `mailbox_id` | The ID of the created mailbox       |
| `aliases`    | The aliases created for the mailbox |
