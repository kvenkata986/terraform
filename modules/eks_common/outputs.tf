output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "kube_ca" {
  value = aws_eks_cluster.eks.certificate_authority.0.data
}

output "cluster_name" {
  value = aws_eks_cluster.eks.id
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}

output "cluster_service_role_arn" {
  value = aws_iam_role.eks_cluster_group.arn
}

output "cluster_service_role_name" {
  value = aws_iam_role.eks_cluster_group.name
}

output "cluster_oidc_arn" {
  value = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}
