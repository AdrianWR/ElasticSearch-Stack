output "cluster_kubeconfig" {
  value     = digitalocean_kubernetes_cluster.challenge.kube_config[0].raw_config
  sensitive = true
}

output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.challenge.endpoint
}

output "cluster_ipv4_address" {
  value = digitalocean_kubernetes_cluster.challenge.ipv4_address
}

output "cluster_created_at" {
  value = digitalocean_kubernetes_cluster.challenge.created_at
}
