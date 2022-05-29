module "wrapper" {
  source      = "../../modules/s3_bucket"
  bucket      = $var.s3_bucket_name
  Name        = $var.tagname

}
