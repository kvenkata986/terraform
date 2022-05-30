module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "~> 3.0"

  name            = var.name
  vpc_id          = var.vpc_id
  cidr            = var.cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # DNS (without trailing dot)
  route53_zone_name = var.route53_zone_name


  # Atlantis
  atlantis_github_user       = var.atlantis_github_user
  atlantis_github_user_token = var.atlantis_github_user_token
  atlantis_repo_allowlist    = var.atlantis_repo_allowlist

}