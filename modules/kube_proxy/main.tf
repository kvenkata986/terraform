resource "aws_eks_addon" "kube_proxy" {
  count = var.eks_addon_version_kube_proxy != null ? 1 : 0

  cluster_name  = var.cluster_name
  addon_name    = "kube-proxy"
  addon_version = var.eks_addon_version_kube_proxy

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  preserve = true

  tags = {
    "eks_addon" = "kube-proxy"
  }
}
