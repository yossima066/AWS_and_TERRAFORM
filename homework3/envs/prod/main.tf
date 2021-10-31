module "vpc" {
  source             = "..\\..\\modules\\vpc\\"
  vpc_name           = var.vpc_name
  cidr_block         = var.cidr_block
  route_tables_names = var.route_tables_names
  availability_zones = 2

}


module "Ec2" {
  source               = "..\\..\\modules\\ec2\\"
  vpc_id               = module.vpc.vpc_id
  available_zone_names = module.vpc.available_zone_names
  public_subnet_ids    = module.vpc.public_subnet_ids
  private_subnet_ids   = module.vpc.private_subnet_ids
  instance_to_create   = var.instance_to_create
  instance_type        = var.instance_type
  bucket_name          = var.bucket_name
}
