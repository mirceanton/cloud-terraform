variable "tokens" {
  description = "Map of API tokens to create. Map key becomes the token name."
  type = map(object({
    rotation_days = optional(number, 30)
    validity_days = optional(number, 33)
    condition = optional(object({
      request_ip = optional(object({
        in     = optional(list(string))
        not_in = optional(list(string))
      }))
    }))
    policies = list(object({
      effect            = optional(string, "allow")
      permission_groups = list(string)
      resources         = map(string)
    }))
  }))
  default = {}
}
