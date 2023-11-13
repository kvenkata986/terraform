output "endpoint" {
  value = module.eks_common.endpoint
}

output "cluster_name" {
  value = module.eks_common.cluster_name
}

output "eks_version" {
  value = var.eks_version
}

output "cluster_security_group_id" {
  value = module.eks_common.cluster_security_group_id
}

output "cluster_service_role_arn" {
  value = module.eks_common.cluster_service_role_arn
}

output "cluster_service_role_name" {
  value = module.eks_common.cluster_service_role_name
}

output "cluster_oidc_arn" {
  value = module.eks_common.cluster_oidc_arn
}
