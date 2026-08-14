terraform {
  required_providers {
    migadu = {
      source  = "metio/migadu"
      version = "2026.8.13"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.14.1"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "3.3.1"
    }
  }
}