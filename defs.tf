provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

data "aws_vpc" "vpc_actual" {
  default = true
}

locals {
  cluster_name = "eks-private"
  environment = "desarrollo"
}