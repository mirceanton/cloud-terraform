include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

# Pull zone_id from parent zone unit
dependency "zone" { config_path = "../" }

locals {
  github_pages_verification_main = get_env("GITHUB_PAGES_VERIFICATION_MAIN")
  github_pages_verification_links = get_env("GITHUB_PAGES_VERIFICATION_LINKS")
  migadu_verification = get_env("MIGADU_VERIFICATION_PRIMARY")
  google_verification = get_env("GOOGLE_VERIFICATION_PRIMARY")
  discord_verification = get_env("DISCORD_VERIFICATION")
}

terraform {
  source = find_in_parent_folders("modules/cloudflare-dns")
}

inputs = {
  zone_id = dependency.zone.outputs.zone_id

  records = {
    # ================================================
    # GitHub Pages -> main site
    # ================================================
    "ghp_main_a1" = { type = "A", name = "@", value = "185.199.111.153", comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages" },
    "ghp_main_a2" = { type = "A", name = "@", value = "185.199.110.153", comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages" },
    "ghp_main_a3" = { type = "A", name = "@", value = "185.199.109.153", comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages" },
    "ghp_main_a4" = { type = "A", name = "@", value = "185.199.108.153", comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages" },
    "ghp_main_verification" = {
        type  = "TXT"
        name  = "_github-pages-challenge-mirceanton"
        value = "\"${local.github_pages_verification_main}\""
        comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages Verification"
    },

    # ================================================
    # GitHub Pages -> links page
    # ================================================
    "ghp_links_a1" = { type = "A", name = "links", value = "185.199.111.153", comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages" },
    "ghp_links_a2" = { type = "A", name = "links", value = "185.199.110.153", comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages" },
    "ghp_links_a3" = { type = "A", name = "links", value = "185.199.109.153", comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages" },
    "ghp_links_a4" = { type = "A", name = "links", value = "185.199.108.153", comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages" },
    "ghp_links_verification" = {
        type  = "TXT"
        name  = "_github-pages-challenge-links.mirceanton.com"
        value = "\"${local.github_pages_verification_links}\""
        comment = "Managed by github.com/mirceanton/cloud-terraform | GitHub Pages Verification"
    },

    # =================================================
    # Migadu Mail Records
    # =================================================
    "migadu_autoconfig" = {
        type  = "CNAME"
        name  = "autoconfig"
        value = "autoconfig.migadu.com"
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu Autoconfig"
    },
    "migadu_key1" = {
        type  = "CNAME"
        name  = "key1._domainkey"
        value = "key1.${dependency.zone.outputs.zone_name}._domainkey.migadu.com"
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu DKIM Primary"
    },
    "migadu_key2" = {
        type  = "CNAME"
        name  = "key2._domainkey"
        value = "key2.${dependency.zone.outputs.zone_name}._domainkey.migadu.com"
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu DKIM Secondary"
    },
    "migadu_key3" = {
        type  = "CNAME"
        name  = "key3._domainkey"
        value = "key3.${dependency.zone.outputs.zone_name}._domainkey.migadu.com"
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu DKIM Tertiary"
    },
    "migadu_mx1" = {
        type     = "MX"
        name     = "@"
        value    = "aspmx1.migadu.com"
        priority = 10
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu Primary MX Host"
    },
    "migadu_mx2" = {
        type     = "MX"
        name     = "@"
        value    = "aspmx2.migadu.com"
        priority = 20
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu Secondary MX Host"
    },
    "migadu_mx1_subdomain" = {
        type     = "MX"
        name     = "*"
        value    = "aspmx1.migadu.com"
        priority = 10
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu Primary MX Host (Subdomain Addressing)"
    },
    "migadu_mx2_subdomain" = {
        type     = "MX"
        name     = "*"
        value    = "aspmx2.migadu.com"
        priority = 20
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu Secondary MX Host (Subdomain Addressing)"
    },
    "migadu_autodiscover" = {
        type     = "SRV"
        name     = "_autodiscover._tcp"
        value    = "autodiscover.migadu.com"
        priority = 0
        weight   = 1
        port     = 443
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu Autodiscover SRV"
    },
    "migadu_imaps" = {
        type     = "SRV"
        name     = "_imaps._tcp"
        value    = "imap.migadu.com"
        priority = 0
        weight   = 1
        port     = 993
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu IMAPS SRV"
    },
    "migadu_pop3s" = {
        type     = "SRV"
        name     = "_pop3s._tcp"
        value    = "pop3.migadu.com"
        priority = 0
        weight   = 1
        port     = 995
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu POP3S SRV"
    },
    "migadu_submissions" = {
        type     = "SRV"
        name     = "_submissions._tcp"
        value    = "smtp.migadu.com"
        priority = 0
        weight   = 1
        port     = 465
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu Submissions SRV"
    },
    "migadu_dmarc" = {
        type  = "TXT"
        name  = "_dmarc"
        value = "\"v=DMARC1; p=quarantine;\""
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu DMARC Policy"
    },
    "migadu_spf" = {
        type  = "TXT"
        name  = "@"
        value = "\"v=spf1 include:spf.migadu.com -all\""
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu SPF Record"
    },
    "migadu_verification" = {
        type  = "TXT"
        name  = "@"
        value = "\"hosted-email-verify=${local.migadu_verification}\""
        comment = "Managed by github.com/mirceanton/cloud-terraform | Migadu Domain Verification"
    },

    # ================================================
    # Site Verifications
    # ================================================
    "google_site_verification" = {
        type  = "TXT"
        name  = "@"
        value = "\"${local.google_verification}\""
        comment = "Managed by github.com/mirceanton/cloud-terraform | Google Site Verification"
    },
    "discord_site_verification" = {
        type  = "TXT"
        name  = "_discord.com"
        value = "dh=${local.discord_verification}"
    }
  }
}