module "aurora" {
  source      = "../../"
  common_tags = var.common_tags
  instances   = var.instances
  cluster     = var.cluster
}
