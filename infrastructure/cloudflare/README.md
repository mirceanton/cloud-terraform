# Cloudflare Infrastructure

This unit manages Cloudflare zones and DNS records.

## Folder Structure

```
cloudflare/
└── <domain>/
    ├── terragrunt.hcl     # Zone configuration
    └── dns/
        └── terragrunt.hcl # DNS records for the zone
```

### Key Directories

- **\<domain\>/**: Each subdirectory represents a Cloudflare zone. The domain name is derived from the directory name.
- **\<domain\>/dns/**: DNS records for the parent zone. Depends on the zone to obtain the `zone_id`.

## Required Environment Variables

### Cloudflare Provider

| Environment Variable                | Description                                           |
| ----------------------- | ----------------------------------------------------- |
| `CLOUDFLARE_API_TOKEN`  | Cloudflare API token with zone management permissions |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare account ID                                 |

### Verification Records

These are used for domain ownership verification with various services:

| Environment Variable                          | Description                                            |
| --------------------------------- | ------------------------------------------------------ |
| `GITHUB_PAGES_VERIFICATION_MAIN`  | GitHub Pages verification code for the main site       |
| `GITHUB_PAGES_VERIFICATION_LINKS` | GitHub Pages verification code for the links subdomain |
| `MIGADU_VERIFICATION_PRIMARY`     | Migadu domain verification code (primary domain)       |
| `MIGADU_VERIFICATION_SECONDARY`   | Migadu domain verification code (secondary domain)     |
| `GOOGLE_VERIFICATION_PRIMARY`     | Google site verification code (primary domain)         |
| `GOOGLE_VERIFICATION_SECONDARY`   | Google site verification code (secondary domain)       |
| `DISCORD_VERIFICATION`            | Discord server verification code                       |
