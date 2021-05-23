provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

#data "aws_security_group" "default" {
#  name   = "default"
#  vpc_id = module.vpc.vpc_id
#}

variable "current_instance_id" {
  description = "id of current Instance"
}

data "aws_instance" "current_instance" {
    instance_id = var.current_instance_id
}

data "aws_subnet" "current_subnet" {
    id = data.aws_instance.current_instance.subnet_id
}

data "aws_route_table" "current_route_table" {
  subnet_id = data.aws_subnet.current_subnet.id
}

data "aws_vpc" "vpc_actual" {
  id = data.aws_subnet.current_subnet.vpc_id
}

locals {
  cluster_name = "eks-private"
  environment = "desarrollo"
}
