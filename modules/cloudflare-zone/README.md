# cloudflare-zone

Manages a Cloudflare DNS zone for a domain.

## Resources

- `cloudflare_zone.this` - The Cloudflare zone

## Inputs

| Name         | Description                                           | Type     | Required | Default |
| ------------ | ----------------------------------------------------- | -------- | -------- | ------- |
| `zone_name`  | The domain name of the zone                           | `string` | yes      | -       |
| `account_id` | The Cloudflare account ID                             | `string` | yes      | -       |
| `zone_type`  | Zone type: `full`, `partial`, `secondary`, `internal` | `string` | no       | `full`  |

## Outputs

| Name           | Description                          |
| -------------- | ------------------------------------ |
| `zone_id`      | The zone ID                          |
| `zone_name`    | The zone name                        |
| `name_servers` | Cloudflare nameservers for this zone |
| `status`       | Zone status                          |
