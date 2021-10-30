terraform {
  required_version = "1.0.8"

  required_providers {
    aws = {
      version = "~> 3.63"
    }
  }
}

provider "aws" {

  profile = "default"
  region  = var.aws_region

  default_tags {
    tags = {
      Owner   = var.owner_tag
      Purpose = var.purpose_tag
    }
  }
}

