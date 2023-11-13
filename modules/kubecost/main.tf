resource "aws_eks_addon" "kubecost" {
  count = var.eks_addon_version_kubecost != null ? 1 : 0

  cluster_name  = var.cluster_name
  addon_name    = "kubecost_kubecost"
  addon_version = var.eks_addon_version_kubecost

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  preserve = true

  tags = {
    "eks_addon" = "kubecost"
  }
}
