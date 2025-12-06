variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "ruleset_name" {
  description = "Name of the redirect ruleset"
  type        = string
  default     = "Redirect rules"
}

variable "ruleset_description" {
  description = "Description of the redirect ruleset"
  type        = string
  default     = "Zone redirect rules"
}

variable "rules" {
  description = "Map of redirect rules to create"
  type = map(object({
    description           = string
    expression            = string
    enabled               = optional(bool, true)
    status_code           = optional(number, 301)
    preserve_query_string = optional(bool, false)
    target_url            = optional(string, null) # Static URL
    target_url_expression = optional(string, null) # Dynamic expression
  }))

  validation {
    condition = alltrue([
      for k, v in var.rules : (v.target_url != null) != (v.target_url_expression != null)
    ])
    error_message = "Each rule must have either 'target_url' (static) or 'target_url_expression' (dynamic), but not both."
  }
}