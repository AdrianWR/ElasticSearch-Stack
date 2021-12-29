output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.challenge.kube_config[0].raw_config
  sensitive = true
}

output "endpoint" {
  value = digitalocean_kubernetes_cluster.challenge.endpoint
}

output "ipv4_address" {
  value = digitalocean_kubernetes_cluster.challenge.ipv4_address
}

output "created_at" {
  value = digitalocean_kubernetes_cluster.challenge.created_at
}
