variable "cluster" {
  description = "All the properties of an Aurora Cluster"
  type        = map(any)
  default = {
    cluster_identifier = "aurora-cluster-demo"
    database_name      = "mydb"
    master_username    = "foo"
  }

  validation {
    condition     = can(var.cluster["cluster_identifier"]) && can(var.cluster["database_name"]) && can(var.cluster["master_username"])
    error_message = "cluster must include cluster_identifier, database_name, and master_username keys."
  }
}

variable "instances" {
  description = "Settings of you database instances"
  type        = list(map(any))
  validation {
    condition     = length(var.instances) > 0
    error_message = "At least one instance must be specified."
  }
  default = [{
    identifier     = "aurora-cluster-demo-1"
    instance_class = "db.r4.large"
    },
    {
      identifier     = "aurora-cluster-demo-2"
      instance_class = "db.r4.large"
  }]

}
