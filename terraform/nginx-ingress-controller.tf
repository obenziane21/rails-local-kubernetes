## Deploy nginx Ingress controller via helm release provider
resource "helm_release" "nginx_ingress_controller" {
  atomic     = false
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "kube-system"
  timeout    = 600
}
