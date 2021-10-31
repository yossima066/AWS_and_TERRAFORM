variable "vpc_name" {
  description = "VPC name"
  default     = "Productions"
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

variable "instance_to_create" {
  description = "Ec2 Instance to create"
  default     = 2
}

variable "instance_type" {
  description = "The type of the ec2"
  default     = "t2.micro"
}

variable "bucket_name" {
  description = "S3 Bucket name for logs"
  default     = "mymamanbucket"
}
