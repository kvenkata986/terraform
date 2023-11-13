variable "eks_addon_version_kube_proxy" {
  type        = string
  description = "Kube proxy managed EKS addon version."
  default     = null
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}
