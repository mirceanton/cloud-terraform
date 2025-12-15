variable "key_name" {
  description = "Name for the application key"
  type        = string
}

variable "capabilities" {
  description = "Capabilities for the application key"
  type        = list(string)
}

variable "bucket_ids" {
  description = "List of bucket IDs to scope the key to. If empty, key has access to all buckets."
  type        = list(string)
  default     = null
}

variable "name_prefix" {
  description = "Prefix for files the key can access. Only valid when bucket_id is set."
  type        = string
  default     = null
}

variable "rotation_days" {
  description = "Number of days before the key should be rotated. If null, no automatic rotation."
  type        = number
  default     = null
}
