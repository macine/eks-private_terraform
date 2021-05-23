resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = module.vpc.public_subnets_cidr_blocks
  }
}

resource "aws_security_group" "allow_port_443" {
  name        = "sg_vpcendpoints"
  description = "Vpc Endpoints security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpcendpoints"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "cluster_ingress_from_vpc_actual" {
	cidr_blocks = [ data.aws_vpc.vpc_actual.cidr_block ]
	from_port = 443
	to_port = 443
	protocol = "tcp"
	type = "ingress"
	security_group_id = module.eks.cluster_security_group_id
}