variable "key_name" {
  description = "Name for the application key"
  type        = string
}

variable "capabilities" {
  description = "Capabilities for the application key"
  type        = list(string)
}

variable "bucket_ids" {
  description = "Bucket IDs to scope the key to. Empty list grants access to all buckets."
  type        = list(string)
  default     = []
}

variable "name_prefix" {
  description = "Restrict key access to files with this prefix. Only valid when bucket_ids is set."
  type        = string
  default     = null
}

variable "rotation_days" {
  description = "Number of days between automatic key rotations. Null disables rotation."
  type        = number
  default     = null
}
