locals {
  # =======================================================
  # Basic Capabilities
  # =======================================================
  readonly_capabilities = [
    "listBuckets",
    "listFiles",
    "readBucketEncryption",
    "readBucketNotifications",
    "readBucketReplications",
    "readBuckets",
    "readFiles",
  ]

  writeonly_capabilities = [
    "shareFiles",
    "writeBucketEncryption",
    "writeBucketNotifications",
    "writeBucketReplications",
    "writeFiles",
  ]

  delete_capabilities = ["deleteFiles"]

  management_capabilities = [
    "deleteBuckets",
    "deleteKeys",
    "listKeys",
    "writeBuckets",
    "writeKeys",
  ]

  # =======================================================
  # Composite Capabilities
  # =======================================================
  readwrite_capabilities = distinct(concat(
    local.readonly_capabilities,
    local.writeonly_capabilities,
  ))

  full_capabilities = distinct(concat(
    local.readwrite_capabilities,
    local.delete_capabilities,
  ))

  admin_capabilities = distinct(concat(
    local.full_capabilities,
    local.management_capabilities,
  ))
}
