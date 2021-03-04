module "aurora" {
  source          = "../../"
  common_tags     = var.common_tags
  instances       = var.instances
  cluster         = var.cluster
  master_password = random_string.password.result
  kms_key_id      = aws_kms_key.aurora.id
}

resource "random_string" "password" {
  length = 16
}


resource "aws_kms_key" "aurora" {

  enable_key_rotation = true
}
