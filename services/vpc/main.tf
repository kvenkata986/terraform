module "vpc" {
  source                     = "../../modules/vpc"
  aws_account                = var.aws_account
  aws_region                 = var.aws_region
  vpc_cidr_block             = var.vpc_cidr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
}
