variable "bucket_name" {
  description = "Name of the B2 bucket"
  type        = string
}

variable "bucket_type" {
  description = "Bucket visibility: allPrivate or allPublic"
  type        = string
  default     = "allPrivate"
}

variable "app_key_name" {
  description = "Name for the application key (defaults to bucket name)"
  type        = string
  default     = null
}

variable "app_key_capabilities" {
  description = "Capabilities for the application key"
  type        = list(string)
  default = [
    "listBuckets",
    "listFiles",
    "readFiles",
    "writeFiles",
    "deleteFiles"
  ]
}

variable "lifecycle_rules" {
  description = "Lifecycle rules for the bucket"
  type = list(object({
    file_name_prefix              = string
    days_from_uploading_to_hiding = optional(number)
    days_from_hiding_to_deleting  = optional(number)
  }))
  default = []
}

variable "cors_rules" {
  description = "CORS rules for the bucket"
  type = list(object({
    cors_rule_name   = string
    allowed_origins  = list(string)
    allowed_headers  = list(string)
    allowed_operations = list(string)
    max_age_seconds  = number
  }))
  default = []
}