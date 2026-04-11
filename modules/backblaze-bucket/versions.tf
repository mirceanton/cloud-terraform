terraform {
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.12.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }
}