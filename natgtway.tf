resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${local.pub_sub_ids[1]}"

  tags = {
    Name = "NAT_GW"
  }
}