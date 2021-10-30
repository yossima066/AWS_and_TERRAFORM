data "aws_availabilty_zone" "available" {}

data "aws_ami" "ubuntu-18" {
  most_recent = true
  owners      = [var.ubuntu_account_number]

  filter {
    name  = "name"
    valus = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
