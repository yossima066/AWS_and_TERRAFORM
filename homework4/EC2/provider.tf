terraform {

  backend "remote" {
    organization = "mamanopsSchool"
    workspace {
      name = "EC2"
    }

  }

  required_providers {
    aws = {
      version = "~> 3.63"
    }
  }
}

provider "aws" {

  profile = "default"
  region  = "us-east-1"
}

