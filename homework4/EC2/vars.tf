
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
  default     = "opsschool-yossi"
}
