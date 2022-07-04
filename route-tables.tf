# Creating RT for Public Subnet one
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0" # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
  }
  route {
    cidr_block         = "172.16.0.0/21"
    transit_gateway_id = data.terraform_remote_state.remote.outputs.tgw_id
  }
  tags = merge(tomap({
    "Name" = "${local.tags.Service}-${local.Environment}-${local.env_tag.appenv}-public-route-table"
  }), local.tags)
  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_one]
}

# Route table Association with Public Subnet
resource "aws_route_table_association" "PublicRT_association" {
  count          = length(var.PUBLIC_SUBNET_CIDR)
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}

# Creating RT for Private Subnet
resource "aws_route_table" "private_route_table_one" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0" # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.NATgw_one.id
  }
  route {
    cidr_block         = "172.16.0.0/21"
    transit_gateway_id = data.terraform_remote_state.remote.outputs.tgw_id
  }
  tags = merge(tomap({
    "Name" = "${local.tags.Service}-${local.Environment}-${local.env_tag.appenv}-private-route-table"
  }), local.tags)
  depends_on = [aws_ec2_transit_gateway_vpc_attachment.tgw_attachment_one]
}

# Route table Association with Private Subnet
resource "aws_route_table_association" "PrivateRT_association" {
  count          = length(var.PRIVATE_SUBNET_CIDR)
  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
  route_table_id = aws_route_table.private_route_table_one.id
}