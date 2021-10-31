variable "vpc_name" {
  description = "VPC name"
  type        = string
}
variable "cidr_block" {
  description = "Cider size"
  type        = string
}

variable "availability_zones" {
  description = "Availability zone for account"
  type        = number
}

variable "route_tables_names" {
  description = "route table for each subnet"
  type        = list(string)

}
