variable "region" {
    type = "string"
    default = "eu-central-1"
}

variable "vpc_cidr" {
    type = "string"
    default = "10.0.0.0/16"
}

#variable "nat_amis" {
#    type = "map"
#    default = {
#        us-west-2 = "ami-0553ff0c22b782b45"
#        eu-central-1 = "ami-0b86f70b539318af2"
#    }
#}
