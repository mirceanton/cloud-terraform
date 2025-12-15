# backblaze-appkey

Creates a Backblaze B2 application key with automatic rotation.

## Resources

- `b2_application_key.this` - The B2 application key
- `time_rotating.rotation` - Handles automatic key rotation

## Inputs

| Name            | Description                           | Type           | Required | Default |
| --------------- | ------------------------------------- | -------------- | -------- | ------- |
| `key_name`      | Name for the application key          | `string`       | yes      | -       |
| `capabilities`  | Capabilities for the application key  | `list(string)` | yes      | -       |
| `bucket_id`     | Bucket ID to scope the key to         | `string`       | no       | `[]`    |
| `name_prefix`   | Prefix for files the key can access   | `string`       | no       | `null`  |
| `rotation_days` | Days before the key should be rotated | `number`       | no       | `null`  |

## Outputs

| Name                 | Description                                           |
| -------------------- | ----------------------------------------------------- |
| `key_id`             | The application key ID                                |
| `key_secret`         | The application key secret (sensitive)                |
| `key_name`           | The application key name                              |
| `capabilities`       | The application key capabilities                      |
| `credentials`        | All credentials bundled for secret stores (sensitive) |
| `rotation_timestamp` | Timestamp when the key will next be rotated           |
