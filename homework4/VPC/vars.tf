variable "vpc_name" {
  description = "VPC name"
  default     = "test"
}
variable "cidr_block" {
  description = "Cider size"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "VPC name"
  default     = "Test"
}

variable "cidr_block" {
  description = "Cider size"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zone for account"
  default     = 2
}

variable "route_tables_names" {
  description = "route table for each subnet"
  default     = ["public", "private-a", "private-b"]
}


