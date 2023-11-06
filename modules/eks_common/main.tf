data "aws_partition" "p" {}

data "aws_iam_policy" "eks_cluster" {
  arn = "arn:${data.aws_partition.p.partition}:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eksservice" {
  name               = "eks_cfn_service_role"
  assume_role_policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": "AllowEKSAssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  role       = aws_iam_role.eksservice.id
  policy_arn = data.aws_iam_policy.eks_cluster.id
}

resource "aws_eks_cluster" "eks" {
  name                      = var.name
  version                   = var.eks_version
  role_arn                  = aws_iam_role.eksservice.arn
  enabled_cluster_log_types = var.enabled_logs

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = var.endpoint_private_access
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster]

  tags = {
    KubernetesCluster = var.name
    cluster-name      = var.name
    account_name      = var.aws_account
  }
}
