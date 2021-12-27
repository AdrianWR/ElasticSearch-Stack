provider "helm" {
  kubernetes {
    host  = digitalocean_kubernetes_cluster.challenge.endpoint
    token = digitalocean_kubernetes_cluster.challenge.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.challenge.kube_config[0].cluster_ca_certificate
    )
  }
}

#resource "helm_release" "ingress_nginx" {
#  name             = "ingress-nginx"
#  repository       = "https://kubernetes.github.io/ingress-nginx"
#  chart            = "ingress-nginx"
#  namespace        = "ingress-nginx"
#  create_namespace = true
#}

resource "helm_release" "elasticsearch" {
  name             = "elasticsearch"
  repository       = "https://helm.elastic.co"
  chart            = "elasticsearch"
  version          = "7.15.0"
  namespace        = var.logging_namespace
  create_namespace = true
  values = [
    <<-EOT
      ---
      esConfig:
        xpack.security.enabled: "true"
      volumeClaimTemplate:
        accessModes: ["ReadWriteOnce"]
        storageClassName: "do-block-storage"
        resources:
          requests:
            storage: 30Gi
    EOT
  ]
}

resource "helm_release" "kibana" {
  name             = "kibana"
  repository       = "https://helm.elastic.co"
  chart            = "kibana"
  version          = "7.15.0"
  namespace        = var.logging_namespace
  create_namespace = true
}

resource "helm_release" "fluent-bit" {
  name             = "fluentbit"
  repository       = "https://fluent.github.io/helm-charts"
  chart            = "fluent-bit"
  version          = "0.19.15"
  namespace        = var.logging_namespace
  create_namespace = true
}
