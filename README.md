# eks-private_terraform

Terraform scripts for use in AWS. It creates an new VPC usign [AWS-VPC-Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/), 
into 3 AZ (automatically obtained), and 3 kinds of subnets: public, private and intra. Also creates an Internet Gateway and a Single Nat Gateway as described at 
[NAT GW Scenarios](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.48.0#nat-gateway-scenarios).

Finally, It creates a ["private" EKS](https://docs.aws.amazon.com/eks/latest/userguide/private-clusters.html), deploying internal endpoints and a single 
node group of workers at "private" subnets. The ingress will be deployed onto intra subnets, thus isolating nodes from the rest of components. 
The nodes can be accesible using ssh from public subnets (just for this lab purposes),it can be changed modifiying 
[security_groups.tf](https://github.com/macine/eks-private_terraform/blob/master/security_groups.tf) file.

This Lab asummes an existing Main VPC where you need to generate (manually) an EC2 instance (REHL compatible) that will serve as a bastion server. 
In order to connect from this bastion to the new VPC, the script creates a VPC Peering and modify route tables on both VPC to enable traffic between them.




