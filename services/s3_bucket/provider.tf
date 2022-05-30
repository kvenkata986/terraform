terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16.0"
    }
  }
}

provider "aws" {
<<<<<<< HEAD
  region     = var.region
=======
  region     = "us-east-1"
>>>>>>> 4fbb3b4c3ce10246fb31b84769898dd0cd1016a7
}
