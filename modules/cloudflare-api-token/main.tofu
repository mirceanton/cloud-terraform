terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.13.0"
    }
  }
}


resource "cloudflare_api_token" "this" {
  name = var.name
  policies = var.policies
  condition = var.condition
  expires_on = var.expires_on
  not_before = var.not_before
}
