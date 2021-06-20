terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.26.0"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "vault" {
  address = local.vault_url
  token   = var.vault_token
}