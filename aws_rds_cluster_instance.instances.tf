resource "aws_rds_cluster_instance" "instances" {
  for_each                        = { for inst in var.instances : inst.identifier => inst }
  auto_minor_version_upgrade      = true
  engine                          = var.engine
  engine_version                  = var.engine_version
  availability_zone               = var.availability_zone
  identifier                      = each.value.identifier
  cluster_identifier              = aws_rds_cluster.default.id
  instance_class                  = each.value.instance_class
  publicly_accessible             = false
  db_subnet_group_name            = var.db_subnet_group_name
  apply_immediately               = true
  monitoring_role_arn             = var.monitoring_role_arn
  monitoring_interval             = var.monitoring_interval
  performance_insights_enabled    = true
  performance_insights_kms_key_id = var.kms_key_id
  promotion_tier                  = var.promotion_tier
  preferred_backup_window         = var.preferred_backup_window
}
