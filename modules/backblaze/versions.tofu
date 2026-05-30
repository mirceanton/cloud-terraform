terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.12.1"
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