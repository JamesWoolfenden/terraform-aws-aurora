data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "aurora" {
  cidr_block           = "10.90.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "aurora-demo"
  }
}

resource "aws_subnet" "aurora" {
  count             = 2
  vpc_id            = aws_vpc.aurora.id
  cidr_block        = cidrsubnet(aws_vpc.aurora.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "aurora-demo-${count.index}"
  }
}

resource "aws_db_subnet_group" "aurora" {
  name       = "aurora-demo"
  subnet_ids = aws_subnet.aurora[*].id

  tags = {
    Name = "aurora-demo"
  }
}

resource "aws_security_group" "aurora" {
  name        = "aurora-demo"
  description = "Aurora cluster access"
  vpc_id      = aws_vpc.aurora.id

  tags = {
    Name = "aurora-demo"
  }
}

resource "aws_default_security_group" "aurora" {
  vpc_id = aws_vpc.aurora.id
  # Intentionally no ingress/egress rules: the default security group must
  # not permit any traffic (CIS 5.3). Real traffic flows through
  # aws_security_group.aurora instead.
}
