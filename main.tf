module "ec2" {
  source            = "./modules/ec2"
  ami               = var.ami
  instance_type     = var.instance_type
  security_group_id = module.sg.security_group_id
}

module "sg" {
  source     = "./modules/sg"
  ssh_port   = var.ssh_port
  http_port  = var.http_port
  https_port = var.https_port
  protocol   = var.protocol
}

module "EKS-VPC" {
  source               = "./modules/VPC"
  vpc_cidr             = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  dns_support          = var.dns_support
  dns_hostnames        = var.dns_hostnames
  public-subnet1-cidr  = var.public-subnet1-cidr
  public-subnet2-cidr  = var.public-subnet2-cidr
  private-subnet1-cidr = var.private-subnet1-cidr
  private-subnet2-cidr = var.private-subnet2-cidr
  subnet-az1           = var.subnet-az1
  subnet-az2           = var.subnet-az2
}

module "EKS" {
  source            = "./modules/EKS"
  security_group_id = module.sg.security_group_id
  vpc_id            = module.EKS-VPC.VPC_id
  subnet_ids = [
    module.EKS-VPC.public-subnet1,
    module.EKS-VPC.public-subnet2,
    module.EKS-VPC.private-subnet1,
    module.EKS-VPC.private-subnet2
  ]
}