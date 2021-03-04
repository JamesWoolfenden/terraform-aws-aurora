output "cluster" {
  value     = aws_rds_cluster.default
  sensitive = true
}

output "instances" {
  value = aws_rds_cluster_instance.instances
}
