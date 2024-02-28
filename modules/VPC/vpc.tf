resource "aws_vpc" "eks-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames

  tags = {
    Name = "${terraform.workspace}-vpc"
  }
}