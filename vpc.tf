# creating vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(tomap({
    "Name" = "${local.tags.Service}-${local.Environment}-${local.env_tag.appenv}-vpc"
  }), local.tags)
}