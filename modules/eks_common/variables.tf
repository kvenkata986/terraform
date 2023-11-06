variable "aws_account" {
  type        = string
  description = "name of the aws account"
}
variable "name" {
  type        = string
  description = "name of the eks cluster"
}
variable "private_subnet_ids" {
  type        = list(string)
  description = "eks subnet ids"
}
variable "eks_version" {
  type        = string
  description = "control plane kubernetes version"
}
variable "enabled_logs" {
  type        = list(string)
  description = "list of log names to enable"
  default     = ["api", "authenticator", "controllerManager", "scheduler", "audit"]
}
variable "endpoint_private_access" {
  type        = bool
  description = "EKS creates an private endpoint for internal api requests"
  default     = true
}
