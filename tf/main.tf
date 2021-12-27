terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_kubernetes_versions" "challenge_version" {
  version_prefix = "1.21."
}

resource "digitalocean_kubernetes_cluster" "challenge" {
  name         = "challenge"
  region       = "nyc3"
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.challenge_version.latest_version

  node_pool {
    name       = "default"
    size       = "s-4vcpu-8gb"
    node_count = 3
  }

  maintenance_policy {
    start_time = "04:00"
    day        = "sunday"
  }

  tags = [var.environment]
}
