terraform {

  backend "s3" {
    bucket = "mymamanbucket"
    key    = "terraform/state"
    region = "us-east-1"
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

