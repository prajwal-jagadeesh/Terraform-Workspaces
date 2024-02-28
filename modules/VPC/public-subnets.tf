resource "aws_subnet" "public-subnet1" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.public-subnet1-cidr
  availability_zone       = var.subnet-az1
  map_public_ip_on_launch = true

  tags = {
    Name = "${terraform.workspace}-Public-subnet1"
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.public-subnet2-cidr
  availability_zone       = var.subnet-az2
  map_public_ip_on_launch = true

  tags = {
    Name = "${terraform.workspace}-Public-subnet2"
  }
}

resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "${terraform.workspace}-igw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }
}

resource "aws_route_table_association" "public-sock1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-sock2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.public-rt.id
}
