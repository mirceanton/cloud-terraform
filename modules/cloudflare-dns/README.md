# cloudflare-dns

Manage DNS records (A, AAAA, CNAME, TXT, MX, SRV, etc.) for a Cloudflare-managed domain.

## Resources

- `cloudflare_dns_record.standard` - Standard DNS records (A, AAAA, CNAME, TXT, MX, etc.)
- `cloudflare_dns_record.srv` - SRV records (require special data block handling)

## Inputs

| Name      | Description                  | Type          | Required | Default |
| --------- | ---------------------------- | ------------- | -------- | ------- |
| `zone_id` | The Cloudflare Zone ID       | `string`      | yes      | -       |
| `records` | Map of DNS records to create | `map(object)` | no       | `{}`    |

### Record Object Structure

```hcl
records = {
  "example" = {
    type     = "A"           # Required: A, AAAA, CNAME, TXT, MX, SRV, etc.
    name     = "www"         # Optional: defaults to map key
    value    = "192.0.2.1"   # Required: record value/target
    ttl      = 1             # Optional: 1 = automatic
    proxied  = false         # Optional: Cloudflare proxy (A/AAAA/CNAME only)
    priority = 10            # Optional: for MX, SRV
    weight   = 5             # Optional: for SRV
    port     = 443           # Optional: for SRV
    comment  = "Web server"  # Optional
  }
}
```

## Outputs

None.
