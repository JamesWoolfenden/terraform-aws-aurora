variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map
}

variable "availability_zones" {
  type        = list
  description = "List of availability zones"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "cluster" {
  description = "All the properties of an Aurora Cluster"
  type        = map
}

variable "instances" {
  description = "Settings of you database instances"
}
