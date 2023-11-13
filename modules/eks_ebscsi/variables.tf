variable "eks_addon_version_ebs_csi_driver" {
  type        = string
  description = "AWS ebs csi driver version"
  default     = null
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_oidc_arn" {
  type        = string
  description = "OIDC Arn"
}
