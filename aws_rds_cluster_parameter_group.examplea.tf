
moved {
  from = aws_rds_cluster_parameter_group.examplea
  to   = aws_rds_cluster_parameter_group.this
}

resource "aws_rds_cluster_parameter_group" "this" {
  name        = "rds-cluster-pg"
  family      = var.family
  description = "RDS default cluster parameter group"

  parameter {
    name  = "server_audit_logging"
    value = "1"
  }

  parameter {
    name         = "tls_version"
    value        = "TLS1.2"
    apply_method = "immediate"
  }

  parameter {
    name         = "require_secure_transport"
    value        = "ON"
    apply_method = "immediate"
  }
}
