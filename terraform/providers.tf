terraform {
  backend "local" {
    path    = "../terraform.tfstate"
  }
  required_providers {

    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.14.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }

    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.2.8"
    }

  }

}

provider "docker" {}


provider "minikube" {
  kubernetes_version = "v1.26.3"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
