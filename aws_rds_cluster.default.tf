resource "aws_rds_cluster" "default" {
  cluster_identifier = var.cluster["cluster_identifier"]
  //check its not mysql 5.6 if engine is mysql
  engine_version     = var.engine_version
  engine             = var.engine
  availability_zones = data.aws_availability_zones.zones.names
  database_name      = var.cluster["database_name"]
  master_username    = var.cluster["master_username"]
  master_password    = var.master_password
  //check that its set
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.examplea.name
  //check for audit
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  storage_encrypted               = true
  kms_key_id                      = var.kms_key_id
  tags                            = var.common_tags
}

variable "master_password" {
  type      = string
  sensitive = true
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(any)
  description = "Set of log types to export to cloudwatch. If omitted, no logs will be exported"
  default     = ["audit"]
  //condition must contain audit
  //valid audit, error, general, slowquery, postgresql
}

variable "engine" {
  type    = string
  default = "aurora"
  validation {
    condition     = can(regex("aurora|aurora-mysql|aurora-postgresql", var.engine))
    error_message = "Valid values are aurora, aurora-mysql or aurora-postgresql."
  }
}

variable "engine_version" {
  default = "5.7.mysql_aurora.2.03.2"
}
