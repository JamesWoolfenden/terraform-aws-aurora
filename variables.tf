variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map(any)
}

variable "cluster" {
  description = "All the properties of an Aurora Cluster"
  type        = map(any)
}

variable "instances" {
  description = "Settings of you database instances"
}

variable "kms_key_id" {
  type = string
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

variable "monitoring_role_arn" {
  type    = string
  default = ""
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
  type    = string
  default = "5.7.mysql_aurora.2.03.2"
}


variable "deletion_protection" {
  type    = bool
  default = true
}

variable "monitoring_interval" {
  type        = string
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  default     = 1

  validation {
    condition     = can(regex("0|1|5|10|15|30|60", var.monitoring_interval))
    error_message = "Valid Values: 0, 1, 5, 10, 15, 30, 60."
  }
}

variable "iam_database_authentication_enabled" {
  type        = bool
  description = "Use IAM"
  default     = true
}

variable "backup_retention_period" {
  type        = number
  description = "Schedule your Backup retention and enable"
  default     = 1
}
