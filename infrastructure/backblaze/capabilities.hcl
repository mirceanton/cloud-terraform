locals {
  # =======================================================
  # Basic Capabilities Definitions
  # =======================================================
  # Read-only access - can list and read files/buckets
  readonly_capabilities = [
    "listBuckets",
    "listFiles",
    "readBucketEncryption",
    "readBucketNotifications",
    "readBucketReplications",
    "readBuckets",
    "readFiles",
  ]

  # Write-only access - can write files but not read or delete
  writeonly_capabilities = [
    "shareFiles",
    "writeBucketEncryption",
    "writeBucketNotifications",
    "writeBucketReplications",
    "writeFiles",
  ]

  # Delete capabilities
  delete_capabilities = ["deleteFiles"]

  # Bucket/key management capabilities
  management_capabilities = [
    "deleteBuckets",
    "deleteKeys",
    "listKeys",
    "writeBuckets",
    "writeKeys",
  ]


  # =======================================================
  # Composite Capabilities Definitions
  # =======================================================
  # Read-write access - can read and write files, but not delete
  readwrite_capabilities = distinct(concat(
    local.readonly_capabilities,
    local.writeonly_capabilities,
  ))

  # Full access - read, write, and delete files (no bucket management)
  full_capabilities = distinct(concat(
    local.readwrite_capabilities,
    local.delete_capabilities,
  ))

  # Admin access - full control including bucket management
  admin_capabilities = distinct(concat(
    local.full_capabilities,
    local.management_capabilities,
  ))
}