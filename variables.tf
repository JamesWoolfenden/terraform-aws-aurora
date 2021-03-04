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

variable "monitoring_interval" {
  default = 0
}

variable "monitoring_role_arn" {
  type    = string
  default = ""
}
