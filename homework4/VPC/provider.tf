
provider "aws" {
  region = var.region
}

terraform {

  backend "remote" {
    organization = "opsschool-yossi"
    workspace {
      name = "Network"
    }

  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.65"
    }
  }
}




