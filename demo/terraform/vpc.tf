resource "aws_vpc" "vpc" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = var.vpc_cidr_block
  enable_dns_hostnames             = true

  tags = {
    Name = "${var.system_name}-${var.env_name}-vpc"
  }
}
