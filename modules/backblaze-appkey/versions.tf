terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.12.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }
}