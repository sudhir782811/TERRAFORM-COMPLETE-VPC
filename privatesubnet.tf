resource "aws_subnet" "private_subnet" {
  count = "${length(local.azs_name)}"
  #count = "${length(slice(local.azs_name, 0, 2))}"  
  vpc_id     = "${aws_vpc.prod_vpc.id}"
  availability_zone = "${element(local.azs_name,count.index)}"
  #cidr_block = "${cidrsubnet(var.vpc_cidr, 8, length(local.azs_name) + count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, length(local.azs_name) + count.index+1)}"

  tags = {
    Name = "private-subnet-${count.index+1}"
  }
}

resource "aws_route_table" "privatert" {
  vpc_id = "${aws_vpc.prod_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    #instance_id = "${aws_instance.nat.id}"
    gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags = {
    Name = "private-rt"
  }
}

# private subnet association

resource "aws_route_table_association" "privateasso" {
count = "${length(local.azs_name)}"
#subnet_id      = "${aws_subnet.private_subnet.*.id}"
subnet_id      = "${local.pri_sub_ids[count.index]}"
route_table_id = "${aws_route_table.privatert.id}"
}