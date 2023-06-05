# Create a docker image resource for rails app
resource "docker_image" "rails_hello" {
  name = "rails_hello:v1"
  keep_locally = false
  build {
    context = "../app/docker"
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "../app/docker/*") : filesha1(f)]))
  }
}

resource "helm_release" "rails_hello" {
  name      = "rails-hello"
  namespace = "default"
  chart     = "../app/charts/rails_hello"
  version   = "0.1.1"
  atomic    = false

  depends_on = [
    docker_image.rails_hello,
    helm_release.nginx_ingress_controller,
  ]
}
