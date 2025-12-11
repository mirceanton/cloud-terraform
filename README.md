# Terragrunt: Cloud Resources

OpenTofu configurations for various cloud services I use, orchestrated via Terragrunt.

## Folder Structure

```
cloud-terraform/
├── root.hcl           # Shared Terragrunt config (S3 backend)
├── infrastructure/    # Terragrunt units organized by provider
│   ├── backblaze/     # B2 buckets and application keys
│   ├── cloudflare/    # DNS zones and records
│   └── migadu/        # Email mailboxes and aliases
└── modules/           # Reusable OpenTofu modules
    ├── backblaze-appkey/
    ├── backblaze-bucket/
    ├── cloudflare-dns/
    ├── cloudflare-zone/
    └── migadu-mailbox/
```

## Required Environment Variables

See `.envrc.example` for a complete list.

## State Backend

Terraform state is stored in Backblaze B2 using the S3-compatible API:

- **Bucket**: `tfstate-cloud-terraform`
- **Endpoint**: `https://s3.eu-central-003.backblazeb2.com`
