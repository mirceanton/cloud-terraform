variable "zone_name" {
  description = "The domain name of the zone to look up"
  type        = string
}

variable "records" {
  description = "Map of DNS records to create in this zone"
  type = map(object({
    type     = string
    name     = optional(string)
    value    = string
    ttl      = optional(number, 1)
    proxied  = optional(bool, false)
    priority = optional(number)
    weight   = optional(number)
    port     = optional(number)
    comment  = optional(string)
  }))
  default = {}
}
