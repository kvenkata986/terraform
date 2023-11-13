data "aws_partition" "p" {}

data "aws_iam_policy" "eks_cluster" {
  arn = "arn:${data.aws_partition.p.partition}:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks_cluster_group" {
  name = "eks-cluster"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicyCluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceControllerCluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_group.name
}


resource "aws_eks_cluster" "eks" {
  name                      = var.name
  version                   = var.eks_version
  role_arn                  = aws_iam_role.eks_cluster_group.arn
  enabled_cluster_log_types = var.enabled_logs

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = var.endpoint_private_access
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicyCluster,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceControllerCluster
  ]

  tags = {
    KubernetesCluster = var.name
    cluster-name      = var.name
    account_name      = var.aws_account
  }
}
