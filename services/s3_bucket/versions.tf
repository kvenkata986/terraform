terraform {
  backend "s3" {}
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.73"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_account
}
