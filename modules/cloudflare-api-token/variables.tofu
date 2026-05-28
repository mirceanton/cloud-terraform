variable "name" {
  description = "Name of the API token"
  type        = string
}

variable "policies" {
  description = "List of policies granting permissions to the token"
  type = list(object({
    effect = optional(string, "allow")
    permission_groups = list(object({
      id = string
    }))
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

variable "expires_on" {
  description = "RFC3339 timestamp after which the token is no longer valid"
  type        = string
  default     = null
}

variable "not_before" {
  description = "RFC3339 timestamp before which the token is not yet valid"
  type        = string
  default     = null
}
