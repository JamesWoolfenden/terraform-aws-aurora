resource "aws_rds_cluster_instance" "instances" {
  count              = length(var.instances)
  identifier         = var.instances[count.index]["identifier"]
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = var.instances[count.index]["instance_class"]
  tags               = var.common_tags
}
