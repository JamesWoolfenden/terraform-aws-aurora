variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map
}

variable "cluster" {
  description = "All the properties of an Aurora Cluster"
  type        = map
  default = {
    cluster_identifier = "aurora-cluster-demo"
    database_name      = "mydb"
    master_username    = "foo"
    master_password    = "barbut8chars"
  }
}

variable "instances" {
  default = [{
    identifier     = "aurora-cluster-demo-1"
    instance_class = "db.r4.large"
    },
    {
      identifier     = "aurora-cluster-demo-2"
      instance_class = "db.r4.large"
  }]
}
