variable "zone_name" {
  description = "The domain name of the zone"
  type        = string
}

variable "account_id" {
  description = "The Cloudflare account ID"
  type        = string
  sensitive   = true
}

variable "zone_type" {
  description = "The type of the zone (full, partial, secondary, internal)"
  type        = string
  default     = "full"
}
