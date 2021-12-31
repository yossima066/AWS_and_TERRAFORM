module "Consul" {
  source    = "D:\\terraform\\opsschool\\service_discovery\\HW1"
  vpc_id    = module.main_vpc.aws_vpc_id
  subnet_id = [module.private_subnet_1.aws_subnet_id, module.private_subnet_2.aws_subnet_id]

}
