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