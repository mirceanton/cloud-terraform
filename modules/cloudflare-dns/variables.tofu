variable "zone_id" {
  description = "The Cloudflare Zone ID where DNS records will be created"
  type        = string
  sensitive   = true
}

variable "records" {
  description = "Map of DNS records to create"
  type = map(object({
    type     = string
    name     = optional(string)      # Defaults to the map key
    value    = string
    ttl      = optional(number, 1)   # 1 = automatic
    proxied  = optional(bool, false)
    priority = optional(number)      # For MX, SRV
    weight   = optional(number)      # For SRV
    port     = optional(number)      # For SRV
    comment  = optional(string)
  }))
  default = {}
}
