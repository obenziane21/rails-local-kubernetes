## Deploy redis via helm release provider
resource "helm_release" "redis" {
  atomic     = true
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  namespace  = "default"
  timeout    = 600
}
