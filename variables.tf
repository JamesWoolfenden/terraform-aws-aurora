variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map
}

variable "cluster" {
  description = "All the properties of an Aurora Cluster"
  type        = map
}

variable "instances" {
  description = "Settings of you database instances"
}
