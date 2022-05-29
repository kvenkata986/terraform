variable "aws_region" {
  type        = string
  description = "region name to deploy in e.g. us-east-1"
}

variable "aws_account" {
  type        = string
  description = "name of the aws account"
}

variable "s3_bucket_name" {
  type        = string
  description = "name of the bucket"
}

variable "tagname" {
  type        = string
  description = "tagname"
}
