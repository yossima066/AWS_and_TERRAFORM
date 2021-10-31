variable "private_key_path" {
  type    = string
  default = "D:\\terraform\\homwork.pem"
}

variable "key_name" {
  type    = string
  default = "homwork"
}


variable "vpc_id" {
  description = "Vpc ID"
  type        = string

}

variable "instance_to_create" {
  description = "Ec2 Instance to create"
  type        = number
}

variable "instance_type" {
  description = "The type of the ec2"
  type        = string

}

variable "private_subnet_ids" {
  description = "List of private subnet ids"
  type        = list(string)

}

variable "public_subnet_ids" {
  description = "List of private subnet ids"
  type        = list(string)

}

variable "ubuntu_account_number" {
  default = "099720109477"
}

variable "available_zone_names" {
  description = "List of avilabale AZ's"
  type        = list(string)
}

variable "bucket_name" {
  description = "S3 Bucket name for logs"
  type        = string
}

