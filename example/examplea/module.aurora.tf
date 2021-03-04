module "aurora" {
  source          = "../../"
  common_tags     = var.common_tags
  instances       = var.instances
  cluster         = var.cluster
  master_password = random_string.password.result
  kms_key_id      = ""
}

resource "random_string" "password" {
  length = 16
}
