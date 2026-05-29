variable "buckets" {
  description = "Map of B2 buckets to create. Map key is the bucket name."
  type = map(object({
    bucket_type = optional(string, "allPrivate")
    bucket_info = optional(map(string), {})
    lifecycle_rules = optional(list(object({
      file_name_prefix              = string
      days_from_uploading_to_hiding = optional(number)
      days_from_hiding_to_deleting  = optional(number)
    })), [])
    cors_rules = optional(list(object({
      cors_rule_name     = string
      allowed_origins    = list(string)
      allowed_headers    = list(string)
      allowed_operations = list(string)
      max_age_seconds    = number
    })), [])
  }))
  default = {}

  validation {
    condition = alltrue([
      for name, b in var.buckets :
      contains(["allPrivate", "allPublic"], b.bucket_type)
    ])
    error_message = "bucket_type must be either 'allPrivate' or 'allPublic'"
  }
}

variable "keys" {
  description = "Map of application keys to create. Map key is the key name. Set bucket_name to scope to a specific bucket; leave null for account-level."
  type = map(object({
    capabilities  = list(string)
    bucket_name   = optional(string)
    name_prefix   = optional(string)
    rotation_days = optional(number)
  }))
  default = {}
}
