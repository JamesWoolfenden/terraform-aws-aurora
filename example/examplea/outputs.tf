output "cluster" {
  value     = module.aurora.cluster
  sensitive = true
}

output "instances" {
  value = module.aurora.instances
}
