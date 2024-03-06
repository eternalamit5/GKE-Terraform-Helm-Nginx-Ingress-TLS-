provider "helm" {
  kubernetes {
    host                   = google_container_cluster.this.endpoint
    client_certificate     = base64decode(google_container_cluster.this.master_auth[0].client_certificate)
    client_key             = base64decode(google_container_cluster.this.master_auth[0].client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.this.master_auth[0].cluster_ca_certificate)
  }
}

resource "helm_release" "external_nginx" {
  name = "external"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  version          = "4.8.0"

  values = [file("${path.module}/values/ingress.yaml")]
}
