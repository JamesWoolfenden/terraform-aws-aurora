resource "aws_rds_cluster" "default" {
  backup_retention_period = var.backup_retention_period
  cluster_identifier      = var.cluster["cluster_identifier"]
  //check its not mysql 5.6 if engine is mysql
  engine_version     = var.engine_version
  engine             = var.engine
  availability_zones = data.aws_availability_zones.zones.names
  //another check
  deletion_protection                 = var.deletion_protection
  database_name                       = var.cluster["database_name"]
  master_username                     = var.cluster["master_username"]
  master_password                     = var.master_password
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  //check that its set
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.examplea.name
  //check for audit
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  storage_encrypted               = true
  kms_key_id                      = var.kms_key_id
  tags                            = var.common_tags
}
