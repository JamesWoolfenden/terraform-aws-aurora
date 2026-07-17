# holden:ignore:HLD_TF_026
module "aurora" {
  source                 = "../../"
  instances              = var.instances
  cluster                = var.cluster
  master_password        = random_string.password.result
  kms_key_id             = aws_kms_key.aurora.id
  vpc_security_group_ids = [aws_security_group.aurora.id]
  db_subnet_group_name   = aws_db_subnet_group.aurora.name
}

resource "random_string" "password" {
  length           = 16
  override_special = "!#$%^&*()-_=+[]{}<>:?"
}

data "aws_caller_identity" "current" {}

resource "aws_kms_key" "aurora" {
  enable_key_rotation     = true
  deletion_window_in_days = 7
  lifecycle {
    prevent_destroy = true
  }
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "Enable IAM User Permissions"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
      Action   = "kms:*"
      Resource = "*"
    }]
  })
}
