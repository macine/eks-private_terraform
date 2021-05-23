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
