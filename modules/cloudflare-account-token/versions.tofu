terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.23.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.14.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "3.3.1"
    }
  }
}