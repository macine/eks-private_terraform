# EKS private cluser implemantacion on AWS using terraform

## Overview
Terraform scripts for use in AWS. It creates an new VPC usign [AWS-VPC-Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/), 
into 3 AZ (automatically obtained), and 3 kinds of subnets: public, private and intra. Also creates an Internet Gateway and a Single Nat Gateway as described at 
[NAT GW Scenarios](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.48.0#nat-gateway-scenarios).

Finally, It creates a ["private" EKS](https://docs.aws.amazon.com/eks/latest/userguide/private-clusters.html), deploying internal endpoints and a single 
node group of workers at "private" subnets. The ingress will be deployed onto intra subnets, thus isolating nodes from the rest of components. 
The nodes can be accesible using ssh from public subnets (just for this lab purposes),it can be changed modifiying 
[security_groups.tf](https://github.com/macine/eks-private_terraform/blob/master/security_groups.tf) file.

This Lab asummes an existing Main VPC where you need to generate (manually) an EC2 instance (REHL compatible) that will serve as a bastion server. 
In order to connect from this bastion to the new VPC, the script creates a VPC Peering and modify route tables on both VPC to enable traffic between them.

## Getting Started

1. Launch an EC2 instance on your main VPC and asociate it with an elastic IP. This will be your "bastion" host. connect to it.

2. update awscli 
```shell
sudo yum install python2-pip
sudo pip install --upgrade awscli && hash -r
```

3. Install kubectl
```shell
sudo curl --silent --location -o /usr/local/bin/kubectl \
  https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
```

4. Install Terraform
```shell
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

5. configure awscli
```shell
aws configure
```

6. clone this repo
```shell
git clone https://github.com/macine/eks-private_terraform.git
```

7. execute terraform scripts
```shell
cd ~/eks-private_terraform
terraform init
terraform plan 
terraform apply
```
8. generate kubeconfig file
```shell
aws eks --region us-east-1 update-kubeconfig --name eks-private
```

## Help and Feedback
For help, please consider send me an email to macine(at)gmail.com

## Contributing
PLease feel free to contribute and make pull requests. 

## License

