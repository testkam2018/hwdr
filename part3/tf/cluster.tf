terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.5.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.9"
    }
  }
}

provider "kind" {
}
provider "helm" {


  kubernetes {
    host                   = yamldecode(kind_cluster.default.kubeconfig)["clusters"][0].cluster.server
    client_certificate     = base64decode(yamldecode(nonsensitive(kind_cluster.default.kubeconfig))["users"][0].user.client-certificate-data)
    client_key             = base64decode(yamldecode(nonsensitive(kind_cluster.default.kubeconfig))["users"][0].user.client-key-data)
    cluster_ca_certificate = base64decode(yamldecode(nonsensitive(kind_cluster.default.kubeconfig))["clusters"][0].cluster.certificate-authority-data)
  }
}

resource "kind_cluster" "default" {
  name           = "test-cluster"
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }

    node {
      role = "worker"
    }
  }
}
