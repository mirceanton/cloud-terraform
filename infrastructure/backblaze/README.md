# Backblaze B2 Infrastructure

This unit manages Backblaze B2 cloud storage resources, specifically buckets and application keys.

## Folder Structure

```
backblaze/
├── capabilities.hcl       # Shared capability definitions for app keys
├── buckets/               # B2 bucket definitions
│   └── <bucket-name>/
│       ├── terragrunt.hcl # Bucket configuration
│       └── keys/          # Application keys scoped to this bucket
│           └── <key-name>/
│               └── terragrunt.hcl
└── keys/                  # Global application keys (not bucket-scoped)
    └── <key-name>/
        └── terragrunt.hcl
```

### Key Directories

- **buckets/**: Each subdirectory creates a B2 bucket. The bucket name is derived from the directory name.
- **buckets/\*/keys/**: Application keys scoped to the parent bucket with restricted capabilities.
- **keys/**: Global application keys with access to all buckets (e.g., admin keys).
- **capabilities.hcl**: Defines reusable capability sets (`readonly`, `writeonly`, `readwrite`, `full`, `admin`).

## Required Environment Variables

The Backblaze B2 provider requires the following environment variables:

| Environment Variable                | Description                                     |
| ----------------------- | ----------------------------------------------- |
| `B2_APPLICATION_KEY_ID` | Your Backblaze account ID or application key ID |
| `B2_APPLICATION_KEY`    | Your Backblaze application key                  |
