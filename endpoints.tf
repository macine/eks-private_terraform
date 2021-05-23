################################ EKS SPECIFIC VPC ENDPOINTS ##############################

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.us-east-1.s3"
  tags = { Name = "S3", Type = "endpoint_s3"}
}

resource "aws_vpc_endpoint_route_table_association" "private_s3_assoc_0" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = module.vpc.private_route_table_ids[0]
}

resource "aws_vpc_endpoint_route_table_association" "private_s3_assoc_1" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = module.vpc.private_route_table_ids[0]
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-east-1.ec2"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_port_443.id,]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = { Name = "EC2", Type = "endpoint_ec2" }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-east-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_port_443.id,]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = { Name = "ECR_DKR", Type = "endpoint_dkr" }
}

resource "aws_vpc_endpoint" "elasticloadbalancing" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-east-1.elasticloadbalancing"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_port_443.id,]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = { Name = "ELASTICLOADBALANCING", Type = "endpoint_elasticloadbalancing" }
}

resource "aws_vpc_endpoint" "autoscaling" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-east-1.autoscaling"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_port_443.id,]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = { Name = "AUTOSCALING", Type = "endpoint_autoscaling" }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-east-1.logs"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_port_443.id,]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = { Name = "LOGS", Type = "endpoint_logs" }
}

resource "aws_vpc_endpoint" "sts" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-east-1.sts"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_port_443.id,]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = { Name = "STS", Type = "endpoint_sts" }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-east-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_port_443.id,]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = { Name =  "ECR_API", Type = "endpoint_api" }
}

resource "aws_vpc_endpoint" "app_mesh" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.us-east-1.appmesh-envoy-management"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_port_443.id,]
  subnet_ids          = module.vpc.private_subnets
  private_dns_enabled = true
  tags                = { Name =  "ECR_API", Type = "endpoint_api" }
}

