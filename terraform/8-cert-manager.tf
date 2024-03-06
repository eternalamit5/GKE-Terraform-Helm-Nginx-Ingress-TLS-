provider "helm" {
  kubernetes {
    host                   = google_container_cluster.this.endpoint
    client_certificate     = base64decode(google_container_cluster.this.master_auth[0].client_certificate)
    client_key             = base64decode(google_container_cluster.this.master_auth[0].client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.this.master_auth[0].cluster_ca_certificate)
  }
}

resource "helm_release" "cert_manager" {
  name = "cert-manager"

  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  version          = "v1.13.1"

  set {
    name  = "installCRDs"
    value = "true"
  }
}
