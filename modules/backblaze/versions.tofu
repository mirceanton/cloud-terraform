terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.14.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.14.2"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "3.3.1"
    }
  }
}