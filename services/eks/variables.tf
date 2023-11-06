variable "aws_region" {
  type        = string
  description = "region name to deploy in e.g. us-east-1"
}

variable "aws_account" {
  type        = string
  description = "name of the aws account"
}

#variable "vpc_name" {
#  type        = string
#  description = ""
#}

variable "name" {
  type        = string
  description = "name of the eks cluster"
}

variable "eks_version" {
  type        = string
  description = "control plane kubernetes version"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "subnet IDs to use for the EKS workers & control plane"
}

variable "enabled_logs" {
  type        = list(string)
  description = "list of log names to enable"
  # pick from: ["api", "authenticator", "controllerManager", "scheduler", "audit"],
  default = []
}
