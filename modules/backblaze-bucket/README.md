# backblaze-bucket

Creates a Backblaze B2 storage bucket with optional lifecycle and CORS rules.

## Resources

- `b2_bucket.this` - The B2 storage bucket

## Inputs

| Name              | Description                                    | Type           | Required | Default      |
| ----------------- | ---------------------------------------------- | -------------- | -------- | ------------ |
| `bucket_name`     | Name of the B2 bucket                          | `string`       | yes      | -            |
| `bucket_type`     | Bucket visibility: `allPrivate` or `allPublic` | `string`       | no       | `allPrivate` |
| `lifecycle_rules` | Lifecycle rules for the bucket                 | `list(object)` | no       | `[]`         |
| `cors_rules`      | CORS rules for the bucket                      | `list(object)` | no       | `[]`         |

## Outputs

| Name          | Description     |
| ------------- | --------------- |
| `bucket_id`   | The bucket ID   |
| `bucket_name` | The bucket name |
