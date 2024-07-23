resource "helm_release" "ngrok" {
  name             = "ngrok"
  repository       = "https://ngrok.github.io/kubernetes-ingress-controller"
  chart            = "kubernetes-ingress-controller"
  namespace        = "hw-app"
  atomic           = true
  create_namespace = true
  version          = "0.14.0"

  set {
    name  = "credentials.apiKey"
    value = var.apiKey
  }
  set {
    name  = "credentials.authtoken"
    value = var.authtoken
  }
}
