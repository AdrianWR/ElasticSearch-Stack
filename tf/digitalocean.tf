provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_kubernetes_versions" "challenge_version" {
  version_prefix = "1.21."
}

resource "digitalocean_kubernetes_cluster" "challenge" {
  name         = "challenge"
  region       = var.region
  version      = data.digitalocean_kubernetes_versions.challenge_version.latest_version
  auto_upgrade = true

  node_pool {
    name       = "default"
    size       = var.node_type
    node_count = 3
  }

  maintenance_policy {
    start_time = "04:00"
    day        = "sunday"
  }

  tags = [var.environment]
}
