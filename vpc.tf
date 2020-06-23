provider "aws" {
  region  = "${var.region}"
}
terraform {
  backend "s3" {
    bucket = "sududu"
    key    = "log/tf.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terra-lock"
  }
}
resource "aws_vpc" "prod_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    Name = "terra_vpc"
  }
}

resource "aws_internet_gateway" "prod_gw" {
  vpc_id = "${aws_vpc.prod_vpc.id}"

  tags = {
    Name = "prod-igw"
  }
}