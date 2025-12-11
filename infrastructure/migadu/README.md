# Migadu Infrastructure

This directory manages mailboxes and aliases for the `mirceanton.com` domain hosted on Migadu.

## Structure

```
migadu/
  <mailbox-name>/ # mailbox unit
  migadu.hcl      # Shared configuration
```

## Domain Aliases

Domain aliases (e.g., `mirceaanton.com` -> `mirceanton.com`) are **not supported via the Migadu API** and must be configured manually in the Migadu admin panel.

The DNS records for the alias domain (`mirceaanton.com`) are managed in:

- `infrastructure/cloudflare/mirceaanton.com/dns/`
