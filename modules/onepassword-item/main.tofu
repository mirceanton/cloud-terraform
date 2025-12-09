terraform {
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 2.0"
    }
  }
}

data "onepassword_vault" "this" {
  name = var.vault_name
}

resource "onepassword_item" "this" {
  vault    = data.onepassword_vault.this.uuid
  title    = var.item_title
  category = var.category
  tags     = var.tags
  url      = var.url

  dynamic "section" {
    for_each = length(var.fields) > 0 ? [1] : []
    content {
      label = "Credentials"

      dynamic "field" {
        for_each = var.fields
        content {
          label = field.key
          value = field.value
          type  = field.key == "key_secret" || field.key == "password" ? "CONCEALED" : "STRING"
        }
      }
    }
  }
}