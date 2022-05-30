variable "name" {
  description = "Name to use on all resources created (VPC, ALB, etc)"
  type        = string
  default     = "atlantis"
}


# VPC
variable "vpc_id" {
  description = "ID of an existing VPC where resources will be created"
  type        = string
  default     = ""
}


variable "cidr" {
  description = "The CIDR block for the VPC which will be created if `vpc_id` is not specified"
  type        = string
  default     = ""
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = []
}


variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}


# Route53
variable "route53_zone_name" {
  description = "Route53 zone name to create ACM certificate in and main A-record, without trailing dot"
  type        = string
  default     = ""
}


variable "atlantis_repo_allowlist" {
  description = "List of allowed repositories Atlantis can be used with"
  type        = list(string)
}

# Github
variable "atlantis_github_user" {
  description = "GitHub username that is running the Atlantis command"
  type        = string
  default     = ""
}

variable "atlantis_github_user_token" {
  description = "GitHub token of the user that is running the Atlantis command"
  type        = string
  default     = ""
}

variable "atlantis_github_webhook_secret" {
  description = "GitHub webhook secret of an app that is running the Atlantis command"
  type        = string
  default     = ""
}