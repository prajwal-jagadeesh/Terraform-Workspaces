resource "aws_instance" "ec2"{
    ami = var.ami
    instance_type = var.instance_type
    security_groups = [var.security_group_id]

    tags = {
        Name = "mywebserver-${terraform.workspace}"
    }
}
