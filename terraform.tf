terraform {
  backend "s3" {
    bucket = "prajwal-terraform-remote-backend"
    key = "terraform.tfstate"
    region = "ap-south-1"
  }
}