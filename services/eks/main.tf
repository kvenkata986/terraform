# eks common module
module "eks_common" {
  source = "../../modules/eks_common"

  name               = var.name
  aws_account        = var.aws_account
  private_subnet_ids = var.private_subnet_ids
  eks_version        = var.eks_version
  enabled_logs       = var.enabled_logs
}
