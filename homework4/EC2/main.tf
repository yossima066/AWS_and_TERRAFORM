data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "opsschool-yossi"
    workspase = {
      name = "VPC"
    }
  }
}

module "Ec2" {
  #source               = "..\\..\\modules\\ec2\\"
  source               = "app.terraform.io/opsschool-yossi/ec2/aws"
  version              = "1.0.0"
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  available_zone_names = data.terraform_remote_state.vpc.outputs.available_zone_names
  public_subnet_ids    = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnet_ids   = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  instance_to_create   = var.instance_to_create
  instance_type        = var.instance_type
  bucket_name          = var.bucket_name
}

