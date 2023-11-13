locals {
  node_groups = { for ng in var.node_groups : ng.name => ng }
}

resource "aws_eks_node_group" "eks_node_group" {
  for_each = local.node_groups

  cluster_name    = var.cluster_name
  subnet_ids      = var.private_subnet_ids
  node_group_name = each.key
  node_role_arn   = aws_iam_role.eks_node_group.arn

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  ami_type = each.value.ami_type

  launch_template {
    id      = aws_launch_template.eks_template[each.key].id
    version = aws_launch_template.eks_template[each.key].latest_version
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonSSMManagedInstanceCore,
  ]
}

resource "aws_launch_template" "eks_template" {
  for_each = local.node_groups

  name_prefix   = "eks-node-group-${each.key}"
  key_name      = "meetup"
  image_id      = each.value.image_id
  instance_type = each.value.instance_types[0]

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 20
    }
  }
  user_data = base64encode(templatefile("../../modules/eks_nodes/userdata.tpl", { CLUSTER_NAME = var.cluster_name, B64_CLUSTER_CA = var.kube_ca, API_SERVER_URL = var.endpoint, CONTAINER_RUNTIME = "containerd" }))
}

resource "aws_iam_role" "eks_node_group" {
  name = "eks-node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          "Service" : [
            "ec2.amazonaws.com",
            "eks.amazonaws.com"
          ]
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group.name
}
