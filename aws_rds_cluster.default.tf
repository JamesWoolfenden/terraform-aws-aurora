resource "aws_rds_cluster" "default" {
  backup_retention_period             = var.backup_retention_period
  cluster_identifier                  = var.cluster["cluster_identifier"]
  engine_version                      = var.engine_version
  engine                              = var.engine
  availability_zones                  = data.aws_availability_zones.zones.names
  deletion_protection                 = var.deletion_protection
  database_name                       = var.cluster["database_name"]
  master_username                     = var.cluster["master_username"]
  master_password                     = var.master_password
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.this.name
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  storage_encrypted                   = true
  kms_key_id                          = var.kms_key_id
  copy_tags_to_snapshot               = true
  preferred_maintenance_window        = var.preferred_maintenance_window
  vpc_security_group_ids              = var.vpc_security_group_ids
  db_subnet_group_name                = var.db_subnet_group_name
  backtrack_window                    = var.backtrack_window

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_backup_vault" "default" {
  name        = "${var.cluster["cluster_identifier"]}-backup-vault"
  kms_key_arn = var.kms_key_id
}

resource "aws_backup_vault_lock_configuration" "default" {
  backup_vault_name  = aws_backup_vault.default.name
  min_retention_days = 35
}

resource "aws_backup_plan" "default" {
  name = "${var.cluster["cluster_identifier"]}-backup-plan"

  rule {
    rule_name         = "daily"
    target_vault_name = aws_backup_vault.default.name
    schedule          = "cron(0 5 ? * * *)"

    lifecycle {
      delete_after = 35
    }
  }
}

resource "aws_iam_role" "backup" {
  name = "${var.cluster["cluster_identifier"]}-backup-role"

  # Ensure maximum session duration does not exceed 12 hours (43200 seconds)
  max_session_duration = 43200

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup" {
  role       = aws_iam_role.backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_selection" "default" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "${var.cluster["cluster_identifier"]}-backup-selection"
  plan_id      = aws_backup_plan.default.id

  resources = [aws_rds_cluster.default.arn]
}
