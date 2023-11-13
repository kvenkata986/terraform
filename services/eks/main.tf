module "eks_common" {
  source = "../../modules/eks_common"

  name               = var.name
  aws_account        = var.aws_account
  private_subnet_ids = var.private_subnet_ids
  eks_version        = var.eks_version
  enabled_logs       = var.enabled_logs
}

module "eks_nodes" {
  source = "../../modules/eks_nodes"

  aws_account        = var.aws_account
  private_subnet_ids = var.private_subnet_ids
  cluster_name       = module.eks_common.cluster_name
  endpoint           = module.eks_common.endpoint
  kube_ca            = module.eks_common.kube_ca
  node_groups        = var.node_groups
}

module "kube_proxy" {
  source                       = "../../modules/kube_proxy"
  cluster_name                 = module.eks_common.cluster_name
  eks_addon_version_kube_proxy = var.eks_addon_version_kube_proxy
}

module "eks_ebscsi" {
  source                           = "../../modules/eks_ebscsi"
  cluster_name                     = module.eks_common.cluster_name
  cluster_oidc_arn                 = module.eks_common.cluster_oidc_arn
  eks_addon_version_ebs_csi_driver = var.eks_addon_version_ebs_csi_driver
}

module "kubecost" {
  source                     = "../../modules/kubecost"
  cluster_name               = module.eks_common.cluster_name
  eks_addon_version_kubecost = var.eks_addon_version_kubecost
}
