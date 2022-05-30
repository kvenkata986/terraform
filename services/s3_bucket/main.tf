module "s3_bucket_creation" {

  source         = "../../modules/s3"
  s3_bucket_name = var.s3_bucket_name
  tagname        = var.tagname
  aws_region     = var.region
}
