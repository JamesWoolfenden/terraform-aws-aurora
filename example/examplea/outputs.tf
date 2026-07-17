output "cluster" {
  value       = module.aurora.cluster
  sensitive   = true
  description = "The Aurora cluster"
}

output "instances" {
  value       = module.aurora.instances
  description = "The Aurora cluster instances"
  sensitive   = true
}
