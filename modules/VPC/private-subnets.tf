resource "aws_subnet" "private-subnet1" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = var.private-subnet1-cidr
  availability_zone = var.subnet-az1

  tags = {
    Name = "${terraform.workspace}-Private-subnet1 "
  }
}

resource "aws_subnet" "private-subnet2" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = var.private-subnet2-cidr
  availability_zone = var.subnet-az2

  tags = {
    Name = "${terraform.workspace}-Private-subnet2"
  }
}

resource "aws_eip" "eks-eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "eks-natgw" {
  allocation_id = aws_eip.eks-eip.id
  subnet_id     = aws_subnet.public-subnet2.id
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks-natgw.id
  }
}

resource "aws_route_table_association" "private-sock1" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-sock2" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.private-rt.id
}