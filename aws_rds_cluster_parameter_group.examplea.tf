resource "aws_rds_cluster_parameter_group" "examplea" {
  name = "rds-cluster-pg"
  //check as aurora 5.6 has no tls 1.2 support for mysql
  family      = "aurora5.7"
  description = "RDS default cluster parameter group"

  //should have a check
  parameter {
    name  = "server_audit_logging"
    value = "ON"
  }

  //should have a check
  parameter {
    name  = "tls_version"
    value = "TLS 1.2"
  }

  parameter {
    name  = "log_statement"
    value = "all"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1"
  }
}
