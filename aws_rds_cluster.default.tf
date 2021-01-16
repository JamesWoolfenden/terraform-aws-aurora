resource "aws_rds_cluster" "default" {
  cluster_identifier = var.cluster["cluster_identifier"]
  availability_zones = data.aws_availability_zones.zones.names
  database_name      = var.cluster["database_name"]
  master_username    = var.cluster["master_username"]
  master_password    = var.cluster["master_password"]
  storage_encrypted  = true
  tags               = var.common_tags
}
