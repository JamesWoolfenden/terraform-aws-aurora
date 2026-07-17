data "aws_region" "current" {}

resource "aws_kms_key" "flow_log" {
  description             = "Encrypts the aurora-demo VPC flow log group"
  enable_key_rotation     = true
  deletion_window_in_days = 7

  lifecycle {
    prevent_destroy = true
  }

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow CloudWatch Logs to use the key"
        Effect = "Allow"
        Principal = {
          Service = "logs.${data.aws_region.current.region}.amazonaws.com"
        }
        Action = [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*",
        ]
        Resource = "*"
        Condition = {
          ArnLike = {
            "kms:EncryptionContext:aws:logs:arn" = "arn:aws:logs:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:log-group:/aurora-demo/vpc-flow-log"
          }
        }
      },
    ]
  })
}

resource "aws_cloudwatch_log_group" "flow_log" {
  name              = "/aurora-demo/vpc-flow-log"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.flow_log.arn
}

data "aws_iam_policy_document" "flow_log_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "flow_log" {
  name                 = "aurora-demo-flow-log"
  assume_role_policy   = data.aws_iam_policy_document.flow_log_assume.json
  max_session_duration = 3600
}

data "aws_iam_policy_document" "flow_log" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]
    resources = ["${aws_cloudwatch_log_group.flow_log.arn}:*"]
  }
}

resource "aws_iam_role_policy" "flow_log" {
  name   = "aurora-demo-flow-log"
  role   = aws_iam_role.flow_log.id
  policy = data.aws_iam_policy_document.flow_log.json
}

resource "aws_flow_log" "aurora" {
  vpc_id          = aws_vpc.aurora.id
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.flow_log.arn
  log_destination = aws_cloudwatch_log_group.flow_log.arn
}
