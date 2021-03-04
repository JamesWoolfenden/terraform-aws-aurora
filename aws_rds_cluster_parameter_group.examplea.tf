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
}

/*
mysql
aws rds modify-db-cluster \
    --db-cluster-identifier mydbcluster \
    --cloudwatch-logs-export-configuration '{"EnableLogTypes":["error","general","slowquery","audit"]}'

https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Integrating.CloudWatch.html

postgresql
rds.force_ssl
ssl
ssl_max_protocol_version
ssl_min_protocol_version
pgaudit.log

https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Reference.html

*/
