module "vpc" {
  #source             = "..\\..\\modules\\vpc\\"
  source             = "app.terraform.io/opsschool-yossi/vpc/aws"
  version            = "1.0.0"
  vpc_name           = var.vpc_name
  cidr_block         = var.cidr_block
  route_tables_names = var.route_tables_names
  availability_zones = var.availability_zones

}

