module "eks" {
  source          = "D:\\terraform\\mid-project\\eks-terraform"
  vpc_id          = module.main_vpc.aws_vpc_id
  private_subnets = [module.private_subnet_1.aws_subnet_id, module.private_subnet_2.aws_subnet_id]
}
