terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "k8s-challenge" {
  name         = "k8s-challenge"
  region       = "nyc1"
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.k8s-challenge-version.latest_version

  maintenance_policy {
    start_time = "04:00"
    day        = "sunday"
  }

  node_pool {
    name       = "default"
    size       = "s-1vcpu-2gb"
    node_count = 3
  }
  tags = ["dev"]
}

output "cluster_kubeconfig" {
  value     = digitalocean_kubernetes_cluster.k8s-challenge.kube_config
  sensitive = true
}

data "digitalocean_kubernetes_versions" "k8s-challenge-version" {
  version_prefix = "1.21."
}
