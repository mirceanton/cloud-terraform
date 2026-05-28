variable "name" {
  description = "Name of the API token"
  type        = string
}

variable "policies" {
  description = "List of policies granting permissions to the token"
  type = list(object({
    effect = optional(string, "allow")
    permission_groups = list(string)
    resources = map(string)
  }))
}

variable "condition" {
  description = "Optional IP filtering condition for the token"
  type = object({
    request_ip = optional(object({
      in     = optional(list(string))
      not_in = optional(list(string))
    }))
  })
  default = null
}

variable "rotation_days" {
  description = "How often the token is rotated (replaced with a new value)"
  type        = number
  default     = 30
}

variable "validity_days" {
  description = "How many days the token remains valid from the time of its last rotation. Must be greater than rotation_days to avoid expiry gaps."
  type        = number
  default     = 33
}
