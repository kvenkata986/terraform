variable "eks_addon_version_kubecost" {
  type        = string
  description = "KubeCost EKS addon version"
  default     = null
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}
