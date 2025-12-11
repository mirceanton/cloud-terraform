variable "vault_name" {
  description = "Name of the 1Password vault"
  type        = string
}

variable "item_title" {
  description = "Title of the 1Password item"
  type        = string
}

variable "category" {
  description = "Item category: login, password, secure_note, api_credential"
  type        = string
  default     = "api_credential"
}

variable "fields" {
  description = "Map of field labels to values"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to the item"
  type        = list(string)
  default     = []
}

variable "url" {
  description = "URL associated with the item (optional)"
  type        = string
  default     = null
}