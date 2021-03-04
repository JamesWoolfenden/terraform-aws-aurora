resource "aws_rds_cluster_instance" "instances" {
  count              = length(var.instances)
  engine             = var.engine
  engine_version     = var.engine_version
  availability_zone  = var.availability_zone
  identifier         = var.instances[count.index]["identifier"]
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = var.instances[count.index]["instance_class"]
  //check
  publicly_accessible     = false
  db_subnet_group_name    = "value"
  db_parameter_group_name = aws_rds_cluster_parameter_group.examplea.name
  apply_immediately       = true
  monitoring_role_arn     = var.monitoring_role_arn
  monitoring_interval     = var.monitoring_interval
  promotion_tier          = var.promotion_tier
  preferred_backup_window = var.preferred_backup_window
  tags                    = var.common_tags
}

variable "preferred_backup_window" {
  default = "04:00-09:00"
}
variable "availability_zone" {
  default = ""
}
variable "promotion_tier" {
  type        = number
  description = " Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer"
  default     = 0
}

variable "monitoring_interval" {
  default = 0
}

variable "monitoring_role_arn" {
  type    = string
  default = ""
}
