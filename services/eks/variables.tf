variable "aws_region" {
  type        = string
  description = "region name to deploy in e.g. us-east-1"
}

variable "aws_account" {
  type        = string
  description = "name of the aws account"
}

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

variable "node_groups" {
  type = map(object({
    name = string
    #instance_types = list(string)
    desired_size   = number
    max_size       = number
    min_size       = number
    ami_type       = string
    instance_types = list(string)
    #release_version = string
    image_id = string
  }))
  description = "The configuration for the managed node pools."
}

variable "eks_addon_version_kube_proxy" {
  type        = string
  description = "Kube proxy managed EKS addon version."
  default     = null
}

variable "eks_addon_version_ebs_csi_driver" {
  type        = string
  description = "AWS ebs csi driver version"
  default     = null
}

variable "eks_addon_version_kubecost" {
  type        = string
  description = "KubeCost EKS addon version"
  default     = null
}
