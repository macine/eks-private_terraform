module "eks" {
  create_eks = false
  source       = "terraform-aws-modules/eks/aws"
  cluster_version = "1.20"
  cluster_name = "${local.cluster_name}"
  subnets      = module.vpc.private_subnets
  cluster_endpoint_private_access = "true"
  cluster_endpoint_public_access = "false"
  tags = {
    Environment = "${local.environment}"
  }

  vpc_id = module.vpc.vpc_id
  
  node_groups = {
    example = {
      desired_capacity = 3
      instance_type = "t2.small"
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate  = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file         = false
  version                = "~> 1.9"
}
