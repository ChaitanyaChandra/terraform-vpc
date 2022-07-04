data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket         = "terraform-nonprod-state-chaitu"
    key            = "terraform_ec2_spot.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-2"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment_one" {
  subnet_ids         = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]
  transit_gateway_id = data.terraform_remote_state.remote.outputs.tgw_id
  vpc_id             = aws_vpc.vpc.id
  tags = merge(tomap({
    "Name" = "${local.tags.Service}-${local.Environment}-tgw-internal-attachment"
  }), local.tags)
}