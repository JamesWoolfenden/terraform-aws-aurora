output "cluster" {
  value       = aws_rds_cluster.default
  sensitive   = true
  description = "The cluster"
}

output "instances" {
  value       = aws_rds_cluster_instance.instances
  sensitive   = true
  description = "The cluster instances"
}
