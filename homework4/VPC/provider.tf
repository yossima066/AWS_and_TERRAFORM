terraform {

  backend "remote" {
    organization = "opsschool-yossi"
    workspace {
      name = "Network"
    }

  }

  required_providers {
    aws = {
      version = "~> 3.63"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

