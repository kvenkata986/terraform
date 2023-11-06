variable "aws_account" {
  type        = string
  description = "name of the aws account"
}

variable "aws_region" {
  type        = string
  description = "region, such as us-east-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}
