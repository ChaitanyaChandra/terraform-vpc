# creating internet gateway for vpc
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(tomap({
    "Name" = "${local.tags.Service}-${local.Environment}-${local.env_tag.appenv}-igw"
  }), local.tags)
}

resource "aws_eip" "natIP_one" {
  vpc = true
  tags = merge(tomap({
    "Name" = "${local.tags.Service}-${local.Environment}-${local.env_tag.appenv}-nat-eip"
  }), local.tags)
}

# Creating the NAT Gateway using subnet_id and allocation_id in publicIP for internet access in private subnet
resource "aws_nat_gateway" "NATgw_one" {
  allocation_id = aws_eip.natIP_one.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = merge(tomap({
    "Name" = "${local.tags.Service}-${local.Environment}-${local.env_tag.appenv}-nat-gateway"
  }), local.tags)
}