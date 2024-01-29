module "deployment" {
  # disable wait for all pods be ready.
  #
  wait_for_rollout = false

  # always pull latest version avoid fake updating.
  #
  image_pull_policy = "Always"

  source  = "terraform-iaac/deployment/kubernetes"
  version = "1.4.2"

  name      = local.name
  namespace = local.namespace
  image     = var.image
  replicas  = var.replicas
  resources = {
    request_cpu    = var.request_cpu == "" ? null : var.request_cpu
    limit_cpu      = var.limit_cpu == "" ? null : var.limit_cpu
    request_memory = var.request_memory == "" ? null : var.request_memory
    limit_memory   = var.limit_memory == "" ? null : var.limit_memory
  }
  env = var.env
}

module "service" {

  source  = "terraform-iaac/service/kubernetes"
  version = "1.0.4"

  app_name      = local.name
  app_namespace = local.namespace
  type          = "NodePort"
  port_mapping = [for p in var.ports :
    {
      name          = "port-${p}"
      internal_port = p
      external_port = p
      protocol      = "TCP"
  }]
}

data "kubernetes_service" "service" {
  depends_on = [module.service]

  metadata {
    name      = local.name
    namespace = local.namespace
  }
}

resource "random_string" "name_suffix" {
  length  = 10
  special = false
  upper   = false
}

locals {
  name      = join("-", ["demo", random_string.name_suffix.result])
  namespace = join("-", ["demo", local.name])
}
