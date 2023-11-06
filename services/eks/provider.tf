provider "aws" {
  region  = var.aws_region
  profile = var.aws_account

}

data "aws_eks_cluster" "eks" {
  name = module.eks_common.cluster_name
}

provider "kubernetes" {
  host                   = module.eks_common.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.name]
    env = {
      AWS_PROFILE = var.aws_account
    }
  }
}
