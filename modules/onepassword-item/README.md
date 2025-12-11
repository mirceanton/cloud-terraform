# onepassword-item

Store credentials and secrets in 1Password vaults, useful for persisting Terraform-generated secrets (API keys, passwords, etc.).

## Resources

- `onepassword_item.this` - The 1Password item
- `onepassword_vault.this` (data) - Vault lookup by name

## Inputs

| Name         | Description                   | Type           | Required | Default          |
| ------------ | ----------------------------- | -------------- | -------- | ---------------- |
| `vault_name` | Name of the 1Password vault   | `string`       | yes      | -                |
| `item_title` | Title of the 1Password item   | `string`       | yes      | -                |
| `category`   | Item category                 | `string`       | no       | `api_credential` |
| `fields`     | Map of field labels to values | `map(string)`  | no       | `{}`             |
| `tags`       | Tags to apply to the item     | `list(string)` | no       | `[]`             |
| `url`        | URL associated with the item  | `string`       | no       | `null`           |

### Category Options

- `login`
- `password`
- `secure_note`
- `api_credential`

## Outputs

None.
