module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    
    name = "vpc-macine"
    cidr = "69.0.0.0/16"

    azs             = data.aws_availability_zones.available.names
    private_subnets = ["69.0.1.0/24",  "69.0.2.0/24",  "69.0.3.0/24"]
    intra_subnets   = ["69.0.10.0/24", "69.0.11.0/24", "69.0.12.0/24"]
    public_subnets  = ["69.0.20.0/24", "69.0.21.0/24", "69.0.22.0/24"]

    intra_subnet_suffix = "sn-alb"
    private_subnet_suffix = "sn-private"
    public_subnet_suffix = "sn-public"

    enable_nat_gateway = false
    #single_nat_gateway = false
    #one_nat_gateway_per_az = false
    enable_dns_hostnames = true
    enable_dns_support   = true
    create_igw = false
    tags = {
        Terraform = true
        Environment = "${local.environment}"
        "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    }

    intra_subnet_tags = {
        "kubernetes.io/cluster/${local.cluster_name}" = "shared"
        "kubernetes.io/role/internal-elb" = 1
    }
}
