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
data "aws_caller_identity" "current" {}

resource "aws_kms_key" "aurora" {
  enable_key_rotation = true
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
