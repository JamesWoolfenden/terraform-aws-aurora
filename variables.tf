
variable "cluster" {
  description = "All the properties of an Aurora Cluster"
  type        = map(any)

  validation {
    condition     = can(var.cluster["cluster_identifier"]) && can(var.cluster["database_name"]) && can(var.cluster["master_username"])
    error_message = "cluster must include cluster_identifier, database_name, and master_username keys."
  }
}

variable "instances" {
  description = "Settings of you database instances. Supplying only one instance means no failover target exists if the writer fails; use two or more for high availability."
  type = list(object({
    identifier     = string
    instance_class = string
  }))

  validation {
    condition     = length(var.instances) > 0
    error_message = "instances must contain at least one instance definition."
  }
}

variable "kms_key_id" {
  type        = string
  sensitive   = true
  description = "The KMS key ID for encryption"

  validation {
    condition     = length(var.kms_key_id) > 0
    error_message = "kms_key_id must not be empty."
  }
}

variable "preferred_backup_window" {
  type        = string
  description = "Preferred backup window"
  default     = "04:00-09:00"

  validation {
    condition     = can(regex("^([01][0-9]|2[0-3]):[0-5][0-9]-([01][0-9]|2[0-3]):[0-5][0-9]$", var.preferred_backup_window))
    error_message = "preferred_backup_window must be in the format HH:MM-HH:MM."
  }
}

variable "preferred_maintenance_window" {
  type        = string
  description = "Preferred maintenance window"
  default     = "sun:03:00-sun:04:00"

  validation {
    condition     = can(regex("^(mon|tue|wed|thu|fri|sat|sun):([01][0-9]|2[0-3]):[0-5][0-9]-(mon|tue|wed|thu|fri|sat|sun):([01][0-9]|2[0-3]):[0-5][0-9]$", var.preferred_maintenance_window))
    error_message = "preferred_maintenance_window must be in the format ddd:HH:MM-ddd:HH:MM."
  }
}

variable "backtrack_window" {
  type        = number
  description = "The target backtrack window, in seconds, for Aurora MySQL point-in-time backtracking. Must be > 0 to enable backtracking; 0 disables it."
  default     = 86400

  validation {
    condition     = var.backtrack_window >= 0 && var.backtrack_window <= 259200
    error_message = "backtrack_window must be between 0 and 259200 seconds (72 hours)."
  }
}

variable "availability_zone" {
  type        = string
  default     = ""
  description = "The availability zone for the primary Aurora cluster instance. Leave empty to let AWS choose."

  validation {
    condition     = var.availability_zone == "" || can(regex("^[a-z]{2}-[a-z]+-[0-9][a-z]$", var.availability_zone))
    error_message = "availability_zone must be empty or a valid AWS availability zone, e.g. eu-west-2a."
  }
}

variable "promotion_tier" {
  type        = number
  description = " Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer"
  default     = 0

  validation {
    condition     = var.promotion_tier >= 0 && var.promotion_tier <= 15
    error_message = "promotion_tier must be between 0 and 15."
  }
}

variable "monitoring_role_arn" {
  type        = string
  default     = ""
  description = "IAM role ARN used by RDS Enhanced Monitoring to publish metrics to CloudWatch Logs. Leave empty to disable enhanced monitoring."

  validation {
    condition     = var.monitoring_role_arn == "" || can(regex("^arn:aws:iam::[0-9]{12}:role/", var.monitoring_role_arn))
    error_message = "monitoring_role_arn must be empty or a valid IAM role ARN."
  }
}

variable "master_password" {
  type        = string
  sensitive   = true
  description = "Master password for the Aurora cluster."

  validation {
    condition     = length(var.master_password) >= 8 && length(var.master_password) <= 128 && !can(regex("[/\"@]", var.master_password))
    error_message = "master_password must be 8-128 characters and must not contain '/', '\"', or '@'."
  }
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(any)
  description = "Set of log types to export to cloudwatch. If omitted, no logs will be exported"
  default     = ["audit"]
  #condition must contain audit
  #valid audit, error, general, slowquery, postgresql

  validation {
    condition     = length(var.enabled_cloudwatch_logs_exports) > 0
    error_message = "enabled_cloudwatch_logs_exports must contain at least one log type."
  }
}

variable "engine" {
  type        = string
  default     = "aurora-mysql"
  description = "The database engine to use for the Aurora cluster. Only aurora-mysql is supported by this module; aurora-postgresql is not currently implemented."
  validation {
    condition     = contains(["aurora-mysql"], var.engine)
    error_message = "This module only supports aurora-mysql."
  }
}

variable "engine_version" {
  type        = string
  default     = "5.7.mysql_aurora.2.12.6"
  description = "The Aurora MySQL engine version, e.g. 5.7.mysql_aurora.2.12.6. Must be compatible with var.family."

  validation {
    condition     = !can(regex("^5\\.6", var.engine_version))
    error_message = "Aurora MySQL 5.6-compatible engine versions are no longer supported; use a 5.7 or MySQL 8.0-compatible version instead."
  }
}

variable "family" {
  type        = string
  default     = "aurora-mysql5.7"
  description = "The DB cluster parameter group family. Must be compatible with var.engine_version."

  validation {
    condition     = contains(["aurora-mysql5.7", "aurora-mysql8.0", "aurora-mysql8.4"], var.family)
    error_message = "family must be one of: aurora-mysql5.7, aurora-mysql8.0, aurora-mysql8.4."
  }
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs to associate with the Aurora cluster. Required so network access is an explicit decision rather than falling back to the VPC's default security group."

  validation {
    condition     = length(var.vpc_security_group_ids) > 0
    error_message = "vpc_security_group_ids must contain at least one security group ID."
  }
}

variable "db_subnet_group_name" {
  type        = string
  description = "The DB subnet group to associate with the Aurora cluster and its instances. Required so the cluster doesn't fall back to the account's default VPC subnets."

  validation {
    condition     = length(var.db_subnet_group_name) > 0
    error_message = "db_subnet_group_name must not be empty."
  }
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "Whether to enable deletion protection on the Aurora cluster."
}

variable "monitoring_interval" {
  type        = number
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance"
  default     = 1

  validation {
    condition     = contains([0, 1, 5, 10, 15, 30, 60], var.monitoring_interval)
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
  default     = 35

  validation {
    condition     = var.backup_retention_period >= 1 && var.backup_retention_period <= 35
    error_message = "backup_retention_period must be between 1 and 35 days."
  }
}
