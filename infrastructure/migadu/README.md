# Migadu Infrastructure

This unit manages mailboxes and aliases for the `mirceanton.com` domain hosted on Migadu.

> [!WARNING]
> Domain aliases (e.g., `mirceaanton.com` -> `mirceanton.com`) are not supported via the Migadu API and must be configured manually in the Migadu admin panel.

> [!NOTE]
> DNS records for alias domains are managed in the cloudflare unit (e.g., `infrastructure/cloudflare/mirceaanton.com/dns/`).

## Folder Structure

```
migadu/
├── migadu.hcl        # Shared configuration (domain name, recovery email)
└── <mailbox-name>/
    └── terragrunt.hcl # Mailbox and alias configuration
```

### Key Directories

- **\<mailbox-name\>/**: Each subdirectory creates a mailbox. The mailbox name is derived from the directory name.
- **migadu.hcl**: Shared locals for domain name and recovery email used across all mailboxes.

## Required Environment Variables

### Migadu Provider

| Environment Variable    | Description                    |
| ----------------------- | ------------------------------ |
| `MIGADU_USERNAME`       | Migadu admin account email     |
| `MIGADU_TOKEN`          | Migadu API token               |


