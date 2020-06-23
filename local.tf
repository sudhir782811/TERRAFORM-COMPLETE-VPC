locals {
    azs_name = "${data.aws_availability_zones.azs.names}"
    pub_sub_ids = "${aws_subnet.pulic_subnet.*.id}"
    pri_sub_ids = "${aws_subnet.private_subnet.*.id}"
}