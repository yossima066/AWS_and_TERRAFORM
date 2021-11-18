output "vpc_id" {
  value = module.vpc.vpc_id
}

output "available_zone_names" {
  value = module.vpc.available_zone_names
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids

}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids

}

output "route_tables_names" {
  value = module.vpc.route_tables_names
}
