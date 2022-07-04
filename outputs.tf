output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "VPC_CIDR" {
  value = var.VPC_CIDR
}

output "PUBLIC_SUBNETS" {
  value = aws_subnet.public_subnet.*.id
}

output "PRIVATE_SUBNETS" {
  value = aws_subnet.private_subnet.*.id
}

output "PUBLIC_SUBNET_CIDR" {
  value = var.PUBLIC_SUBNET_CIDR
}

output "PRIVATE_SUBNET_CIDR" {
  value = var.PRIVATE_SUBNET_CIDR
}

output "PRIVATE_HOSTED_ZONE_ID" {
  value = var.PRIVATE_HOSTED_ZONE_ID
}

output "vpc_cidr" {
  value = data.terraform_remote_state.remote.outputs.vpc_cidr
}