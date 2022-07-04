# public subnet
resource "aws_subnet" "public_subnet" {
  count                   = length(var.PUBLIC_SUBNET_CIDR)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUBLIC_SUBNET_CIDR[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.AZS[count.index]
  tags = merge(tomap({
    "Name" = "${local.tags.Service}-${local.Environment}-${local.env_tag.appenv}-public-subnet-${count.index}"
  }), local.tags)
}


# private subnet
resource "aws_subnet" "private_subnet" {
  count             = length(var.PRIVATE_SUBNET_CIDR)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.PRIVATE_SUBNET_CIDR[count.index]
  availability_zone = var.AZS[count.index]
  tags = merge(tomap({
    "Name" = "${local.tags.Service}-${local.Environment}-${local.env_tag.appenv}-private-subnet-${count.index}"
  }), local.tags)
}