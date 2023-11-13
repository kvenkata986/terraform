resource "aws_eks_addon" "aws_ebs_csi_driver" {
  count = var.eks_addon_version_ebs_csi_driver != null ? 1 : 0

  cluster_name  = var.cluster_name
  addon_name    = "aws-ebs-csi-driver"
  addon_version = var.eks_addon_version_ebs_csi_driver

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  service_account_role_arn = aws_iam_role.ebs_csi_controller_sa.arn

  preserve = true

  tags = {
    "eks_addon" = "aws-ebs-csi-driver"
  }
}

resource "aws_iam_role" "ebs_csi_controller_sa" {
  name = "ebs-csi-controller-sa"

  assume_role_policy = templatefile("../../modules/eks_ebscsi/oidc_assume_role_policy.json", {
    OIDC_ARN  = var.cluster_oidc_arn,
    OIDC_URL  = replace(var.cluster_oidc_arn, "https://", ""),
    NAMESPACE = "kube-system",
    SA_NAME   = "ebs-csi-controller-sa"
  })

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]
}

resource "kubernetes_storage_class" "ebs-sc" {
  metadata {
    name = "ebs-cs"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }
  parameters = {
    type      = "gp3"
    encrypted = "true"
  }
  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
}

resource "kubernetes_annotations" "gp2-disable-default" {
  depends_on = [
    kubernetes_storage_class.ebs-sc
  ]
  api_version = "storage.k8s.io/v1"
  kind        = "StorageClass"
  force       = "true"
  metadata {
    name = "gp2"
  }
  annotations = {
    "storageclass.kubernetes.io/is-default-class" = "false"
  }
}
