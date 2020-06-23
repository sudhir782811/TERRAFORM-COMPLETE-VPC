resource "aws_subnet" "pulic_subnet" {
  count = "${length(local.azs_name)}"  
  vpc_id     = "${aws_vpc.prod_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone = "${element(local.azs_name,count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index+1)}"

  tags = {
    Name = "public-subnet-${count.index+1}"
  }
}

resource "aws_route_table" "prod_rt" {
  vpc_id = "${aws_vpc.prod_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.prod_gw.id}"
  }
    tags = {
    Name = "public-rt"
  }
}
resource "aws_route_table_association" "public_association" {
  count = "${length(local.azs_name)}"  
  subnet_id      = "${local.pub_sub_ids[count.index]}"
  route_table_id = aws_route_table.prod_rt.id
}