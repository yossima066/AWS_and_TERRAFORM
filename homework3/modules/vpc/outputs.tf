output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "available_zone_names" {
  value = data.aws_availability_zones.available.names
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id

}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "route_tables_names" {
  value = aws_route_table.route_table.*.id
}
