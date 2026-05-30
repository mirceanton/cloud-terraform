include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "capabilities" {
  path   = "capabilities.hcl"
  expose = true
}

terraform {
  source = "${get_repo_root()}/modules/backblaze"
}

locals {
  full = include.capabilities.locals.full_capabilities
}

inputs = {
  buckets = {
    "mirceanton-obsidian-sync" = {
      bucket_type = "allPrivate"
      lifecycle_rules = [
        {
          file_name_prefix              = ""
          days_from_uploading_to_hiding = 0
          days_from_hiding_to_deleting  = 1
        }
      ]
    }

    "mirceanton-truenas-backup" = {
      bucket_type = "allPrivate"
      lifecycle_rules = [
        {
          file_name_prefix              = ""
          days_from_uploading_to_hiding = 0
          days_from_hiding_to_deleting  = 1
        }
      ]
    }

    "tfstate-mikrotik-terraform" = {
      bucket_type = "allPrivate"
      lifecycle_rules = [
        {
          file_name_prefix             = ""
          days_from_hiding_to_deleting = 31
        }
      ]
    }

    "tfstate-truenas-terraform" = {
      bucket_type = "allPrivate"
      lifecycle_rules = [
        {
          file_name_prefix             = ""
          days_from_hiding_to_deleting = 31
        }
      ]
    }
  }

  keys = {
    # TODO: rotation_days = 30 once TrueNAS cloud sync tasks are managed in the
    # home-ops repo and consume this key from 1Password automatically.
    "mirceanton-truenas-backup-main" = {
      capabilities = local.full
      bucket_name  = "mirceanton-truenas-backup"
      onepassword = {
        vault = "truenas-terraform"
        item  = "Backblaze Backups"
      }
    }

    # =============================================================================================
    # Obsidian Sync -> Manual Rotation
    # =============================================================================================
    "mirceanton-obsidian-sync-desktop" = {
      capabilities  = local.full
      bucket_name   = "mirceanton-obsidian-sync"
      rotation_days = 90
      onepassword = {
        vault = "cloud-terraform"
        item  = "Backblaze - obsidian-sync-desktop"
      }
    }
    "mirceanton-obsidian-sync-mobile" = {
      capabilities  = local.full
      bucket_name   = "mirceanton-obsidian-sync"
      rotation_days = 90
      onepassword = {
        vault = "cloud-terraform"
        item  = "Backblaze - obsidian-sync-mobile"
      }
    }

    "tfstate-mikrotik-terraform" = {
      capabilities  = local.full
      bucket_name   = "tfstate-mikrotik-terraform"
      rotation_days = 7
      onepassword = {
        vault = "mikrotik-terraform"
        item  = "Backblaze B2 State"
      }
    }
    "tfstate-truenas-terraform" = {
      capabilities  = local.full
      bucket_name   = "tfstate-truenas-terraform"
      rotation_days = 7
      onepassword = {
        vault = "truenas-terraform"
        item  = "Backblaze B2 State"
      }
    }
  }
}
