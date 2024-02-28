output "private-subnet1" {
  value = aws_subnet.private-subnet1.id
}

output "private-subnet2" {
  value = aws_subnet.private-subnet2.id
}

output "public-subnet1" {
  value = aws_subnet.public-subnet1.id
}

output "public-subnet2" {
  value = aws_subnet.public-subnet2.id
}

output "VPC_id" {
  value = aws_vpc.eks-vpc.id
}